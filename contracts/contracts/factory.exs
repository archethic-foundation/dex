@version 1

export fun(get_pool_code(token1_address, token2_address, pool_address, lp_token_address)) do
  code = ""

  token1_address = String.to_uppercase(token1_address)
  token2_address = String.to_uppercase(token2_address)
  pool_address = String.to_uppercase(pool_address)
  lp_token_address = String.to_uppercase(lp_token_address)

  router_address = @ROUTER_ADDRESS
  factory_address = @FACTORY_ADDRESS
  master_address = @MASTER_ADDRESS
  protocol_fee_address = @PROTOCOL_FEE_ADDRESS

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

export fun(get_farm_code(lp_token, start_date, end_date, reward_token, farm_genesis_address)) do
  lp_token = String.to_hex(lp_token)
  reward_token = String.to_uppercase(reward_token)

  router_address = @ROUTER_ADDRESS
  factory_address = @FACTORY_ADDRESS
  master_address = @MASTER_ADDRESS

  """
  @FARM_CODE
  """
end

export fun(get_farm_lock_code(lp_token, start_date, end_date, reward_token, farm_genesis_address)) do
  lp_token = String.to_hex(lp_token)
  reward_token = String.to_uppercase(reward_token)

  router_address = @ROUTER_ADDRESS
  factory_address = @FACTORY_ADDRESS
  master_address = @MASTER_ADDRESS

  """
  @FARM_LOCK_CODE
  """
end

export fun(get_lp_token_definition(token1_address, token2_address)) do
  token1_address = String.to_uppercase(token1_address)
  token2_address = String.to_uppercase(token2_address)

  if token1_address > token2_address do
    temp = token1_address
    token1_address = token2_address
    token2_address = temp
  end

  Json.to_string(
    aeip: [2, 8, 18, 19],
    supply: 10,
    type: "fungible",
    symbol: "aeSwapLP",
    name: "aeSwap LP Token",
    allow_mint: true,
    properties: [
      token1_address: token1_address,
      token2_address: token2_address
    ],
    recipients: [
      [
        to: Chain.get_burn_address(),
        amount: 10
      ]
    ]
  )
end
