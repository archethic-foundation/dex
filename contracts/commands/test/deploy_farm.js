import Archethic, { Utils, Crypto } from "@archethicjs/sdk"
import config from "../../config.js"
import {
  sendTransactionWithFunding,
  getGenesisAddress,
  encryptSecret,
  getTokenAddress,
  getServiceGenesisAddress
} from "../utils.js"

const command = "deploy_farm"
const describe = "Deploy a farm for a lp token and a reward token"
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
  reward_token_amount: {
    describe: "Amount of reward token to send to the pool",
    demandOption: true,
    type: "number"
  },
  start_date: {
    describe: "Farming start date (default in 2 minutes)",
    demandOption: false,
    type: "number"
  },
  end_date: {
    describe: "Farming end date (default in 1 month)",
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

  const now = Math.floor(Date.now() / 1000)

  const lpTokenAddress = argv["lp_token"].toUpperCase()
  const rewardToken = argv["reward_token"]
  const rewardTokenAmount = argv["reward_token_amount"]
  const startDate = argv["start_date"] ? argv["start_date"] : now + 120
  const endDate = argv["end_date"] ? argv["end_date"] : now + 120 + 2592000

  const rewardTokenAddress = getTokenAddress(rewardToken)

  const farmSeed = Crypto.randomSecretKey()

  const farmGenesisAddress = getGenesisAddress(farmSeed)
  console.log("Farm genesis address:", farmGenesisAddress)

  const routerAddress = getServiceGenesisAddress(keychain, "Router")

  const pools = await archethic.network.callFunction(routerAddress, "get_pool_list", [])
  const pool = pools.find((pool) => pool.lp_token_address.toUpperCase() == lpTokenAddress)
  if (!pool) {
    console.log("This LP Token does not exists in DEX")
    process.exit(1)
  }

  // We could batch those requests but archehic sdk do not allow batch request for now
  const factoryAddress = getServiceGenesisAddress(keychain, "Factory")
  const farmCode = await getFarmCode(archethic, lpTokenAddress, startDate, endDate, rewardTokenAddress, farmSeed, factoryAddress)

  const storageNonce = await archethic.network.getStorageNoncePublicKey()
  const { encryptedSecret, authorizedKeys } = encryptSecret(farmSeed, storageNonce)

  const farmTx = archethic.transaction.new()
    .setType("contract")
    .setCode(farmCode)
    .addOwnership(encryptedSecret, authorizedKeys)
    .build(farmSeed, 0)
    .originSign(Utils.originPrivateKey)

  // Deploy pool
  console.log("Create farm contract")
  await sendTransactionWithFunding(farmTx, null, archethic, env.userSeed)

  console.log("=======================")
  console.log("Send reward and add farm to router")

  const masterGenesisAddress = getServiceGenesisAddress(keychain, "Master")
  const index = await archethic.transaction.getTransactionIndex(masterGenesisAddress)
  console.log("Master genesis address:", masterGenesisAddress)

  let tx = archethic.transaction.new()

  if (rewardTokenAddress == "UCO") {
    tx.addUCOTransfer(farmGenesisAddress, Utils.toBigInt(rewardTokenAmount))
  } else {
    tx.addTokenTransfer(farmGenesisAddress, Utils.toBigInt(rewardTokenAmount), rewardTokenAddress)
  }

  tx.setType("transfer")
    .addRecipient(routerAddress, "add_farm", [lpTokenAddress, startDate, endDate, rewardTokenAddress, Utils.uint8ArrayToHex(farmTx.address)])

  tx = keychain.buildTransaction(tx, "Master", index).originSign(Utils.originPrivateKey)

  tx.on("requiredConfirmation", (_confirmations) => {
    console.log("Farm registration success !")
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

async function getFarmCode(archethic, lpTokenAddress, startDate, endDate, rewardToken, farmSeed, factoryAddress) {
  const farmGenesisAddress = getGenesisAddress(farmSeed)

  const params = [lpTokenAddress, startDate, endDate, rewardToken, farmGenesisAddress]

  return archethic.network.callFunction(factoryAddress, "get_farm_code", params)
}

export default {
  command,
  describe,
  builder,
  handler
}
