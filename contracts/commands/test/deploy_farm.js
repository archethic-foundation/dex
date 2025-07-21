import Archethic, { Utils, Crypto } from "@archethicjs/sdk"
import config from "../../config.js"
import {
  sendTransactionWithFunding,
  getGenesisAddress,
  encryptSecret,
  getTokenAddress,
  getServiceGenesisAddress,
  sendTransactionWithoutFunding,
  sendWithWallet
} from "../utils.js"
import { getProposeTransaction } from "@archethicjs/multisig-sdk"

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
  },
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
  farm_type: {
    describe: "Type of farm", // 1 legacy, 2 Farm lock
    demandOption: false,
    type: "number"
  },
  farm_seed: {
    describe: "Farm's seed",
    demandOption: false,
    type: "string"
  },
  with_multisig: {
    describe: "Determines if the master is using a multisig",
    demandOption: false,
    type: "boolean",
    default: false
  },
}

const handler = async function (argv) {
  const envName = argv["env"] ? argv["env"] : "local"
  const env = config.environments[envName]

  const keychainAccessSeed = argv["access_seed"] ? argv["access_seed"] : env.keychainAccessSeed

  if (keychainAccessSeed == undefined) {
    console.log("Keychain access seed not defined")
    process.exit(1)
  }

  const archethic = new Archethic(argv["with_multisig"] ? undefined : env.endpoint)
  if (archethic.rpcWallet) {
    archethic.rpcWallet.setOrigin({ name: "Archethic DEX CLI" });
  }
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
  const farmType = argv["farm_type"] ? argv["farm_type"] : 1

  const rewardTokenAddress = getTokenAddress(rewardToken)

  const farmSeed = argv["farm_seed"] ? argv["farm_seed"] : Crypto.randomSecretKey();

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
  const farmCode = await getFarmCode(archethic, lpTokenAddress, startDate, endDate, rewardTokenAddress, farmSeed, factoryAddress, farmType)

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
  if (argv["without_funding"]) {
    await sendTransactionWithoutFunding(farmTx, archethic)
  }
  else {
    await sendTransactionWithFunding(farmTx, keychain, archethic)
  }

  console.log("=======================")
  console.log("Send reward and add farm to router")

  const masterGenesisAddress = getServiceGenesisAddress(keychain, "Master")
  const index = await archethic.transaction.getTransactionIndex(masterGenesisAddress)
  console.log("Master genesis address:", masterGenesisAddress)

  const addFarmArgs = [lpTokenAddress, startDate, endDate, rewardTokenAddress, Utils.uint8ArrayToHex(farmTx.address), farmType]

  if (argv["with_multisig"]) {
    let ucoTransfers = [], tokenTransfers = []
    if (rewardTokenAddress == "UCO") {
      ucoTransfers = [{ to: farmGenesisAddress, amount: Utils.toBigInt(rewardTokenAmount)}]
    } else {
      tokenTransfers = [{ to: farmGenesisAddress, amount: Utils.toBigInt(rewardTokenAmount), tokenAddress: rewardTokenAddress}]
    }
    const tx = getProposeTransaction(archethic, masterGenesisAddress, {
      ucoTransfers: ucoTransfers,
      tokenTransfers: tokenTransfers,
      recipients: [
        { address: routerAddress, action: "add_farm", args: [lpTokenAddress, startDate, endDate, rewardTokenAddress, Utils.uint8ArrayToHex(farmTx.address), farmType] }
      ]
    })

    sendWithWallet(tx, archethic)
      .then(() => {
        console.log("Farm registration proposal submitted !")
        process.exit(0)
      })
      .catch(() => process.exit(1))

    return
  }

  let tx = archethic.transaction.new()

  if (rewardTokenAddress == "UCO") {
    tx.addUCOTransfer(farmGenesisAddress, Utils.toBigInt(rewardTokenAmount))
  } else {
    tx.addTokenTransfer(farmGenesisAddress, Utils.toBigInt(rewardTokenAmount), rewardTokenAddress)
  }

  tx.setType("transfer")
    .addRecipient(routerAddress, "add_farm", addFarmArgs)

  tx = keychain.buildTransaction(tx, "Master", index).originSign(Utils.originPrivateKey)

  sendTransactionWithoutFunding(tx, archethic)
      .then(() => {
        console.log("Farm registration success !")
        process.exit(0)
      })
      .catch(() => process.exit(1))
}

async function getFarmCode(archethic, lpTokenAddress, startDate, endDate, rewardToken, farmSeed, factoryAddress, farmType) {
  const farmGenesisAddress = getGenesisAddress(farmSeed)
  const params = [lpTokenAddress, startDate, endDate, rewardToken, farmGenesisAddress]
  if (farmType == 1) {
    return archethic.network.callFunction(factoryAddress, "get_farm_code", params)
  } else {
    return archethic.network.callFunction(factoryAddress, "get_farm_lock_code", params)
  }

}

export default {
  command,
  describe,
  builder,
  handler
}
