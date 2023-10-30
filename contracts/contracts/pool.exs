@version 1

condition triggered_by: transaction, on: add_liquidity(token1_min_amount, token2_min_amount), as: [
  token_transfers: (
    valid_amounts? = false
    valid_liquidity? = false

    user_amounts = get_user_transfers_amount(transaction.token_transfers)

    if user_transfers.token1 > 0 && user_transfers.token2 > 0 do
      contract_state = Contract.call_function(@STATE_ADDRESS, "get_state", [])
      lp_token_supply = Map.get(contract_state, "lp_token_supply", 0)
      reserves = Map.get(contract_state, "reserves", [token1: 0, token2: 0])

      final_amounts = nil
      if lp_token_supply != 0 do
        # Returns final_amounts.token1 == 0 in case of insufficient funds
        final_amounts = get_final_amounts(user_amounts, reserves, token1_min_amount, token2_min_amount)
      else
        final_amounts = [token1: user_amounts.token1, token2: user_amounts.token2]
      end

      if final_amounts.token1 != 0 do
        valid_amounts? = true

        pool_balances = get_pool_balances()
        # Amount = final amounts + potential current balance over reserve
        token1_amount = final_amounts.token1 + (pool_balances.token1 - reserves.token1)
        token2_amount = final_amounts.token2 + (pool_balances.token2 - reserves.token2)

        lp_token_to_mint = get_lp_token_to_mint(lp_token_supply, token1_amount, token2_amount, reserves)

        valid_liquidity? = lp_token_to_mint != 0
      end
    end

    valid_amounts? && valid_liquidity?
  )
]

actions triggered_by: transaction, on: add_liquidity(token1_min_amount, token2_min_amount) do
  pool_balances = get_pool_balances()
  user_amounts = get_user_transfers_amount(transaction.token_transfers)

  contract_state = Contract.call_function(@STATE_ADDRESS, "get_state", [])
  lp_token_supply = Map.get(contract_state, "lp_token_supply", 0)
  reserves = Map.get(contract_state, "reserves", [token1: 0, token2: 0])

  final_amounts = get_final_amounts(user_amounts, reserves, token1_min_amount, token2_min_amount)
  token1_to_refund = user_amounts.token1 - final_amounts.token1
  token2_to_refund = user_amounts.token2 - final_amounts.token2

  token1_amount = pool_balances.token1 - reserves.token1 - token1_to_refund
  token2_amount = pool_balances.token2 - reserves.token2 - token2_to_refund

  lp_token_to_mint = get_lp_token_to_mint(lp_token_supply, token1_amount, token2_amount, reserves)
  lp_token_to_mint_bigint = Math.trunc(lp_token_to_mint * 100_000_000)

  # Remove minimum liquidity if this is the first liquidity if the pool
  # First liquidity minted and burned on pool creation
  if lp_token_supply == 0 do
    lp_token_to_mint_bigint = lp_token_to_mint_bigint - 10
  end

  token_specification = [
    aeip: [8, 18, 19],
    supply: lp_token_to_mint_bigint,
    token_reference: @LP_TOKEN,
    recipients: [
      [to: transaction.address, amount: lp_token_to_mint_bigint]
    ]
  ]

  new_token1_reserve = pool_balances.token1 - token1_to_refund
  new_token2_reserve = pool_balances.token2 - token2_to_refund

  contract_state = Map.set(contract_state, "lp_token_supply", lp_token_supply + lp_token_to_mint)
  contract_state = Map.set(contract_state, "reserves", [token1: new_token1_reserve, token2: new_token2_reserve])
  
  Contract.add_recipient(
    address: @STATE_ADDRESS,
    action: "update_state",
    args: [contract_state]
  )

  if token1_to_refund > 0 do
    Contract.add_token_transfer(to: transaction.address, amount: token1_to_refund, token_address: @TOKEN1)
  end

  if token2_to_refund > 0 do
    Contract.add_token_transfer(to: transaction.address, amount: token2_to_refund, token_address: @TOKEN2)
  end

  Contract.set_type("token")
  Contract.set_content(Json.to_string(token_specification))
