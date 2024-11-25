import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import { getRouterCode, getServiceGenesisAddress, sendTransactionWithFunding, sendTransactionWithoutFunding } from "../utils.js"

const command = "deploy_router"
const describe = "Deploy the router"
const builder = {
  access_seed: {
    describe: "The Keychain access seed (default in env config)",
    demandOption: false,
    type: "string"
  },
  env: {
    describe: "The environment config to use (default to local)",
    demandOption: false,
    type: "string"
  },
  without_funding: {
    describe: "Determines if the funding must be disabled",
    demandOption: false,
    type: "boolean",
    default: false
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

  const routerGenesisAddress = getServiceGenesisAddress(keychain, "Router")
  console.log("Router genesis address:", routerGenesisAddress)

  const routerCode = getRouterCode(keychain)

  const index = await archethic.transaction.getTransactionIndex(routerGenesisAddress)
  if (index > 0) {
    console.log("Router already exists !")
    process.exit(1)
  }

  const storageNonce = await archethic.network.getStorageNoncePublicKey()
  const { secret, authorizedPublicKeys } = keychain.ecEncryptServiceSeed("Router", [storageNonce])

  let routerTx = archethic.transaction.new()
    .setType("contract")
    .setCode(routerCode)
    .addOwnership(secret, authorizedPublicKeys)

  routerTx = keychain.buildTransaction(routerTx, "Router", index).originSign(Utils.originPrivateKey)

  if (argv["without_funding"]) {
    sendTransactionWithoutFunding(routerTx, archethic)
      .then(() => process.exit(0))
      .catch(() => process.exit(1))
  }
  else {
    sendTransactionWithFunding(routerTx, keychain, archethic)
      .then(() => process.exit(0))
      .catch(() => process.exit(1))
  }
}

export default {
  command,
  describe,
  builder,
  handler
}
