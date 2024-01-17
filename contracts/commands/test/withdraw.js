import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import {
  getGenesisAddress,
  getTokenAddress,
  getServiceGenesisAddress
} from "../utils.js"

const command = "withdraw"
const describe = "Withdraw LP token from a farming pool and claim rewards"
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
  amount: {
    describe: "Amount to remove (default to maximum)",
    demandOption: false,
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
  let amount = argv["amount"]

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

  const userInfos = await archethic.network.callFunction(farm.address, "get_user_infos", [userAddress])

  if (userInfos.desposited_amount == 0) {
    console.log("User does not have deposited lp token in this farm")
    process.exit(1)
  } else if (amount && userInfos.desposited_amount < amount) {
    console.log("Amount is over than deposed amount")
    process.exit(1)
  } else if (!amount) {
    amount = userInfos.desposited_amount
  }

  console.log("Withdrawing", amount, "of LP token")

  const tx = archethic.transaction.new()
    .setType("transfer")
    .addRecipient(farm.address, "withdraw", [amount])
    .build(env.userSeed, index)
    .originSign(Utils.originPrivateKey)

  tx.on("requiredConfirmation", (_confirmations) => {
    console.log("Withdraw success !")
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
