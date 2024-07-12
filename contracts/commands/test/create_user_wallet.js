import Archethic, { Utils, Keychain, Crypto } from "@archethicjs/sdk"
import config from "../../config.js"
import { getServiceGenesisAddress } from "../utils.js"

const command = "create_user_wallet"
const describe = "Create a user wallet"
const builder = {
  access_seed: {
    describe: "Keychain Access seed",
    demandOption: true,
    type: "string"
  },
  service_name: {
    describe: "Service name of the keychain",
    demandOption: false,
    type: "string"
  },
}

const handler = async function (argv) {
  const envName = argv["env"] ? argv["env"] : "local"
  const env = config.environments[envName]

  const keychainAccessSeed = argv["access_seed"];
  const serviceName = argv["service_name"] ? argv["service_name"] : 'archethic-wallet-no-name';

  if (keychainAccessSeed == undefined) {
    console.log("Keychain access seed not defined")
    process.exit(1)
  }

  const archethic = new Archethic(env.endpoint)
  await archethic.connect()

  try {
    const keychain = await archethic.account.getKeychain(keychainAccessSeed)
    const keychainAddress = getGenesisAddress(keychain.seed)
    console.log("Keychain already exists !")
    console.log("Keychain address:", keychainAddress)
    process.exit(1)
  } catch (_err) { }

  const { publicKey: accessPublicKey } = Crypto.deriveKeyPair(keychainAccessSeed, 0)

  const keychainSeed = serviceName + "seed"
  const keychain = new Keychain(keychainSeed)
    .addService(serviceName, "m/650'/" + serviceName + "/0")
    .addAuthorizedPublicKey(accessPublicKey);


  console.log("Service genesis address:", getServiceGenesisAddress(keychain, serviceName))

  const keychainGenesisAddress = Crypto.deriveAddress(keychain.seed, 0)
  const keychainAccessTx = archethic.account.newAccessTransaction(keychainAccessSeed, keychainGenesisAddress)
    .originSign(Utils.originPrivateKey)

  keychainAccessTx.on("fullConfirmation", async (_confirmations) => {
    const txAddress = Utils.uint8ArrayToHex(keychainAccessTx.address)
    console.log("Keychain Access transaction validated !")
    console.log("Address:", txAddress)
    console.log(env.endpoint + "/explorer/transaction/" + txAddress)
    process.exit(0)
  }).on("error", (context, reason) => {
    console.log("Error while sending Keychain Access transaction")
    console.log("Contest:", context)
    console.log("Reason:", reason)
    process.exit(1)
  })


  const keychainTx = archethic.account.newKeychainTransaction(keychain, 0)
    .originSign(Utils.originPrivateKey)

  keychainTx.on("fullConfirmation", async (_confirmations) => {
    const txAddress = Utils.uint8ArrayToHex(keychainTx.address)
    console.log("Keychain transaction validated !")
    console.log("Address:", txAddress)
    console.log(env.endpoint + "/explorer/transaction/" + txAddress)
    console.log("=======================")
    keychainAccessTx.send()
  }).on("error", (context, reason) => {
    console.log("Error while sending Keychain transaction")
    console.log("Contest:", context)
    console.log("Reason:", reason)
    process.exit(1)
  }).send()

}

export default {
  command,
  describe,
  builder,
  handler
}
