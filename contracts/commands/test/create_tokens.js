import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import { sendTransactionWithFunding, getGenesisAddress } from "../utils.js"

const command = "create_tokens"
const describe = "Create tokens and send them to user address"
const builder = {
  number: {
    describe: "Number of token to create",
    demandOption: false,
    type: "number"
  },
}

const handler = async function(argv) {
  const envName = "local"
  const env = config.environments[envName]

  const archethic = new Archethic(env.endpoint)
  await archethic.connect()

  const userAddress = getGenesisAddress(env.userSeed)
  console.log("user address:", userAddress)

  const numberOfToken = argv["number"] ? argv["number"] : 2

  const transactions = Array.from({ length: numberOfToken }, (_value, index) => index).map(nb => {
    const seed = "token" + nb
    const tx = createTokenTx(archethic, seed, userAddress)
    console.log(seed, ":", Utils.uint8ArrayToHex(tx.address))
    return tx
  })

  for (let tx of transactions) {
    await sendTransactionWithFunding(tx, null, archethic, env.userSeed)
  }

  process.exit(0)
}

function createTokenTx(archethic, seed, userAddress) {
  const supply = 1_000_000 * 1e8

  const tokenDefinition = {
    aeip: [2, 8, 18, 19],
    supply: supply,
    type: "fungible",
    symbol: seed,
    name: seed,
    properties: {},
    recipients: [
      {
        to: userAddress,
        amount: supply
      }
    ]
  }

  return archethic.transaction.new()
    .setType("token")
    .setContent(JSON.stringify(tokenDefinition))
    .build(seed, 0)
    .originSign(Utils.originPrivateKey)
}

export default {
  command,
  describe,
  builder,
  handler
}
