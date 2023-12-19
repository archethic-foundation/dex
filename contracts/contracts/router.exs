@version 1

condition triggered_by: transaction, on: add_pool(token1_address, token2_address, pool_creation_address), as: [
  type: "transfer",
  content: (
    valid? = false

    token1_address = String.to_uppercase(token1_address)
    token2_address = String.to_uppercase(token2_address)

    pool_exists? = get_pool_addresses(token1_address, token2_address) != nil

    if token1_address != token2_address && !pool_exists? do
      # Could create a new function Chain.get_transactions(list_of_address)
      pool_transaction = Chain.get_transaction(pool_creation_address)

      # Ensure tokens exists and lp token definition is good
      token1_symbol = get_token_symbol(token1_address)
      token2_symbol = get_token_symbol(token2_address)

      valid_definition? = false
      if token1_symbol != nil && token2_symbol != nil && pool_transaction != nil && pool_transaction.type == "token" do
        expected_content = get_lp_token_definition(token1_symbol, token2_symbol)

        valid_definition? = Json.parse(pool_transaction.content) == Json.parse(expected_content)
      end

      valid_code? = false
      pool_genesis_address = nil
      if valid_definition? do
        # Ensure code is valid
        pool_genesis_address = Chain.get_genesis_address(pool_creation_address)
        expected_code = get_pool_code(token1_address, token2_address, pool_genesis_address, pool_creation_address)

        valid_code? = Code.is_same?(pool_transaction.code, expected_code)
      end

      if valid_code? do
        # Ensure liquidity is provided to the pool
        valid? = List.in?(transaction.recipients, pool_genesis_address)
      end

      log("valid_definition? #{valid_definition?}")
      log("valid_code? #{valid_code?}")
      log("valid? #{valid?}")

    end

    valid?
  )
]

actions triggered_by: transaction, on: add_pool(token1_address, token2_address, pool_creation_address) do
  token1_address = String.to_uppercase(token1_address)
  token2_address = String.to_uppercase(token2_address)

  pool_genesis_address = Chain.get_genesis_address(pool_creation_address)
  pool_id = get_pool_id(token1_address, token2_address)
  pools = State.get("pools", Map.new())

  pool_data = [
    address: pool_genesis_address,
    lp_token_address: pool_creation_address
  ]

  pools = Map.set(pools, pool_id, pool_data)

  State.set("pools", pools)
end

condition triggered_by: transaction, on: update_code(new_code), as: [
  previous_public_key: (
    # Router code can only be updated from the master chain of the dex

    # Transaction is not yet validated so we need to use previous address
    # to get the genesis address
    previous_address = Chain.get_previous_address()
    Chain.get_genesis_address(previous_address) == @MASTER_ADDRESS
  ),
  code: Code.is_valid?(new_code)
]

actions triggered_by: transaction, on: update_code(new_code) do
  Contract.set_type("contract")
  Contract.set_code(new_code)
end

condition triggered_by: transaction, on: update_pools_code(), as: [
  previous_public_key: (
    # Pool code update can only be requested from the master chain of the dex

    # Transaction is not yet validated so we need to use previous address
    # to get the genesis address
    previous_address = Chain.get_previous_address()
    Chain.get_genesis_address(previous_address) == @MASTER_ADDRESS
  )
]

actions triggered_by: transaction, on: update_pools_code() do
  pools = State.get("pools", Map.new())

  if Map.size(pools) > 0 do
    for pool_info in Map.values(pools) do
      Contract.add_recipient address: pool_info.address, action: "update_code", args: []
    end

    Contract.set_type("transfer")
  end
end

fun get_pool_id(token1_address, token2_address) do
  if token1_address > token2_address do
    temp = token1_address
    token1_address = token2_address
    token2_address = temp
  end

  "#{token1_address}/#{token2_address}"
end

fun get_token_symbol(token_address) do
  if token_address == "UCO" do
    "UCO"
  else
    tx = Chain.get_transaction(token_address)
    # Transaction must have type token
    # Token must by fungible
    symbol = nil
    if tx != nil && tx.type == "token" do
      token_definition = Json.parse(tx.content)
      if token_definition.type == "fungible" do
        symbol = Map.get(token_definition, "symbol", nil)
      end
    end
    symbol
  end
end

export fun get_pool_addresses(token1_address, token2_address) do
  token1_address = String.to_uppercase(token1_address)
  token2_address = String.to_uppercase(token2_address)

  if token1_address > token2_address do
    temp = token1_address
    token1_address = token2_address
    token2_address = temp
  end

  pool_id = "#{token1_address}/#{token2_address}"

  pools = State.get("pools", Map.new())

  Map.get(pools, pool_id, nil)
end

export fun get_pool_list() do
  pools = State.get("pools", Map.new())

  list = []
  for pool_id in Map.keys(pools) do
    pool = Map.get(pools, pool_id)
    pool = Map.set(pool, "tokens", pool_id)
    list = List.prepend(list, pool)
  end
  list
end

export fun get_pool_code(token1_address, token2_address, pool_address, lp_token_address) do
  code = ""

  token1_address = String.to_uppercase(token1_address)
  token2_address = String.to_uppercase(token2_address)
  pool_address = String.to_uppercase(pool_address)
  lp_token_address = String.to_uppercase(lp_token_address)

  if token1_address != token2_address do
    if token1_address > token2_address do
      temp = token1_address
      token1_address = token2_address
      token2_address = temp
    end

    code =
"""
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
      description: "LP token of aeSwap"
    ],
    recipients: [
      [
        to: Chain.get_burn_address(),
        amount: 10
      ]
    ]
  ])
end
