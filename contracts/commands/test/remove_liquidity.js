import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import { getGenesisAddress, getServiceGenesisAddress, getTokenAddress } from "../utils.js"

const command = "remove_liquidity"
const describe = "Remove liquidity from a pool"
const builder = {
  token1: {
    describe: "First token name",
    demandOption: true,
    type: "string"
  },
  token2: {
    describe: "Second token name",
    demandOption: true,
    type: "string"
  },
  lp_token_amount: {
    describe: "Lp token to remove",
    demandOption: true,
    type: "number"
  }
}

const handler = async function(argv) {
  const envName = argv["env"] ? argv["env"] : "local"
  const env = config.environments[envName]

  const keychainAccessSeed = argv["access_seed"] ? argv["access_seed"] : env.keychainAccessSeed

  if (keychainAccessSeed == undefined) {
    console.log("Keychain access seed not defined")
    process.exit(1)
  }

  const archethic = new Archethic(env.endpoint)
  await archethic.connect()

  let keychain
  try {
    keychain = await archethic.account.getKeychain(keychainAccessSeed)
  } catch (err) {
    console.log(err)
    process.exit(1)
  }

  const token1Name = argv["token1"]
  const token2Name = argv["token2"]
  const lpTokenAmount = argv["lp_token_amount"]

  const token1Address = getTokenAddress(token1Name)
  const token2Address = getTokenAddress(token2Name)

  const routerAddress = getServiceGenesisAddress(keychain, "Router")

  const poolInfos = await archethic.network.callFunction(routerAddress, "get_pool_addresses", [token1Address, token2Address])

  if (poolInfos == null) {
    console.log("No pool exist for these tokens")
    process.exit(1)
  }

  const userAddress = getGenesisAddress(env.userSeed)
  const index = await archethic.transaction.getTransactionIndex(userAddress)
  console.log("User genesis address:", userAddress)

  const burnAddress = "00000000000000000000000000000000000000000000000000000000000000000000"

  const tx = archethic.transaction.new()
    .setType("transfer")
    .addRecipient(poolInfos.address, "remove_liquidity")
    .addTokenTransfer(burnAddress, Utils.toBigInt(lpTokenAmount), poolInfos.lp_token_address)
    .build(env.userSeed, index)
    .originSign(Utils.originPrivateKey)

  tx.on("requiredConfirmation", (_confirmations) => {
    console.log("Remove liquidity success !")
    const address = Utils.uint8ArrayToHex(tx.address)
    console.log("Address:", address)
    console.log(env.endpoint + "/explorer/transaction/" + address)
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
