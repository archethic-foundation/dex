import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import { getGenesisAddress, getPoolSeed, getTokenAddress } from "../utils.js"

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
  const lpTokenAmount = argv["lp_token_amount"]

  const poolSeed = getPoolSeed(token1Name, token2Name)
  const poolGenesisAddress = getGenesisAddress(poolSeed)

  const lpTokenAddress = getTokenAddress(poolSeed)

  const userAddress = getGenesisAddress(env.userSeed)
  const index = await archethic.transaction.getTransactionIndex(userAddress)
  console.log("User genesis address:", userAddress)

  const burnAddress = "00000000000000000000000000000000000000000000000000000000000000000000"

  const tx = archethic.transaction.new()
    .setType("transfer")
    .addRecipient(poolGenesisAddress, "remove_liquidity")
    .addTokenTransfer(burnAddress, Utils.toBigInt(lpTokenAmount), lpTokenAddress)
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