end

condition triggered_by: transaction, on: remove_liquidity(), as: [
  token_transfers: (
    valid? = false

    user_amount = get_user_lp_amount(transaction.token_transfers)
    if user_amount > 0 do
      pool_balances = get_pool_balances()

      contract_state = Contract.call_function(@STATE_ADDRESS, "get_state", [])
      lp_token_supply = Map.get(contract_state, "lp_token_supply", 0)

      token1_to_remove = (user_amount * pool_balances.token1) / lp_token_supply
      token2_to_remove = (user_amount * pool_balances.token2) / lp_token_supply

      valid? = token1_to_remove > 0 && token2_to_remove > 0
    end

    valid?
  )
]

actions triggered_by: transaction, on: remove_liquidity() do
  user_amount = get_user_lp_amount(transaction.token_transfers)
  pool_balances = get_pool_balances()

  contract_state = Contract.call_function(@STATE_ADDRESS, "get_state", [])
  lp_token_supply = Map.get(contract_state, "lp_token_supply")
  reserves = Map.get(contract_state, "reserves")

  token1_to_remove = (user_amount * pool_balances.token1) / lp_token_supply
  token2_to_remove = (user_amount * pool_balances.token2) / lp_token_supply

  new_token1_reserve = pool_balances.token1 - token1_to_remove
  new_token2_reserve = pool_balances.token2 - token2_to_remove

  contract_state = Map.set(contract_state, "lp_token_supply", lp_token_supply - user_amount)
  contract_state = Map.set(contract_state, "reserves", [token1: new_token1_reserve, token2: new_token2_reserve])
  
  Contract.add_recipient(
    address: @STATE_ADDRESS,
    action: "update_state",
    args: [contract_state]
  )

  Contract.set_type("transfer")
  Contract.add_token_transfer(to: transaction.address, amount: token1_to_remove, token_address: @TOKEN1)
  Contract.add_token_transfer(to: transaction.address, amount: token2_to_remove, token_address: @TOKEN2)
end

condition triggered_by: transaction, on: swap(min_to_receive), as: [
  token_transfers: (
    valid? = false

    transfer = get_user_transfer(transaction.token_transfers)
    if transfer != nil do
      contract_state = Contract.call_function(@STATE_ADDRESS, "get_state", [])
      reserves = Map.get(contract_state, "reserves")

      if reserves.token1 > 0 && reserves.token2 > 0 do
        output_amount = get_output_amount(transfer.token_address, transfer.amount, reserves)

        reserve_amount = 0
        if transfer.token_address == @TOKEN1 do
          reserve_amount = reserves.token2
        else
          reserve_amount = reserves.token1
        end

        valid? = output_amount > 0 && output_amount >= min_to_receive && output_amount < reserve_amount
      end
    end

    valid? 
  )
]

actions triggered_by: transaction, on: swap(_min_to_receive) do
  transfer = get_user_transfer(transaction.token_transfers)

  contract_state = Contract.call_function(@STATE_ADDRESS, "get_state", [])
  reserves = Map.get(contract_state, "reserves")

  output_amount = get_output_amount(transfer.token_address, transfer.amount, reserves)

  pool_balances = get_pool_balances()
  token_to_send = nil
  if transfer.token_address == @TOKEN1 do
    pool_balances = Map.set(pool_balances, "token2", pool_balances.token2 - output_amount)
    token_to_send = @TOKEN2 
  else
    pool_balances = Map.set(pool_balances, "token1", pool_balances.token1 - output_amount)
    token_to_send = @TOKEN1
  end

  contract_state = Map.set(contract_state, "reserves", [token1: pool_balances.token1, token2: pool_balances.token2])

  Contract.add_recipient(
    address: @STATE_ADDRESS,
    action: "update_state",
    args: [contract_state]
  )

  Contract.set_type("transfer")
  Contract.add_token_transfer(to: transaction.address, amount: output_amount, token_address: token_to_send)
end

export fun get_pair_tokens() do
  [@TOKEN1, @TOKEN2]
end

