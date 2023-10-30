export default {
  environments: {
    local: {
      endpoint: "http://127.0.0.1:4000",
      userSeed: "user",
      keychainAccessSeed: "access",
      keychainSeed: "keychain"
    },
    testnet: {
      endpoint: "https://testnet.archethic.net",
    }
  }
}
