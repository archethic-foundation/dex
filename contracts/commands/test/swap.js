import Archethic, { Utils } from "@archethicjs/sdk"
import config from "../../config.js"
import { getGenesisAddress, getServiceGenesisAddress, getTokenAddress } from "../utils.js"

const command = "swap"
const describe = "Swap exact token for token"
const builder = {
  token1: {
    describe: "First token name (token to send)",
    demandOption: true,
    type: "string"
  },
  token2: {
    describe: "Second token name (token to receive)",
    demandOption: true,
    type: "string"
  },
  token1_amount: {
    describe: "Amount of token to send",
    demandOption: true,
    type: "number"
  },
  slippage: {
    describe: "Slippage in percentage (2 = 2%) to apply. Default 2",
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

  const token1Name = argv["token1"]
  const token2Name = argv["token2"]
  const token1Amount = argv["token1_amount"]
  const slippage = argv["slippage"] ? argv["slippage"] : 2

  const token1Address = getTokenAddress(token1Name)
  const token2Address = getTokenAddress(token2Name)

  const routerAddress = getServiceGenesisAddress(keychain, "Router")

  const poolAddresses = await archethic.network.callFunction(routerAddress, "get_pool_addresses", [token1Address, token2Address])

  if (poolAddresses == null) {
    console.log("No pool exist for these tokens")
    process.exit(1)
  }

  const userAddress = getGenesisAddress(env.userSeed)
  const index = await archethic.transaction.getTransactionIndex(userAddress)
  console.log("User genesis address:", userAddress)

  const swapInfos = await archethic.network.callFunction(poolAddresses.address, "get_swap_infos", [token1Address, token1Amount])
  const minToReceive = swapInfos.output_amount * ((100 - slippage) / 100)

  console.log("Expected output amount:", swapInfos.output_amount)
  console.log("Minimum to receive:", minToReceive)
  console.log("Fee:", swapInfos.fee)
  console.log("Protocol Fee:", swapInfos.protocol_fee)
  console.log("Price impact", swapInfos.price_impact)

  const tx = archethic.transaction.new()

  if (token1Address == "UCO") {
    tx.addUCOTransfer(poolAddresses.address, Utils.toBigInt(token1Amount))
  } else {
    tx.addTokenTransfer(poolAddresses.address, Utils.toBigInt(token1Amount), token1Address)
  }

  tx.setType("transfer")
    .addRecipient(poolAddresses.address, "swap", [minToReceive])
    .build(env.userSeed, index)
    .originSign(Utils.originPrivateKey)

  tx.on("requiredConfirmation", (_confirmations) => {
    console.log("Swap success !")
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
