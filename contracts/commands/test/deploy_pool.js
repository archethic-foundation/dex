import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import {
  sendTransactionWithFunding,
  getGenesisAddress,
  encryptSecret,
  getStateCode,
  getTokenAddress,
  getServiceGenesisAddress
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

  const token1 = argv["token1"]
  const token2 = argv["token2"]

  const token1Address = getTokenAddress(token1)
  const token2Address = getTokenAddress(token2)

  const poolSeed = token1 + token2

  const poolGenesisAddress = getGenesisAddress(poolSeed)
  console.log("Pool genesis address:", poolGenesisAddress)

  const routerAddress = getServiceGenesisAddress(keychain, "Router")
  const stateContractAddress = getGenesisAddress(poolSeed + "_state")

  const poolInfos = await archethic.network.callFunction(routerAddress, "get_pool_infos", [token1Address, token2Address])
  if (poolInfos != null) {
    console.log("Pool already exists for these tokens")
    process.exit(1)
  }

  // We could batch those requests but archehic sdk do not allow batch request for now
  const poolCode = await getPoolCode(archethic, token1Address, token2Address, poolSeed, routerAddress, stateContractAddress)
  const tokenDefinition = await archethic.network.callFunction(routerAddress, "get_lp_token_definition", [token1, token2])

  const storageNonce = await archethic.network.getStorageNoncePublicKey()
  const { encryptedSecret, authorizedKeys } = encryptSecret(poolSeed, storageNonce)

  const tx = archethic.transaction.new()
    .setType("token")
    .setContent(tokenDefinition)
    .setCode(poolCode)
    .addOwnership(encryptedSecret, authorizedKeys)
    .addRecipient(routerAddress, "add_pool", [token1Address, token2Address, stateContractAddress])
    .build(poolSeed, 0)
    .originSign(Utils.originPrivateKey)

  sendTransactionWithFunding(tx, null, archethic, env.userSeed)
    .then(() => deployState(archethic, poolGenesisAddress, poolSeed, env.userSeed, storageNonce))
    .then(() => process.exit(0))
    .catch(() => process.exit(1))
}

async function getPoolCode(archethic, token1Address, token2Address, poolSeed, routerAddress, stateContractAddress) {
  const poolGenesisAddress = getGenesisAddress(poolSeed)
  const lpTokenAddress = getTokenAddress(poolSeed)

  const params = [token1Address, token2Address, poolGenesisAddress, lpTokenAddress, stateContractAddress]

  return archethic.network.callFunction(routerAddress, "get_pool_code", params)
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
