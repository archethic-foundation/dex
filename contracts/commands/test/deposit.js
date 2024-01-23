import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import {
  getGenesisAddress,
  getTokenAddress,
  getServiceGenesisAddress
} from "../utils.js"

const command = "deposit"
const describe = "Deposit LP Token in a farm"
const builder = {
  lp_token: {
    describe: "LP token address",
    demandOption: true,
    type: "string"
  },
  reward_token: {
    describe: "Reward token name (or \"UCO\")",
    demandOption: true,
    type: "string"
  },
  lp_token_amount: {
    describe: "Amount of LP token to deposit",
    demandOption: true,
    type: "number"
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

  const lpTokenAddress = argv["lp_token"].toUpperCase()
  const rewardToken = argv["reward_token"]
  const lpTokenAmount = argv["lp_token_amount"]

  const rewardTokenAddress = getTokenAddress(rewardToken)

  const routerAddress = getServiceGenesisAddress(keychain, "Router")

  const farms = await archethic.network.callFunction(routerAddress, "get_farm_list", [])
  const farm = farms.find((farm) => {
    return farm.lp_token_address.toUpperCase() == lpTokenAddress && farm.reward_token == rewardTokenAddress
  })
  if (!farm) {
    console.log("No farm exists for this lp token and reward token")
    process.exit(1)
  }

  const userAddress = getGenesisAddress(env.userSeed)
  const index = await archethic.transaction.getTransactionIndex(userAddress)
  console.log("User genesis address:", userAddress)

  const tx = archethic.transaction.new()
    .setType("transfer")
    .addTokenTransfer(farm.address, Utils.toBigInt(lpTokenAmount), lpTokenAddress)
    .addRecipient(farm.address, "deposit", [])
    .build(env.userSeed, index)
    .originSign(Utils.originPrivateKey)

  tx.on("requiredConfirmation", (_confirmations) => {
    console.log("Deposit success !")
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
