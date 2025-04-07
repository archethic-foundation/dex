import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import { getServiceGenesisAddress, sendWithWallet } from "../utils.js"
import { getProposeTransaction } from "@archethicjs/multisig-sdk"

const command = "update_pools"
const describe = "Update all pool code"
const builder = {
  access_seed: {
    describe: "the keychain access seed (default in env config)",
    demandOption: false,
    type: "string"
  },
  env: {
    describe: "The environment config to use (default to local)",
    demandOption: false,
    type: "string"
  },
  with_multisig: {
    describe: "Determines if the master is using a multisig",
    demandOption: false,
    type: "boolean",
    default: false
  },
}

const handler = async function(argv) {
  const envName = argv["env"] ? argv["env"] : "local"
  const env = config.environments[envName]

  const keychainAccessSeed = argv["access_seed"] ? argv["access_seed"] : env.keychainAccessSeed

  if (keychainAccessSeed == undefined) {
    console.log("Keychain access seed not defined")
    process.exit(1)
  }

  const archethic = new Archethic(argv["with_multisig"] ? undefined : env.endpoint)
  if (archethic.rpcWallet) {
    archethic.rpcWallet.setOrigin({ name: "Archethic DEX CLI" });
  }
  await archethic.connect()

  let keychain

  try {
    keychain = await archethic.account.getKeychain(keychainAccessSeed)
  } catch (err) {
    console.log(err)
    process.exit(1)
  }

  const routerGenesisAddress = getServiceGenesisAddress(keychain, "Router")

  const indexRouter = await archethic.transaction.getTransactionIndex(routerGenesisAddress)
  if (indexRouter == 0) {
    console.log("Router doesn't exist")
    process.exit(1)
  }

  const masterGenesisAddress = getServiceGenesisAddress(keychain, "Master")
  console.log("Master genesis address:", masterGenesisAddress)

  const pools = await archethic.network.callFunction(routerGenesisAddress, "get_pool_list", [])

  const chunkSize = 10;
  for (let i = 0; i < pools.length; i += chunkSize) {
    const chunk = pools.slice(i, i + chunkSize).map(poolInfo => poolInfo.address);
    await sendUpdateTx(archethic, chunk, routerGenesisAddress, masterGenesisAddress, keychain, argv["with_multisig"])
  }

  process.exit(0)
}

async function sendUpdateTx(archethic, chunk, routerAddress, masterAddress, keychain, withMultisig) {
  return new Promise(async (resolve, _reject) => {
    if (withMultisig) {
      const updateTx = getProposeTransaction(archethic, masterAddress, {
        recipients: [
          { address: routerAddress, action: "update_pools_code", args: [chunk] }
        ]
      })
      sendWithWallet(updateTx, archethic)
        .then(() => process.exit(0))
        .catch(() => process.exit(1))
  
      return
    }

    let updateTx = archethic.transaction.new()
      .setType("transfer")
      .addRecipient(routerAddress, "update_pools_code", [chunk])

    const index = await archethic.transaction.getTransactionIndex(masterAddress)

    updateTx = keychain.buildTransaction(updateTx, "Master", index).originSign(Utils.originPrivateKey)

    updateTx.on("requiredConfirmation", async (_confirmations) => {
      const txAddress = Utils.uint8ArrayToHex(updateTx.address)
      console.log("Transaction validated !")
      console.log("Address:", txAddress)
      await new Promise(r => setTimeout(r, 2000));
      resolve()
    }).on("error", (context, reason) => {
      console.log("Error while sending transaction")
      console.log("Contest:", context)
      console.log("Reason:", reason)
      process.exit(1)
    }).send(60)
  })
}

export default {
  command,
  describe,
  builder,
  handler
}
