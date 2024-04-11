import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import { getServiceGenesisAddress } from "../utils.js"

const command = "update_farm_dates"
const describe = "Update the start and end date of a farm"
const builder = {
  farm_address: {
    describe: "Address of the farm to update",
    demandOption: true,
    type: "string"
  },
  start_date: {
    describe: "New start date",
    demandOption: true,
    type: "number"
  },
  end_date: {
    describe: "New end date",
    demandOption: true,
    type: "number"
  },
  access_seed: {
    describe: "the keychain access seed (default in env config)",
    demandOption: false,
    type: "string"
  },
  env: {
    describe: "The environment config to use (default to local)",
    demandOption: false,
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

  const farmAddress = argv["farm_address"]
  const startDate = argv["start_date"]
  const endDate = argv["end_date"]

  const masterGenesisAddress = getServiceGenesisAddress(keychain, "Master")
  console.log("Master genesis address:", masterGenesisAddress)
  const index = await archethic.transaction.getTransactionIndex(masterGenesisAddress)

  let updateTx = archethic.transaction.new()
    .setType("transfer")
    .addRecipient(farmAddress, "update_dates", [startDate, endDate])

  updateTx = keychain.buildTransaction(updateTx, "Master", index).originSign(Utils.originPrivateKey)

  updateTx.on("requiredConfirmation", async (_confirmations) => {
    const txAddress = Utils.uint8ArrayToHex(updateTx.address)
    console.log("Transaction validated !")
    console.log("Address:", txAddress)
    console.log(env.endpoint + "/explorer/transaction/" + txAddress)
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
