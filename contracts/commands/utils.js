import fs from "fs"
import { Crypto, Utils } from "@archethicjs/sdk"
import path from "path"
import { fileURLToPath } from "url"

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)

const CONFIRMATION_THRESHOLD = 50

const poolContractPath = path.resolve(__dirname, "../contracts/pool.exs")
const farmContractPath = path.resolve(__dirname, "../contracts/farm.exs")
const factoryContractPath = path.resolve(__dirname, "../contracts/factory.exs")
const routerContractPath = path.resolve(__dirname, "../contracts/router.exs")

export function getGenesisAddress(seed) {
  return Utils.uint8ArrayToHex(Crypto.deriveAddress(seed, 0))
}

export function getServiceGenesisAddress(keychain, service, suffix = "") {
  return Utils.uint8ArrayToHex(keychain.deriveAddress(service, 0, suffix))
}

export function getTokenAddress(tokenSeed) {
  return tokenSeed == "UCO" ? "UCO" : Utils.uint8ArrayToHex(Crypto.deriveAddress(tokenSeed, 1))
}

export function encryptSecret(secret, publicKey) {
  const aesKey = Crypto.randomSecretKey()
  const encryptedSecret = Crypto.aesEncrypt(secret, aesKey)
  const encryptedAesKey = Crypto.ecEncrypt(aesKey, publicKey)
  const authorizedKeys = [{ encryptedSecretKey: encryptedAesKey, publicKey: publicKey }]
  return { encryptedSecret, authorizedKeys }
}

export async function sendTransactionWithFunding(tx, keychain, archethic, fundSeedFrom = undefined) {
  return new Promise(async (resolve, reject) => {
    let { fee } = await archethic.transaction.getTransactionFee(tx)
    fee = Math.trunc(fee * 1.01)

    const txPreviousAddress = "00" + Utils.uint8ArrayToHex(Crypto.hash(tx.previousPublicKey))
    let refillTx = archethic.transaction.new()
      .setType("transfer")
      .addUCOTransfer(txPreviousAddress, fee)

    let fundingGenesisAddress
    if (fundSeedFrom) {
      fundingGenesisAddress = getGenesisAddress(fundSeedFrom)
      const index = await archethic.transaction.getTransactionIndex(Crypto.deriveAddress(fundSeedFrom, 0))
      refillTx.build(fundSeedFrom, index).originSign(Utils.originPrivateKey)
    } else {
      fundingGenesisAddress = getServiceGenesisAddress(keychain, "Master")
      const masterIndex = await archethic.transaction.getTransactionIndex(keychain.deriveAddress("Master"))
      refillTx = keychain.buildTransaction(refillTx, "Master", masterIndex).originSign(Utils.originPrivateKey)
    }

    tx.on("requiredConfirmation", async (_confirmations) => {
      const txAddress = Utils.uint8ArrayToHex(tx.address)
      console.log("Transaction validated !")
      console.log("Address:", txAddress)
      console.log(archethic.endpoint.origin + "/explorer/transaction/" + txAddress)
      resolve()
    }).on("error", (context, reason) => {
      console.log("Error while sending transaction")
      console.log("Context:", context)
      console.log("Reason:", reason)
      reject()
    })

    console.log("Sending funds to previous transaction address ...")
    console.log("=======================")

    refillTx.on("requiredConfirmation", async (_confirmations) => {
      tx.send(CONFIRMATION_THRESHOLD)
    }).on("error", (context, reason) => {
      console.log("Error while sending UCO fee transaction")
      console.log("Funding genesis address:", fundingGenesisAddress)
      console.log("Context:", context)
      console.log("Reason:", reason)
      reject()
    }).send(CONFIRMATION_THRESHOLD)
  })
}

export function getFactoryCode(keychain) {
  const routerAddress = getServiceGenesisAddress(keychain, "Router")
  const factoryAddress = getServiceGenesisAddress(keychain, "Factory")
  const protocolFeeAddress = getServiceGenesisAddress(keychain, "ProtocolFee")
  const masterAddress = getServiceGenesisAddress(keychain, "Master")

  let poolCode = fs.readFileSync(poolContractPath, "utf8")
  // Replace pool address
  poolCode = poolCode.replaceAll("@POOL_ADDRESS", "0x#{pool_address}")
  // Replace token1 address
  poolCode = poolCode.replaceAll("@TOKEN1", '"#{token1_address}"')
  // Replace token2 address
  poolCode = poolCode.replaceAll("@TOKEN2", '"#{token2_address}"')
  // Replace lp token address
  poolCode = poolCode.replaceAll("@LP_TOKEN", "0x#{lp_token_address}")
  // Replace router address
  poolCode = poolCode.replaceAll("@ROUTER_ADDRESS", "0x#{router_address}")
  // Replace factory address
  poolCode = poolCode.replaceAll("@FACTORY_ADDRESS", "0x#{factory_address}")
  // Replace protocol fee address
  poolCode = poolCode.replaceAll("@PROTOCOL_FEE_ADDRESS", "0x#{protocol_fee_address}")
  // Replace master address
  poolCode = poolCode.replaceAll("@MASTER_ADDRESS", "0x#{master_address}")

  let farmCode = fs.readFileSync(farmContractPath, "utf8")
  // Replace farm address
  farmCode = farmCode.replaceAll("@FARM_ADDRESS", "0x#{farm_genesis_address}")
  // Replace lp token address
  farmCode = farmCode.replaceAll("@LP_TOKEN_ADDRESS", "0x#{lp_token}")
  // Replace start date
  farmCode = farmCode.replaceAll("@START_DATE", "#{start_date}")
  // Replace end date
  farmCode = farmCode.replaceAll("@END_DATE", "#{end_date}")
  // Replace reward token address
  farmCode = farmCode.replaceAll("@REWARD_TOKEN", '"#{reward_token}"')
  // Replace router address
  farmCode = farmCode.replaceAll("@ROUTER_ADDRESS", "0x#{router_address}")
  // Replace factory address
  farmCode = farmCode.replaceAll("@FACTORY_ADDRESS", "0x#{factory_address}")

  let factoryCode = fs.readFileSync(factoryContractPath, "utf8")
  // Replace router address
  factoryCode = factoryCode.replaceAll("@ROUTER_ADDRESS", "0x" + routerAddress)
  // Replace factory address
  factoryCode = factoryCode.replaceAll("@FACTORY_ADDRESS", "0x" + factoryAddress)
  // Replace protocol fee address
  factoryCode = factoryCode.replaceAll("@PROTOCOL_FEE_ADDRESS", "0x" + protocolFeeAddress)
  // Replace pool code
  factoryCode = factoryCode.replaceAll("@MASTER_ADDRESS", "0x" + masterAddress)
  // Replace pool code
  factoryCode = factoryCode.replaceAll("@POOL_CODE", poolCode)
  // Replace farm code
  return factoryCode.replaceAll("@FARM_CODE", farmCode)
}

export function getRouterCode(keychain) {
  const masterAddress = getServiceGenesisAddress(keychain, "Master")
  const factoryAddress = getServiceGenesisAddress(keychain, "Factory")

  let routerCode = fs.readFileSync(routerContractPath, "utf8")
  // Replace factory address
  routerCode = routerCode.replaceAll("@FACTORY_ADDRESS", "0x" + factoryAddress)
  // Replace master address
  return routerCode.replaceAll("@MASTER_ADDRESS", "0x" + masterAddress)
}
