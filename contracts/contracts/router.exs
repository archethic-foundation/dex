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
        expected_content = Contract.call_function(
          @FACTORY_ADDRESS,
          "get_lp_token_definition",
          [token1_symbol, token2_symbol]
        )

        valid_definition? = Json.parse(pool_transaction.content) == Json.parse(expected_content)
      end

      valid_code? = false
      pool_genesis_address = nil
      if valid_definition? do
        # Ensure code is valid
        pool_genesis_address = Chain.get_genesis_address(pool_creation_address)
        expected_code = Contract.call_function(
          @FACTORY_ADDRESS,
          "get_pool_code",
          [token1_address, token2_address, pool_genesis_address, pool_creation_address]
        )

        valid_code? = Code.is_same?(pool_transaction.code, expected_code)
      end

      if valid_code? do
        # Ensure liquidity is provided to the pool
        valid? = List.in?(transaction.recipients, pool_genesis_address)
      end
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

condition triggered_by: transaction, on: add_farm(lp_token, start_date, end_date, reward_token, farm_creation_address), as: [
  address: (
    # Farm can only be created by the master chain of the dex

    # Transaction is not yet validated so we need to use previous address
    # to get the genesis address
    previous_address = Chain.get_previous_address(transaction)
    Chain.get_genesis_address(previous_address) == @MASTER_ADDRESS
  ),
  content: (
    lp_token = String.to_hex(lp_token)
    reward_token = String.to_uppercase(reward_token)
    farm_creation_address = String.to_hex(farm_creation_address)

    # LP token should be listed on dex
    lp_token_exists? = false
    pools = State.get("pools", Map.new()) 
    for pool in Map.values(pools) do
      if String.to_hex(pool.lp_token_address) == lp_token do
        lp_token_exists? = true
      end
    end

    # Start date should be between 2 hours and 1 week from now
    # End date should be between 1 month (30 days) and 1 year (365 days) from start date
    valid_date? = false
    if lp_token_exists? do
      now = Time.now()
      valid_start_date? = now + 7200 <= start_date && now + 604800 >= start_date
      valid_end_date? = start_date + 2592000 <= end_date && start_date + 31536000 >= end_date 

      valid_date? = valid_start_date? && valid_end_date?
    end

    # Ensure farm code is valid
    valid_code? = false
    farm_genesis_address = nil
    if valid_date? do
      farm_transaction = Chain.get_transaction(farm_creation_address)
      if farm_transaction != nil && farm_transaction.type == "contract" do
        farm_genesis_address = Chain.get_genesis_address(farm_creation_address)

        expected_code = Contract.call_function(
          @FACTORY_ADDRESS,
          "get_farm_code",
          [lp_token, start_date, end_date, reward_token, farm_genesis_address]
        )
        
        valid_code? = Code.is_same?(farm_transaction.code, expected_code)
      end
    end

    # Ensure this transaction adds the reward token to the farm
    valid_reward? = false
    if valid_code? do
      if reward_token == "UCO" do
        valid_reward? = Map.get(transaction.uco_transfers, farm_genesis_address) != nil
      else
        transfers = Map.get(transaction.token_transfers, farm_genesis_address)
        for transfer in transfers do
          if transfer.token_address == reward_token do
            valid_reward? = true
          end
        end
      end
    end

    lp_token_exists? && valid_date? && valid_code? && valid_reward?
  )
]

actions triggered_by: transaction, on: add_farm(lp_token, start_date, end_date, reward_token, farm_creation_address) do
  farms = State.get("farms", [])

  farm_genesis_address = Chain.get_genesis_address(farm_creation_address)

  new_farm = [
    lp_token_address: lp_token,
    start_date: start_date,
    end_date: end_date,
    reward_token: reward_token,
    address: farm_genesis_address
  ]

  farms = List.prepend(farms, new_farm)
  
  State.set("farms", farms)
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

condition triggered_by: transaction, on: update_farms_code(), as: [
  previous_public_key: (
    # Pool code update can only be requested from the master chain of the dex

    # Transaction is not yet validated so we need to use previous address
    # to get the genesis address
    previous_address = Chain.get_previous_address()
    Chain.get_genesis_address(previous_address) == @MASTER_ADDRESS
  )
]

actions triggered_by: transaction, on: update_farms_code() do
  farms = State.get("farms", [])

  if List.size(farms) > 0 do
    for farm in farms do
      Contract.add_recipient address: farm.address, action: "update_code", args: []
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

export fun get_farm_list() do
  State.get("farms", [])
end
