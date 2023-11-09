import Archethic, { Utils, Crypto } from "@archethicjs/sdk"
import config from "../../config.js"
import {
  sendTransactionWithFunding,
  getGenesisAddress,
  encryptSecret,
  getTokenAddress,
  getServiceGenesisAddress
} from "../utils.js"

const command = "deploy_pool"
const describe = "Deploy a pool for the token specified"
const builder = {
  token1: {
    describe: "First token name",
    demandOption: true,
    type: "string"
  },
  token2: {
    describe: "Second token name",
    demandOption: true,
    type: "string"
  },
  token1_amount: {
    describe: "First token initial amount",
    demandOption: true,
    type: "number"
  },
  token2_amount: {
    describe: "Second token initial amount",
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

  const token1Name = argv["token1"]
  const token2Name = argv["token2"]
  const token1Amount = argv["token1_amount"]
  const token2Amount = argv["token2_amount"]

  const token1Address = getTokenAddress(token1Name)
  const token2Address = getTokenAddress(token2Name)

  const poolSeed = Crypto.randomSecretKey()

  const poolGenesisAddress = getGenesisAddress(poolSeed)
  console.log("Pool genesis address:", poolGenesisAddress)

  const routerAddress = getServiceGenesisAddress(keychain, "Router")

  const poolAddresses = await archethic.network.callFunction(routerAddress, "get_pool_addresses", [token1Address, token2Address])
  if (poolAddresses != null) {
    console.log("Pool already exists for these tokens")
    process.exit(1)
  }

  // We could batch those requests but archehic sdk do not allow batch request for now
  const poolCode = await getPoolCode(archethic, token1Address, token2Address, poolSeed, routerAddress)
  const tokenDefinition = await archethic.network.callFunction(routerAddress, "get_lp_token_definition", [token1Name, token2Name])

  const storageNonce = await archethic.network.getStorageNoncePublicKey()
  const { encryptedSecret, authorizedKeys } = encryptSecret(poolSeed, storageNonce)

  const poolTx = archethic.transaction.new()
    .setType("token")
    .setContent(tokenDefinition)
    .setCode(poolCode)
    .addOwnership(encryptedSecret, authorizedKeys)
    .build(poolSeed, 0)
    .originSign(Utils.originPrivateKey)

  // Deploy pool
  await sendTransactionWithFunding(poolTx, null, archethic, env.userSeed)

  const poolInfos = await archethic.network.callFunction(poolGenesisAddress, "get_pool_infos")

  // Sort token to match pool order
  let token1, token2
  if (poolInfos.token1.address == token1Address.toUpperCase()) {
    token1 = { address: token1Address, amount: token1Amount }
    token2 = { address: token2Address, amount: token2Amount }
  } else {
    token1 = { address: token2Address, amount: token2Amount }
    token2 = { address: token1Address, amount: token1Amount }
  }

  const expectedTokenLP = await archethic.network.callFunction(
    poolGenesisAddress,
    "get_lp_token_to_mint",
    [token1.amount, token2.amount]
  )

  console.log("=======================")
  console.log("Expected LP token to receive:", expectedTokenLP)

  const userAddress = getGenesisAddress(env.userSeed)
  const index = await archethic.transaction.getTransactionIndex(userAddress)
  console.log("User genesis address:", userAddress)

  const tx = archethic.transaction.new()
    .setType("transfer")
    .addRecipient(poolGenesisAddress, "add_liquidity", [token1.amount, token2.amount])
    .addRecipient(routerAddress, "add_pool", [token1.address, token2.address, Utils.uint8ArrayToHex(poolTx.address)])
    .addTokenTransfer(poolGenesisAddress, Utils.toBigInt(token1.amount), token1.address)
    .addTokenTransfer(poolGenesisAddress, Utils.toBigInt(token2.amount), token2.address)
    .build(env.userSeed, index)
    .originSign(Utils.originPrivateKey)

  tx.on("requiredConfirmation", (_confirmations) => {
    console.log("Adding liquidity and pool registration success !")
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

async function getPoolCode(archethic, token1Address, token2Address, poolSeed, routerAddress) {
  const poolGenesisAddress = getGenesisAddress(poolSeed)
  const lpTokenAddress = getTokenAddress(poolSeed)

  const params = [token1Address, token2Address, poolGenesisAddress, lpTokenAddress]

  return archethic.network.callFunction(routerAddress, "get_pool_code", params)
}

export default {
  command,
  describe,
  builder,
  handler
}
