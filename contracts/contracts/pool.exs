@version 1

condition triggered_by: transaction, on: add_liquidity(token1_min_amount, token2_min_amount), as: [
  token_transfers: (
    valid_amounts? = false
    valid_liquidity? = false

    user_amounts = get_user_transfers_amount(transaction)

    if user_transfers.token1 > 0 && user_transfers.token2 > 0 do
      lp_token_supply = State.get("lp_token_supply", 0)
      reserves = State.get("reserves", [token1: 0, token2: 0])

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

        lp_token_to_mint = get_lp_token_to_mint(token1_amount, token2_amount)

        valid_liquidity? = lp_token_to_mint != 0
      end
    end

    log("valid_amounts? #{valid_amounts?}")
    log("valid_liquidity? #{valid_liquidity?}")

    valid_amounts? && valid_liquidity?
  )
]

actions triggered_by: transaction, on: add_liquidity(token1_min_amount, token2_min_amount) do
  pool_balances = get_pool_balances()
  user_amounts = get_user_transfers_amount(transaction)

  lp_token_supply = State.get("lp_token_supply", 0)
  reserves = State.get("reserves", [token1: 0, token2: 0])

  final_amounts = get_final_amounts(user_amounts, reserves, token1_min_amount, token2_min_amount)
  token1_to_refund = user_amounts.token1 - final_amounts.token1
  token2_to_refund = user_amounts.token2 - final_amounts.token2

  token1_amount = pool_balances.token1 - reserves.token1 - token1_to_refund
  token2_amount = pool_balances.token2 - reserves.token2 - token2_to_refund

  lp_token_to_mint = get_lp_token_to_mint(token1_amount, token2_amount)
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

  State.set("lp_token_supply", lp_token_supply + lp_token_to_mint)
  State.set("reserves", [token1: new_token1_reserve, token2: new_token2_reserve])

  if token1_to_refund > 0 do
    Contract.add_token_transfer(to: transaction.address, amount: token1_to_refund, token_address: @TOKEN1)
  end

  if token2_to_refund > 0 do
    if @TOKEN2 == "UCO" do
      Contract.add_uco_transfer(to: transaction.address, amount: token2_to_refund)
    else
      Contract.add_token_transfer(to: transaction.address, amount: token2_to_refund, token_address: @TOKEN2)
    end
  end

  Contract.set_type("token")
  Contract.set_content(Json.to_string(token_specification))
end

