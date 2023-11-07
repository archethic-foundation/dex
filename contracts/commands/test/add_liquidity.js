import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import { getGenesisAddress, getServiceGenesisAddress, getTokenAddress } from "../utils.js"

const command = "add_liquidity"
const describe = "Add liquidity to a pool"
const builder = {
  token1: {
    describe: "First token name",
    demandOption: true,
    type: "string"
  },
  token1_amount: {
    describe: "First token amount",
    demandOption: true,
    type: "integer"
  },
  token2: {
    describe: "Second token name",
    demandOption: true,
    type: "string"
  },
  token2_amount: {
    describe: "Second token amount",
    demandOption: false,
    type: "integer"
  },
  slippage: {
    describe: "Slippage in percentage (2 = 2%) to apply. Default 2",
    demandOption: false,
    type: "integer"
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
  let token2Amount = argv["token2_amount"]
  const slippage = argv["slippage"] ? argv["slippage"] : 2

  const token1Address = getTokenAddress(token1Name)
  const token2Address = getTokenAddress(token2Name)

  const routerAddress = getServiceGenesisAddress(keychain, "Router")

  const poolInfos = await archethic.network.callFunction(routerAddress, "get_pool_infos", [token1Address, token2Address])

  if (poolInfos == null) {
    console.log("No pool exist for these tokens")
    process.exit(1)
  }

  if (!token2Amount) {
    token2Amount = await archethic.network.callFunction(poolInfos.address, "get_equivalent_amount", [token1Address, token1Amount])
  }

  if (token2Address < token1Address) {
    let temp = token1Address
    token1Address = token2Address
    token2Address = temp
    temp = token1Amount
    token1Amount = token2Amount
    token2Amount = temp
  }

  const expectedTokenLP = await archethic.network.callFunction(poolInfos.address, "get_lp_token_to_mint", [token1Amount, token2Amount])

  console.log("Expected LP token to receive:", expectedTokenLP)

  if (expectedTokenLP == 0) {
    console.log("Pool doesn't have liquidity, please fill both token amount")
    process.exit(1)
  }

  const poolTokens = await archethic.network.callFunction(poolInfos.address, "get_pair_tokens")

  // Sort token to match pool order
  let token1, token2
  if (poolTokens[0] == token1Address.toUpperCase()) {
    token1 = { address: token1Address, amount: token1Amount }
    token2 = { address: token2Address, amount: token2Amount }
  } else {
    token1 = { address: token2Address, amount: token2Amount }
    token2 = { address: token1Address, amount: token1Amount }
  }

  const userAddress = getGenesisAddress(env.userSeed)
  const index = await archethic.transaction.getTransactionIndex(userAddress)
  console.log("User genesis address:", userAddress)

  const minToken1Amount = token1.amount * ((100 - slippage) / 100)
  const minToken2Amount = token2.amount * ((100 - slippage) / 100)

  const tx = archethic.transaction.new()
    .setType("transfer")
    .addRecipient(poolInfos.address, "add_liquidity", [minToken1Amount, minToken2Amount])
    .addTokenTransfer(poolInfos.address, Utils.toBigInt(token1.amount), token1.address)
    .addTokenTransfer(poolInfos.address, Utils.toBigInt(token2.amount), token2.address)
    .build(env.userSeed, index)
    .originSign(Utils.originPrivateKey)

  tx.on("requiredConfirmation", (_confirmations) => {
    console.log("Adding liquidity success !")
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
