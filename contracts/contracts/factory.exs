@version 1

export fun get_pool_code(token1_address, token2_address, pool_address, lp_token_address, state_address) do
  code = ""
  if token1_address != token2_address do
    if token1_address > token2_address do
      temp = token1_address
      token1_address = token2_address
      token2_address = temp
    end

    code = """
    @POOL_CODE
    """
  end
  code
end

export fun get_lp_token_definition(token1_symbol, token2_symbol) do
  if token1_symbol > token2_symbol do
    temp = token1_symbol
    token1_symbol = token2_symbol
    token2_symbol = temp
  end

  lp_token = "lp_#{token1_symbol}_#{token2_symbol}"

  Json.to_string([
    aeip: [2, 8, 18, 19],
    supply: 10,
    type: "fungible",
    symbol: lp_token,
    name: lp_token,
    allow_mint: true,
    properties: [
      description: "LP token of AESwap"
    ],
    recipients: [
      [
        to: Chain.get_burn_address(),
        amount: 10
      ]
    ]
  ])
end
