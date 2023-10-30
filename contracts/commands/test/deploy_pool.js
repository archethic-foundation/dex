import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import {
  sendTransactionWithFunding,
  getGenesisAddress,
  getPoolCode,
  encryptSecret,
  getPoolSeed,
  getTokenDefinition,
  getStateCode
} from "../utils.js"

const command = "deploy_pool"
const describe = "Deploy a pool for the token specified"
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
  }
}

const handler = async function(argv) {
  const envName = "local"
  const env = config.environments[envName]

  const archethic = new Archethic(env.endpoint)
  await archethic.connect()

  const token1 = argv["token1"]
  const token2 = argv["token2"]

  const poolSeed = getPoolSeed(token1, token2)

  const poolGenesisAddress = getGenesisAddress(poolSeed)
  console.log("Pool genesis address:", poolGenesisAddress)

  const poolCode = getPoolCode(token1, token2)
  const tokenDefinition = getTokenDefinition("lp_" + token1 + token2)

  const storageNonce = await archethic.network.getStorageNoncePublicKey()
  const { encryptedSecret, authorizedKeys } = encryptSecret(poolSeed, storageNonce)

  const tx = archethic.transaction.new()
    .setType("token")
    .setContent(tokenDefinition)
    .setCode(poolCode)
    .addOwnership(encryptedSecret, authorizedKeys)
    .build(poolSeed, 0)
    .originSign(Utils.originPrivateKey)

  sendTransactionWithFunding(tx, null, archethic, env.userSeed)
    .then(() => deployState(archethic, poolGenesisAddress, poolSeed, env.userSeed, storageNonce))
    .then(() => process.exit(0))
    .catch(() => process.exit(1))
}

async function deployState(archethic, poolGenesisAddress, poolSeed, userSeed, storageNonce) {
  console.log("=======================")
  console.log("Deploying contract state")
  const stateSeed = poolSeed + "_state"
  const code = getStateCode(poolGenesisAddress)
  const { encryptedSecret, authorizedKeys } = encryptSecret(stateSeed, storageNonce)
  const tx = archethic.transaction.new()
    .setType("contract")
    .setCode(code)
    .setContent("{}")
    .addOwnership(encryptedSecret, authorizedKeys)
    .build(stateSeed, 0)
    .originSign(Utils.originPrivateKey)

  return sendTransactionWithFunding(tx, null, archethic, userSeed)
}

export default {
  command,
  describe,
  builder,
  handler
}
