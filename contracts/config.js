export default {
  environments: {
    local: {
      endpoint: "http://127.0.0.1:4000",
      userSeed: "user",
      keychainAccessSeed: "access_dex",
      keychainSeed: "keychain_dex"
    },
    testnet: {
      endpoint: "https://testnet.archethic.net",
    },
    mainnet: {
      endpoint: "https://mainnet.archethic.net",
    }
  }
}
