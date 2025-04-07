import Archethic, { Utils } from "@archethicjs/sdk";

const seed = "791b6812944d3e1c026512a03a0877abaa3678c8292dfef915d28e8edf0d6c57"

const archethic = new Archethic("https://mainnet.archethic.net")
await archethic.connect()

const keychain = await archethic.account.getKeychain(seed)

const address = keychain.deriveAddress("archethic-wallet-REDDWARF", 0)

const { token: tokens, uco: uco } = await archethic.network.getBalance(Utils.uint8ArrayToHex(address))
console.log("uco:", uco)

const index = await archethic.transaction.getTransactionIndex(address)
console.log("index:", index)
console.log("address:", Utils.uint8ArrayToHex(address))
let tx = archethic.transaction.new().setType("transfer")

tokens.forEach(token => {
    console.log("token:", token.amount + " " + token.address + " " + token.tokenId);
    if (token.tokenId == 0)
        tx.addTokenTransfer("0000c49d0d88c7cab7a234a1ef4d32f5e46ca12b523f2d3f97d45d62d2d2ea3238fb", token.amount, token.address)
})

keychain.buildTransaction(tx, "archethic-wallet-REDDWARF", index).originSign(Utils.originPrivateKey)

const result = await archethic.transaction.getTransactionFee(tx);
console.log("result:", result)

tx.on("requiredConfirmation", (_confirmations) => {
    console.log("Adding liquidity success !")
    const address = Utils.uint8ArrayToHex(tx.address)
    console.log("Address:", address)
    console.log("/explorer/transaction/" + address)
    process.exit(0)
}).on("error", (context, reason) => {
    console.log("Error while sending transaction")
    console.log("Contest:", context)
    console.log("Reason:", reason)
    process.exit(1)
}).send(50)