import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import { getGenesisAddress, getPoolSeed, getTokenAddress } from "../utils.js"

const command = "swap"
const describe = "Swap exact token for token"
const builder = {
  token1: {
    describe: "First token name (token to send)",
    demandOption: true,
    type: "string"
  },
  token2: {
    describe: "Second token name (token to receive)",
    demandOption: true,
    type: "string"
  },
  token1_amount: {
    describe: "Amount of token to send",
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
  const slippage = argv["slippage"] ? argv["slippage"] : 2

  const poolSeed = getPoolSeed(token1Name, token2Name)
  const poolGenesisAddress = getGenesisAddress(poolSeed)

  const token1Address = getTokenAddress(token1Name)
  const token2Address = getTokenAddress(token2Name)

  const userAddress = getGenesisAddress(env.userSeed)
  const index = await archethic.transaction.getTransactionIndex(userAddress)
  console.log("User genesis address:", userAddress)

  const outputAmount = await getOutputAmount(archethic, token1Address, token2Address, token1Amount, poolGenesisAddress)
  const minToReceive = outputAmount * ((100 - slippage) / 100)

  const tx = archethic.transaction.new()
    .setType("transfer")
    .addRecipient(poolGenesisAddress, "swap", [minToReceive])
    .addTokenTransfer(poolGenesisAddress, Utils.toBigInt(token1Amount), token1Address)
    .build(env.userSeed, index)
    .originSign(Utils.originPrivateKey)

  tx.on("requiredConfirmation", (_confirmations) => {
    console.log("Swap success !")
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

async function getOutputAmount(archethic, token1Address, token2Address, amount, poolAddress) {
  const { token: tokens } = await archethic.network.getBalance(poolAddress)

  const token1 = tokens.find(token => token.address == token1Address.toUpperCase())
  const token2 = tokens.find(token => token.address == token2Address.toUpperCase())

  const amountWithFee = Utils.toBigInt(amount * 0.997)

  return Utils.fromBigInt((amountWithFee * token2.amount) / (amountWithFee + token1.amount))
}

export default {
  command,
  describe,
  builder,
  handler
}