fun get_equivalent_amount(token_address, amount, reserves) do
  ratio = 0
  if token_address = @TOKEN1 do
    ratio = reserves.token2 / reserves.token1
  else
    ratio = reserves.token1 / reserves.token2
  end

  amount * ratio
end

fun get_final_amounts(user_amounts, reserves, token1_min_amount, token2_min_amount) do
  final_token1_amount = 0
  final_token2_amount = 0

  if reserves.token1 > 0 && reserves.token2 > 0 do
    token1_ratio = reserves.token1 / reserves.token2
    token2_ratio = reserves.token2 / reserves.token1
    
    token1_equivalent_amount = user_amounts.token2 * token1_ratio
    token2_equivalent_amount = user_amounts.token1 * token2_ratio

    if token2_equivalent_amount <= user_amounts.token2 && token2_equivalent_amount >= token2_min_amount do
      final_token1_amount = user_amounts.token1
      final_token2_amount = token2_equivalent_amount
    else
      if token1_equivalent_amount <= user_amounts.token1 && token1_equivalent_amount >= token1_min_amount do
        final_token1_amount = token1_equivalent_amount
        final_token2_amount = user_amounts.token2
      end
    end
  else
    # No reserve
    final_token1_amount = user_amounts.token1
    final_token2_amount = user_amounts.token2
  end

  [token1: final_token1_amount, token2: final_token2_amount]
end

fun get_user_transfers_amount(token_transfers) do
  contract_address = @POOL_ADDRESS

  token1_amount = 0
  token2_amount = 0
  transfers = Map.get(token_transfers, contract_address)

  if List.size(transfers) == 2 do
    for transfer in transfers do
      if transfer.token_address == @TOKEN1 do
        token1_amount = transfer.amount
      end
      if transfer.token_address == @TOKEN2 do
        token2_amount = transfer.amount
      end
    end
  end

  [token1: token1_amount, token2: token2_amount]
end

fun get_user_transfer(token_transfers) do
  contract_address = @POOL_ADDRESS

  token_transfer = nil
  transfers = Map.get(token_transfers, contract_address)
  
  transfer = List.at(transfers, 0)

  if List.size(transfers) == 1 && List.in?(get_pair_tokens(), transfer.token_address) do
    token_transfer = transfer
  end

  token_transfer
end

fun get_user_lp_amount(token_transfers) do
  lp_token = @LP_TOKEN

  lp_amount = 0
  transfers = Map.get(token_transfers, Chain.get_burn_address(), [])

  for transfer in transfers do
    if transfer.token_address == lp_token do
      lp_amount = transfer.amount
    end
  end

  lp_amount
end

fun get_lp_token_to_mint(lp_token_supply, token1_amount, token2_amount, reserves) do
  if lp_token_supply == 0 || reserves.token1 == 0 || reserves.token2 == 0 do
    # First liquidity
    Math.sqrt(token1_amount * token2_amount)
  else
    mint_amount1 = (token1_amount * lp_token_supply) / reserves.token1
    mint_amount2 = (token2_amount * lp_token_supply) / reserves.token2

    if mint_amount1 < mint_amount2 do
      mint_amount1
    else
      mint_amount2
    end
  end
end

fun get_lp_share(amount, lp_token_supply) do
  amount / lp_token_supply
end

fun get_output_amount(token_address, amount, reserves) do
  amount_with_fee = amount * 0.997

  if token_address == @TOKEN1 do
    (amount_with_fee * reserves.token2) / (amount_with_fee + reserves.token1)
  else
    (amount_with_fee * reserves.token1) / (amount_with_fee + reserves.token2)
  end
end

fun get_pool_balances() do
  token1_id = [token_address: @TOKEN1, token_id: 0]
  token2_id = [token_address: @TOKEN2, token_id: 0]

  balances = Chain.get_tokens_balance(contract.address, [token1_id, token2_id])

  [
    token1: Map.get(balances, token1_id, 0),
    token2: Map.get(balances, token2_id, 0),
  ]
end

export fun get_token_lp_address() do
  @LP_TOKEN
end

export fun get_fee() do
  0.3
end
