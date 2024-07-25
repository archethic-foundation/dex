import Archethic from "@archethicjs/sdk"

const FARM_ADDRESS = "000087BDF107B7C36D6B3A0C2CA6D114C852E7BAD7E3AF5785CC5333B93160DFE697"
const archethic = new Archethic("https://testnet.archethic.net")

const levelToString = {
  0: "flex",
  1: "1 week",
  2: "1 month",
  3: "3 months",
  4: "6 months",
  5: "1 year",
  6: "2 years",
  7: "3 years"
}

export async function main(_args) {
  await archethic.connect()

  const [{ end, remaining_rewards, lpTokensDeposited, poolAddress, levelString }, { ucoPrice, wethPrice }]
    = await Promise.all([getFarmInfos(), getPrices()])

  const { wethAmount, ucoAmount } = await getRemoveAmounts(poolAddress, lpTokensDeposited)

  const valueLocked = wethAmount * wethPrice + ucoAmount * ucoPrice
  const valueReward = remaining_rewards * ucoPrice

  const now = Math.trunc(Date.now() / 1000)
  const apr = (valueReward / valueLocked) * (31536000 / (end - now)) * 100

  return { body: { level: levelString, apr: apr } }
}

async function getFarmInfos() {
  return new Promise(async (resolve) => {
    const res = await archethic.network.callFunction(FARM_ADDRESS, "get_farm_infos", [])

    const poolAddress = res.lp_token_address

    const now = Math.trunc(Date.now() / 1000)

    // Find max available level
    const maxLevel = Math.max(...Object.keys(res.available_levels).map(elt => parseInt(elt))).toString()
    const { end, remaining_rewards } = res.stats[maxLevel].remaining_rewards.find(elt => now < elt.end)
    const lpTokensDeposited = res.stats[maxLevel].lp_tokens_deposited
    const levelString = levelToString[parseInt(maxLevel)]
    resolve({ end, remaining_rewards, lpTokensDeposited, poolAddress, levelString })
  })
}

async function getPrices() {
  return new Promise(async (resolve) => {
    const res = await fetch("https://fas.archethic.net/api/v1/quotes/latest?ucids=6887,1027")
    const prices = await res.json()
    resolve({ ucoPrice: prices["6887"], wethPrice: prices["1027"] })
  })
}

async function getRemoveAmounts(poolAddress, lpTokensDeposited) {
  return new Promise(async (resolve) => {
    const { token1: wethAmount, token2: ucoAmount } =
      await archethic.network.callFunction(poolAddress, "get_remove_amounts", [lpTokensDeposited])

    resolve({ wethAmount, ucoAmount })
  })
}

new Promise(async (resolve) => {
  resolve(await main())
}).then(res => console.log(res))
