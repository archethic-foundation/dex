import fs from "fs"
import { Crypto, Utils } from "@archethicjs/sdk"
import path from "path"
import { fileURLToPath } from "url"

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)

const CONFIRMATION_THRESHOLD = 50

const poolContractPath = path.resolve(__dirname, "../contracts/pool.exs")
const stateContractPath = path.resolve(__dirname, "../contracts/state.exs")

export function getGenesisAddress(seed) {
  return Utils.uint8ArrayToHex(Crypto.deriveAddress(seed, 0))
}

export function getServiceGenesisAddress(keychain, service, suffix = "") {
  return Utils.uint8ArrayToHex(keychain.deriveAddress(service, 0, suffix))
}

export function getTokenAddress(tokenSeed) {
  return Utils.uint8ArrayToHex(Crypto.deriveAddress(tokenSeed, 1))
}

export function getPoolSeed(token1, token2) {
  return [token1, token2].sort().join("")
}

export function encryptSecret(secret, publicKey) {
  const aesKey = Crypto.randomSecretKey()
  const encryptedSecret = Crypto.aesEncrypt(secret, aesKey)
  const encryptedAesKey = Crypto.ecEncrypt(aesKey, publicKey)
  const authorizedKeys = [{ encryptedSecretKey: encryptedAesKey, publicKey: publicKey }]
  return { encryptedSecret, authorizedKeys }
}

export async function updateKeychain(keychain, archethic) {
  return new Promise(async (resolve, reject) => {
    const keychainGenesisAddress = Crypto.deriveAddress(keychain.seed, 0)
    const transactionChainIndex = await archethic.transaction.getTransactionIndex(keychainGenesisAddress)

    const keychainTx = archethic.account.newKeychainTransaction(keychain, transactionChainIndex)
      .originSign(Utils.originPrivateKey)

    keychainTx.on("requiredConfirmation", async (_confirmations) => {
      const txAddress = Utils.uint8ArrayToHex(keychainTx.address)
      console.log("Keychain transaction validated !")
      console.log("Address:", txAddress)
      console.log(archethic.endpoint.origin + "/explorer/transaction/" + txAddress)
      console.log("=======================")
      resolve()
    }).on("error", (context, reason) => {
      console.log("Error while sending Keychain transaction")
      console.log("Contest:", context)
      console.log("Reason:", reason)
      reject()
    }).send(CONFIRMATION_THRESHOLD)
  })
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

export function getTokenDefinition(token) {
  return JSON.stringify({
    aeip: [2, 8, 18, 19],
    supply: 10,
    type: "fungible",
    symbol: token,
    name: token,
    allow_mint: true,
    properties: {},
    recipients: [
      {
        to: "00000000000000000000000000000000000000000000000000000000000000000000",
        amount: 10
      }
    ]
  })
}

export function getStateCode(poolAddress) {
  const code = fs.readFileSync(stateContractPath, "utf8")

  return code.replaceAll("@POOL_ADDRESS", "0x" + poolAddress)
}

export function getPoolCode(token1, token2) {
  // Sort token by address
  const [token1Address, token2Address] = [getTokenAddress(token1), getTokenAddress(token2)].sort()

  const seed = getPoolSeed(token1, token2)
  const poolGenesisAddress = getGenesisAddress(seed)
  const lpTokenAddress = Utils.uint8ArrayToHex(Crypto.deriveAddress(seed, 1))
  const stateContractAddress = getGenesisAddress(seed + "_state")

  let poolCode = fs.readFileSync(poolContractPath, "utf8")
  // Replace pool address
  poolCode = poolCode.replaceAll("@POOL_ADDRESS", "0x" + poolGenesisAddress)
  // Replace state address
  poolCode = poolCode.replaceAll("@STATE_ADDRESS", "0x" + stateContractAddress)
  // Replace token1 address
  poolCode = poolCode.replaceAll("@TOKEN1", "0x" + token1Address)
  // Replace token2 address
  poolCode = poolCode.replaceAll("@TOKEN2", "0x" + token2Address)
  // Replace lp token address
  return poolCode = poolCode.replaceAll("@LP_TOKEN", "0x" + lpTokenAddress)
}
