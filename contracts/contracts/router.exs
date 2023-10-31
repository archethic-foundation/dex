@version 1

condition triggered_by: transaction, on: add_pool(token1_address, token2_address, state_address), as: [
  type: "token",
  content: (
    valid? = false

    token1_address = String.to_uppercase(token1_address)
    token2_address = String.to_uppercase(token2_address)

    pool_exists? = get_pool_infos(token1_address, token2_address) != nil

    if token1_address != token2_address && !pool_exists? do
      # Ensure tokens exists and lp token definition is good
      token1_tx = Chain.get_transaction(token1_address)
      token2_tx = Chain.get_transaction(token2_address)

      token1_symbol = get_token_symbol(token1_tx)
      token2_symbol = get_token_symbol(token2_tx)

      if token1_symbol != nil && token2_symbol do
        expected_content = 
          Contract.call_function(
            @FACTORY_ADDRESS,
            "get_lp_token_definition",
            [token1_symbol, token2_symbol]
          )

        valid? = Json.parse(transaction.content) == Json.parse(expected_content)
      end
    end

    valid?
  ),
  code: (
    valid? = false

    token1_address = String.to_uppercase(token1_address)
    token2_address = String.to_uppercase(token2_address)

    if transaction.code != "" do
      # Ensure pool code is a valid one
      pool_previous_address = Chain.get_previous_address(transaction)
      pool_genesis_address = Chain.get_genesis_address(pool_previous_address)

      params = [token1_address, token2_address, pool_genesis_address, transaction.address, state_address]

      expected_code = Contract.call_function(@FACTORY_ADDRESS, "get_pool_code", params)

      valid? = Code.is_same?(transaction.code, expected_code)
    end

    valid?
  )
]

actions triggered_by: transaction, on: add_pool(token1_address, token2_address, _state_address) do
  token1_address = String.to_uppercase(token1_address)
  token2_address = String.to_uppercase(token2_address)

  if token1_address > token2_address do
    temp = token1_address
    token1_address = token2_address
    token2_address = temp
  end

  pool_previous_address = Chain.get_previous_address(transaction)
  pool_genesis_address = Chain.get_genesis_address(pool_previous_address)

  pool_id = get_pool_id(token1_address, token2_address)

  contract_state = Json.parse(contract.content)
  pools = Map.get(contract_state, "pools", Map.new())

  pool_data = [
    address: pool_genesis_address,
    lp_token_address: transaction.address
  ]

  pools = Map.set(pools, pool_id, pool_data)
  contract_state = Map.set(contract_state, "pools", pools)

  Contract.set_content(Json.to_string(contract_state))
end

condition triggered_by: transaction, on: update_code(new_code), as: [
  previous_public_key:
    (
      # Pool code can only be updated from the master chain of the dex

      # Transaction is not yet validated so we need to use previous address
      # to get the genesis address
      previous_address = Chain.get_previous_address()
      Chain.get_genesis_address(previous_address) == @MASTER_ADDRESS
    ),
  code: Code.is_valid?(new_code)
]

actions triggered_by: transaction, on: update_code(new_code) do
  Contract.set_type("contract")
  # Keep contract state
  Contract.set_content(contract.content)
  Contract.set_code(new_code)
end

export fun get_pool_infos(token1_address, token2_address) do
  token1_address = String.to_uppercase(token1_address)
  token2_address = String.to_uppercase(token2_address)

  if token1_address > token2_address do
    temp = token1_address
    token1_address = token2_address
    token2_address = temp
  end

  pool_id = "#{token1_address}/#{token2_address}"

  contract_state = Json.parse(contract.content)
  pools = Map.get(contract_state, "pools", Map.new())

  Map.get(pools, pool_id, nil)
end

fun get_pool_id(token1_address, token2_address) do
  if token1_address > token2_address do
    temp = token1_address
    token1_address = token2_address
    token2_address = temp
  end

  "#{token1_address}/#{token2_address}"
end

fun get_token_symbol(tx) do
  # Transaction must have type token
  # Token must by fungible
  symbol = nil

  if tx.type == "token" do
    token_definition = Json.parse(tx.content)
    if token_definition.type == "fungible" do
      symbol = Map.get(token_definition, "symbol", nil)
    end
  end

  symbol
end
