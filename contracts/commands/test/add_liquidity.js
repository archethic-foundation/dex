import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import { getGenesisAddress, getPoolSeed, getTokenAddress } from "../utils.js"

const command = "add_liquidity"
const describe = "Add liquidity to a pool"
const builder = {
  token1: {
    describe: "First token name",
    demandOption: true,
    type: "string"
  },
  token1_amount: {
    describe: "First token amount",
    demandOption: true,
    type: "integer"
  },
  token2: {
    describe: "Second token name",
    demandOption: true,
    type: "string"
  },
  token2_amount: {
    describe: "Second token amount",
    demandOption: true,
    type: "integer"
  },
  slippage: {
    describe: "Slippage in percentage (2 = 2%) to apply. Default 2",
    demandOption: false,
    type: "integer"
  }
}

const handler = async function(argv) {
  const envName = "local"
  const env = config.environments[envName]

  const archethic = new Archethic(env.endpoint)
  await archethic.connect()

  const token1Name = argv["token1"]
  const token2Name = argv["token2"]
  const token1Amount = argv["token1_amount"]
  const token2Amount = argv["token2_amount"]
  const slippage = argv["slippage"] ? argv["slippage"] : 2

  // Sort token by address
  const [token1, token2] =
    [
      { address: getTokenAddress(token1Name), amount: token1Amount },
      { address: getTokenAddress(token2Name), amount: token2Amount }
    ].sort((a, b) => a.address < b.address ? -1 : 1)

  const poolSeed = getPoolSeed(token1Name, token2Name)
  const poolGenesisAddress = getGenesisAddress(poolSeed)

  const userAddress = getGenesisAddress(env.userSeed)
  const index = await archethic.transaction.getTransactionIndex(userAddress)
  console.log("User genesis address:", userAddress)

  const minToken1Amount = token1.amount * ((100 - slippage) / 100)
  const minToken2Amount = token2.amount * ((100 - slippage) / 100)

  const tx = archethic.transaction.new()
    .setType("transfer")
    .addRecipient(poolGenesisAddress, "add_liquidity", [minToken1Amount, minToken2Amount])
    .addTokenTransfer(poolGenesisAddress, Utils.toBigInt(token1.amount), token1.address)
    .addTokenTransfer(poolGenesisAddress, Utils.toBigInt(token2.amount), token2.address)
    .build(env.userSeed, index)
    .originSign(Utils.originPrivateKey)

  tx.on("requiredConfirmation", (_confirmations) => {
    console.log("Adding liquidity success !")
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
