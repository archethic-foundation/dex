import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import { sendTransactionWithFunding, getGenesisAddress, getServiceGenesisAddress } from "../utils.js"

const command = "create_tokens"
const describe = "Create tokens and send them to user address"
const builder = {
  number: {
    describe: "Number of token to create",
    demandOption: false,
    type: "number"
  },
}

const handler = async function (argv) {
  const envName = argv["env"] ? argv["env"] : "local"
  const env = config.environments[envName]

  const envUserGenesisAddress = getGenesisAddress(env.userSeed);
  console.log("envUserGenesisAddress: ", envUserGenesisAddress);
  const keychainAccessSeed = argv["access_seed"] ? argv["access_seed"] : env.keychainAccessSeed
  const userAddressTarget = argv["user_address_target"] ? argv["user_address_target"] : envUserGenesisAddress

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

  console.log("user address:", userAddressTarget)
  const keychainMaster = await archethic.account.getKeychain(env.keychainAccessSeed)
  const masterAddress = getServiceGenesisAddress(keychainMaster, "Master")
  console.log("masterAddress:", masterAddress)

  const numberOfToken = argv["number"] ? argv["number"] : 2

  const index = await archethic.transaction.getTransactionIndex(envUserGenesisAddress)


  const transactions = Array.from({ length: numberOfToken }, (_value, index) => index).map(nb => {
    const seed = "token" + nb
    const tx = createTokenTx(archethic, seed, [userAddressTarget, envUserGenesisAddress, masterAddress])
    console.log(seed, ":", Utils.uint8ArrayToHex(tx.address))
    return tx
  })

  for (let tx of transactions) {
    await sendTransactionWithFunding(tx, keychain, archethic)
  }

  process.exit(0)


}

function createTokenTx(archethic, seed, userAddresses) {
  const supply = 1_000_000 * 1e8 * userAddresses.length

  const recipients = userAddresses.map((userAddress) => {
    return {
      to: userAddress,
      amount: 1_000_000 * 1e8
    }
  });

  const tokenDefinition = {
    aeip: [2, 8, 18, 19],
    supply: supply,
    type: "fungible",
    symbol: seed,
    name: seed,
    properties: {},
    recipients: recipients,
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