condition triggered_by: transaction, on: remove_liquidity(), as: [
  token_transfers: (
    valid? = false

    user_amount = get_user_lp_amount(transaction.token_transfers)
    lp_token_supply = State.get("lp_token_supply", 0)

    if user_amount > 0 && lp_token_supply > 0 do
      pool_balances = get_pool_balances()

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

  lp_token_supply = State.get("lp_token_supply")

  token1_to_remove = (user_amount * pool_balances.token1) / lp_token_supply
  token2_to_remove = (user_amount * pool_balances.token2) / lp_token_supply

  new_token1_reserve = pool_balances.token1 - token1_to_remove
  new_token2_reserve = pool_balances.token2 - token2_to_remove

  State.set("lp_token_supply", lp_token_supply - user_amount)
  State.set("reserves", [token1: new_token1_reserve, token2: new_token2_reserve])

  Contract.set_type("transfer")
  Contract.add_token_transfer(to: transaction.address, amount: token1_to_remove, token_address: @TOKEN1)
  if @TOKEN2 == "UCO" do
    Contract.add_uco_transfer(to: transaction.address, amount: token2_to_remove)
  else
    Contract.add_token_transfer(to: transaction.address, amount: token2_to_remove, token_address: @TOKEN2)
  end
end

condition triggered_by: transaction, on: swap(min_to_receive), as: [
  token_transfers: (
    valid? = false

    transfer = get_user_transfer(transaction)
    if transfer != nil do
        swap = get_swap_infos(transfer.token_address, transfer.amount)

        valid? = swap.output_amount > 0 && swap.output_amount >= min_to_receive
    end

    valid? 
  )
]

actions triggered_by: transaction, on: swap(_min_to_receive) do
  transfer = get_user_transfer(transaction)

  swap = get_swap_infos(transfer.token_address, transfer.amount)

  pool_balances = get_pool_balances()
  token_to_send = nil
  if transfer.token_address == @TOKEN1 do
    pool_balances = Map.set(pool_balances, "token2", pool_balances.token2 - swap.output_amount)
    token_to_send = @TOKEN2 
  else
    pool_balances = Map.set(pool_balances, "token1", pool_balances.token1 - swap.output_amount)
    token_to_send = @TOKEN1
  end

  State.set("reserves", [token1: pool_balances.token1, token2: pool_balances.token2])

  Contract.set_type("transfer")
  if token_to_send == "UCO" do
    Contract.add_uco_transfer(to: transaction.address, amount: swap.output_amount)
  else
    Contract.add_token_transfer(to: transaction.address, amount: swap.output_amount, token_address: token_to_send)
  end
end

condition triggered_by: transaction, on: update_code(), as: [
  previous_public_key: (
    # Pool code can only be updated from the router contract of the dex

    # Transaction is not yet validated so we need to use previous address
    # to get the genesis address
    previous_address = Chain.get_previous_address()
    Chain.get_genesis_address(previous_address) == @ROUTER_ADDRESS
  )
]

actions triggered_by: transaction, on: update_code() do
  params = [
    @TOKEN1,
    @TOKEN2,
    @POOL_ADDRESS,
    @LP_TOKEN
  ]

  new_code = Contract.call_function(@ROUTER_ADDRESS, "get_pool_code", params)

  if Code.is_valid?(new_code) && !Code.is_same?(new_code, contract.code) do
    Contract.set_type("contract")
    Contract.set_code(new_code)
  end
end

export fun get_equivalent_amount(token_address, amount) do
  reserves = State.get("reserves", [token1: 0, token2: 0])
  ratio = 0

  token_address = String.to_uppercase(token_address)

  if reserves.token1 > 0 && reserves.token2 > 0 do
    if token_address == @TOKEN1 do
      ratio = reserves.token2 / reserves.token1
    else
      ratio = reserves.token1 / reserves.token2
    end
  end

  amount * ratio
end

export fun get_lp_token_to_mint(token1_amount, token2_amount) do
  lp_token_supply = State.get("lp_token_supply", 0)
  reserves = State.get("reserves", [token1: 0, token2: 0])

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

export fun get_swap_infos(token_address, amount) do
  output_amount = 0
  fee = 0
  price_impact = 0

  reserves = State.get("reserves", [token1: 0, token2: 0])
  token_address = String.to_uppercase(token_address)

  if reserves.token1 > 0 && reserves.token2 > 0 do
    fee = amount * 0.003
    amount_with_fee = amount - fee

    market_price = 0

    if token_address == @TOKEN1 do
      market_price = amount_with_fee * (reserves.token2 / reserves.token1)
      amount = (amount_with_fee * reserves.token2) / (amount_with_fee + reserves.token1)
      if amount < reserves.token2 do
        output_amount = amount
      end
    else
      market_price = amount_with_fee * (reserves.token1 / reserves.token2)
      amount = (amount_with_fee * reserves.token1) / (amount_with_fee + reserves.token2)
      if amount < reserves.token1 do
        output_amount = amount
      end
    end

    if output_amount > 0 do
      price_impact = ((market_price / output_amount) - 1) * 100
    end
  end

  [
    output_amount: output_amount,
    fee: fee,
    price_impact: price_impact
  ]
end

export fun get_remove_amounts(lp_token_amount) do
  reserves = State.get("reserves", [token1: 0, token2: 0])
  lp_token_supply = State.get("lp_token_supply", 0)

  token1_to_remove = 0
  token2_to_remove = 0
  
  if lp_token_supply > 0 && lp_token_amount < lp_token_supply do
    token1_to_remove = (lp_token_amount * reserves.token1) / lp_token_supply
    token2_to_remove = (lp_token_amount * reserves.token2) / lp_token_supply
  end

  [token1: token1_to_remove, token2: token2_to_remove]
end

export fun get_pool_infos() do
  reserves = State.get("reserves", [token1: 0, token2: 0])

  [
    token1: [
      address: @TOKEN1,
      reserve: reserves.token1
    ],
    token2: [
      address: @TOKEN2,
      reserve: reserves.token2
    ],
    lp_token: [
      address: @LP_TOKEN,
      supply: State.get("lp_token_supply", 0)
    ],
    fee: 0.3
  ]
end

fun get_final_amounts(user_amounts, reserves, token1_min_amount, token2_min_amount) do
  final_token1_amount = 0
  final_token2_amount = 0

  if reserves.token1 > 0 && reserves.token2 > 0 do
    token2_ratio = reserves.token2 / reserves.token1
    token2_equivalent_amount = user_amounts.token1 * token2_ratio

    if token2_equivalent_amount <= user_amounts.token2 && token2_equivalent_amount >= token2_min_amount do
      final_token1_amount = user_amounts.token1
      final_token2_amount = token2_equivalent_amount
    else
      token1_ratio = reserves.token1 / reserves.token2
      token1_equivalent_amount = user_amounts.token2 * token1_ratio

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

fun get_user_transfers_amount(tx) do
  contract_address = @POOL_ADDRESS

  token1_amount = 0
  token2_amount = 0
  transfers = Map.get(tx.token_transfers, contract_address)

  uco_amount = Map.get(tx.uco_transfers, contract_address)
  if uco_amount != nil do
    transfers = List.prepend(transfers, [token_address: "UCO", amount: uco_amount])
  end

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

fun get_user_transfer(tx) do
  contract_address = @POOL_ADDRESS

  token_transfer = nil
  transfers = Map.get(tx.token_transfers, contract_address, [])

  uco_amount = Map.get(tx.uco_transfers, contract_address)
  if uco_amount != nil do
    transfers = List.prepend(transfers, [token_address: "UCO", amount: uco_amount])
  end
  
  transfer = List.at(transfers, 0)

  tokens = [
    @TOKEN1,
    @TOKEN2
  ]

  if List.size(transfers) == 1 && List.in?(tokens, transfer.token_address) do
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

fun get_pool_balances() do

  balances = Chain.get_balance(contract.address)

  token2_balance = 0
  if @TOKEN2 == "UCO" do
    token2_balance = balances.uco
  else
    token2_id = [token_address: @TOKEN2, token_id: 0]
    token2_balance = Map.get(balances, token2_id, 0)
  end

  token1_id = [token_address: @TOKEN1, token_id: 0]
  [
    token1: Map.get(balances.tokens, token1_id, 0),
    token2: token2_balance
  ]
end
