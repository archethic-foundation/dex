import fs from "fs"
import { Crypto, Utils } from "@archethicjs/sdk"
import path from "path"
import { fileURLToPath } from "url"

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)

const CONFIRMATION_THRESHOLD = 50

const poolContractPath = path.resolve(__dirname, "../contracts/pool.exs")
const stateContractPath = path.resolve(__dirname, "../contracts/state.exs")
const factoryContractPath = path.resolve(__dirname, "../contracts/factory.exs")
const routerContractPath = path.resolve(__dirname, "../contracts/router.exs")

export function getGenesisAddress(seed) {
  return Utils.uint8ArrayToHex(Crypto.deriveAddress(seed, 0))
}

export function getServiceGenesisAddress(keychain, service, suffix = "") {
  return Utils.uint8ArrayToHex(keychain.deriveAddress(service, 0, suffix))
}

export function getTokenAddress(tokenSeed) {
  return Utils.uint8ArrayToHex(Crypto.deriveAddress(tokenSeed, 1))
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

export function getStateCode(poolAddress) {
  const code = fs.readFileSync(stateContractPath, "utf8")

  return code.replaceAll("@POOL_ADDRESS", "0x" + poolAddress)
}

export function getRouterCode(keychain) {
  const masterAddress = getServiceGenesisAddress(keychain, "Master")
  const routerAddress = getServiceGenesisAddress(keychain, "Router")

  let poolCode = fs.readFileSync(poolContractPath, "utf8")
  // Replace pool address
  poolCode = poolCode.replaceAll("@POOL_ADDRESS", "0x#{pool_address}")
  // Replace state address
  poolCode = poolCode.replaceAll("@STATE_ADDRESS", "0x#{state_address}")
  // Replace token1 address
  poolCode = poolCode.replaceAll("@TOKEN1", "0x#{token1_address}")
  // Replace token2 address
  poolCode = poolCode.replaceAll("@TOKEN2", "0x#{token2_address}")
  // Replace lp token address
  poolCode = poolCode.replaceAll("@LP_TOKEN", "0x#{lp_token_address}")
  // Replace router address
  poolCode = poolCode.replaceAll("@ROUTER_ADDRESS", "0x" + routerAddress)

  let routerCode = fs.readFileSync(routerContractPath, "utf8")
  // Replace master address
  routerCode = routerCode.replaceAll("@MASTER_ADDRESS", "0x" + masterAddress)
  // Replace pool code
  return routerCode.replaceAll("@POOL_CODE", poolCode)
}
