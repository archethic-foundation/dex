import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import { getServiceGenesisAddress, sendWithWallet } from "../utils.js"
import { getProposeTransaction } from "@archethicjs/multisig-sdk"

const command = "update_farms"
const describe = "Update all farm code"
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
  const index = await archethic.transaction.getTransactionIndex(masterGenesisAddress)

  if (argv["with_multisig"]) {
    const updateTx = getProposeTransaction(archethic, masterGenesisAddress, {
      recipients: [
        { address: routerGenesisAddress, action: "update_farms_code" }
      ]
    })
    sendWithWallet(updateTx, archethic)
      .then(() => process.exit(0))
      .catch(() => process.exit(1))

    return
  }

  let updateTx = archethic.transaction.new()
    .setType("transfer")
    .addRecipient(routerGenesisAddress, "update_farms_code")

  updateTx = keychain.buildTransaction(updateTx, "Master", index).originSign(Utils.originPrivateKey)

  updateTx.on("requiredConfirmation", async (_confirmations) => {
    const txAddress = Utils.uint8ArrayToHex(updateTx.address)
    console.log("Transaction validated !")
    console.log("Address:", txAddress)
    console.log(env.endpoint + "/explorer/transaction/" + txAddress)
    process.exit(0)
  }).on("error", (context, reason) => {
    console.log("Error while sending transaction")
    console.log("Contest:", context)
    console.log("Reason:", reason)
    process.exit(1)
  }).send(50)
}

export default {
  command,
  describe,
  builder,
  handler
}
