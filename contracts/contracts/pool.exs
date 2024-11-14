@version 1

condition triggered_by: transaction, on: add_liquidity(token1_min_amount, token2_min_amount), as: [
  token_transfers: (
    user_amounts = get_user_transfers_amount(transaction)

    valid_transfers? = user_amounts.token1 > 0 && user_amounts.token2 > 0
    valid_min? = user_amounts.token1 >= token1_min_amount && user_amounts.token2 >= token2_min_amount

    valid_transfers? && valid_min?
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

  token1_amount = user_amounts.token1 + pool_balances.token1 - reserves.token1 - token1_to_refund
  token2_amount = user_amounts.token2 + pool_balances.token2 - reserves.token2 - token2_to_refund

  lp_token_to_mint = get_lp_token_to_mint(token1_amount, token2_amount)

  # Handle invalid values and refund user 
  valid_amounts? = final_amounts.token1 > 0 && final_amounts.token2 > 0
  valid_liquidity? = lp_token_to_mint > 0

  if valid_amounts? && valid_liquidity? do
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

    new_token1_reserve = user_amounts.token1 + pool_balances.token1 - token1_to_refund
    new_token2_reserve = user_amounts.token2 + pool_balances.token2 - token2_to_refund

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
  else
    # Liquidity provision is invalid, refund user of it's tokens
    Contract.set_type("transfer")

    if @TOKEN2 == "UCO" do
      Contract.add_uco_transfer(to: transaction.address, amount: user_amounts.token2)
    else
      Contract.add_token_transfer(to: transaction.address, amount: user_amounts.token2, token_address: @TOKEN2)
    end

    Contract.add_token_transfer(to: transaction.address, amount: user_amounts.token1, token_address: @TOKEN1)
  end
end

condition triggered_by: transaction, on: remove_liquidity(), as: [
  token_transfers: (
    user_amount = get_user_lp_amount(transaction.token_transfers)

    user_amount > 0
  )
]

actions triggered_by: transaction, on: remove_liquidity() do
  return? = true

  user_amount = get_user_lp_amount(transaction.token_transfers)
  lp_token_supply = State.get("lp_token_supply", 0)

  if lp_token_supply > 0 do
    pool_balances = get_pool_balances()

    token1_to_remove = (user_amount * pool_balances.token1) / lp_token_supply
    token2_to_remove = (user_amount * pool_balances.token2) / lp_token_supply

    if token1_to_remove > 0 && token2_to_remove > 0 do
      return? = false

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
  end

  if return? do
    # Refund is invalid, return LP tokens to user
    Contract.set_type("transfer")
    Contract.add_token_transfer(to: transaction.address, amount: user_amount, token_address: @LP_TOKEN)
  end
end

condition triggered_by: transaction, on: swap(_min_to_receive), as: [
  token_transfers: (
    transfer = get_user_transfer(transaction)

    transfer != nil
  )
]

actions triggered_by: transaction, on: swap(min_to_receive) do
  transfer = get_user_transfer(transaction)

  swap = get_output_swap_infos(transfer.token_address, transfer.amount)

  if swap.output_amount > 0 && swap.output_amount >= min_to_receive do

    pool_balances = get_pool_balances()
    token_to_send = nil
    token1_volume = 0
    token2_volume = 0
    token1_fee = 0
    token2_fee = 0
    token1_protocol_fee = 0
    token2_protocol_fee = 0
    if transfer.token_address == @TOKEN1 do
      pool_balances = [
        token1: pool_balances.token1 + transfer.amount - swap.protocol_fee,
        token2: pool_balances.token2 - swap.output_amount
      ]
      token_to_send = @TOKEN2
      token1_volume = transfer.amount
      token1_fee = swap.fee
      token1_protocol_fee = swap.protocol_fee
    else
      pool_balances = [
        token1: pool_balances.token1 - swap.output_amount,
        token2: pool_balances.token2 + transfer.amount - swap.protocol_fee
      ]
      token_to_send = @TOKEN1
      token2_volume = transfer.amount
      token2_fee = swap.fee
      token2_protocol_fee = swap.protocol_fee
    end

    State.set("reserves", [token1: pool_balances.token1, token2: pool_balances.token2])

    stats = State.get("stats", [
      token1_total_fee: 0,
      token2_total_fee: 0,
      token1_total_volume: 0,
      token2_total_volume: 0,
      token1_total_protocol_fee: 0,
      token2_total_protocol_fee: 0,
    ])

    token1_total_fee = Map.get(stats, "token1_total_fee") + token1_fee
    token2_total_fee = Map.get(stats, "token2_total_fee") + token2_fee
    token1_total_volume = Map.get(stats, "token1_total_volume") + token1_volume
    token2_total_volume = Map.get(stats, "token2_total_volume") + token2_volume
    token1_total_protocol_fee = Map.get(stats, "token1_total_protocol_fee") + token1_protocol_fee
    token2_total_protocol_fee = Map.get(stats, "token2_total_protocol_fee") + token2_protocol_fee

    stats = Map.set(stats, "token1_total_fee", token1_total_fee)
    stats = Map.set(stats, "token2_total_fee", token2_total_fee)
    stats = Map.set(stats, "token1_total_volume", token1_total_volume)
    stats = Map.set(stats, "token2_total_volume", token2_total_volume)
    stats = Map.set(stats, "token1_total_protocol_fee", token1_total_protocol_fee)
    stats = Map.set(stats, "token2_total_protocol_fee", token2_total_protocol_fee)

    State.set("stats", stats)

    Contract.set_type("transfer")
    if token_to_send == "UCO" do
      Contract.add_uco_transfer(to: transaction.address, amount: swap.output_amount)
    else
      Contract.add_token_transfer(to: transaction.address, amount: swap.output_amount, token_address: token_to_send)
    end

    if swap.protocol_fee > 0 do
      if transfer.token_address == "UCO" do
        Contract.add_uco_transfer(to: @PROTOCOL_FEE_ADDRESS, amount: swap.protocol_fee)
      else
        Contract.add_token_transfer(to: @PROTOCOL_FEE_ADDRESS, amount: swap.protocol_fee, token_address: transfer.token_address)
      end
    end
  else
    # Swap is invalid, return tokens to user
    Contract.set_type("transfer")

    if transfer.token_address == @TOKEN1 do
      Contract.add_token_transfer(to: transaction.address, amount: transfer.amount, token_address: @TOKEN1)
    else
      if transfer.token_address == "UCO" do
        Contract.add_uco_transfer(to: transaction.address, amount: transfer.amount)
      else
        Contract.add_token_transfer(to: transaction.address, amount: transfer.amount, token_address: @TOKEN2)
      end
    end
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

  new_code = Contract.call_function(@FACTORY_ADDRESS, "get_pool_code", params)

  if Code.is_valid?(new_code) do
    Contract.set_type("contract")
    Contract.set_code(new_code)
  end
end

condition triggered_by: transaction, on: set_protocol_fee(new_protocol_fee), as: [
  content: new_protocol_fee <= 1 && new_protocol_fee >= 0,
  previous_public_key: (
    previous_address = Chain.get_previous_address()
    Chain.get_genesis_address(previous_address) == @MASTER_ADDRESS
  )
]

actions triggered_by: transaction, on: set_protocol_fee(new_protocol_fee) do
  State.set("protocol_fee", new_protocol_fee)
end

condition triggered_by: transaction, on: set_lp_fee(new_lp_fee), as: [
  content: new_lp_fee <= 1 && new_lp_fee >= 0,
  previous_public_key: (
    previous_address = Chain.get_previous_address()
    Chain.get_genesis_address(previous_address) == @MASTER_ADDRESS
  )
]

actions triggered_by: transaction, on: set_lp_fee(new_lp_fee) do
  State.set("lp_fee", new_lp_fee)
end

export fun get_ratio(token_address) do
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
  ratio
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

export fun get_output_swap_infos(token_address, input_amount) do
  output_amount = 0
  fee = 0
  protocol_fee = 0
  price_impact = 0

  reserves = State.get("reserves", [token1: 0, token2: 0])
  token_address = String.to_uppercase(token_address)

  if reserves.token1 > 0 && reserves.token2 > 0 do
    fee = input_amount * State.get("lp_fee", 0.3) / 100
    protocol_fee = input_amount * State.get("protocol_fee", 0) / 100
    amount_with_fee = input_amount - fee - protocol_fee

    market_price = 0

    if token_address == @TOKEN1 do
      market_price = reserves.token2 / reserves.token1
      amount = (amount_with_fee * reserves.token2) / (amount_with_fee + reserves.token1)
      if amount < reserves.token2 do
        output_amount = amount
      end
    else
      market_price = reserves.token1 / reserves.token2
      amount = (amount_with_fee * reserves.token1) / (amount_with_fee + reserves.token2)
      if amount < reserves.token1 do
        output_amount = amount
      end
    end

    # This check is necessary as there might be some approximation in small decimal calculation
    output_price = output_amount / input_amount
    if output_amount > 0 && market_price > output_price do
      price_impact = 100 - (output_price * 100 / market_price)
    end
  end

  [
    output_amount: output_amount,
    fee: fee,
    protocol_fee: protocol_fee,
    price_impact: price_impact
  ]
end

export fun get_input_swap_infos(token_address, output_amount) do
  input_amount = 0
  lp_fee = State.get("lp_fee", 0.3) / 100
  protocol_fee = State.get("protocol_fee", 0) / 100
  price_impact = 0

  reserves = State.get("reserves", [token1: 0, token2: 0])
  token_address = String.to_uppercase(token_address)

  if reserves.token1 > 0 && reserves.token2 > 0 do

    market_price = 0

    if token_address == @TOKEN1 && output_amount < reserves.token1 do
      market_price = reserves.token1 / reserves.token2
      input_amount = (output_amount * reserves.token2) / ((reserves.token1 - output_amount) * (1 - lp_fee - protocol_fee))
    else
      if output_amount < reserves.token2 do
        market_price = reserves.token2 / reserves.token1
        input_amount = (output_amount * reserves.token1) / ((reserves.token2 - output_amount) * (1 - lp_fee - protocol_fee))
      end
    end

    if input_amount > 0 do
      # This check is necessary as there might be some approximation in small decimal calculation
      output_price = output_amount / input_amount
      if market_price > output_price do
        price_impact = 100 - (output_price * 100 / market_price)
      end
    end
  end

  [
    input_amount: input_amount,
    fee: input_amount * lp_fee,
    protocol_fee: input_amount * protocol_fee,
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
  stats = State.get("stats", [
    token1_total_fee: 0,
    token2_total_fee: 0,
    token1_total_volume: 0,
    token2_total_volume: 0,
    token1_total_protocol_fee: 0,
    token2_total_protocol_fee: 0,
  ])

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
    fee: State.get("lp_fee", 0.3),
    protocol_fee: State.get("protocol_fee", 0),
    stats: stats
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
  transfers = Map.get(tx.token_transfers, contract_address, [])

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
  token2_balance = 0
  if @TOKEN2 == "UCO" do
    token2_balance = contract.balance.uco
  else
    token2_id = [token_address: @TOKEN2, token_id: 0]
    token2_balance = Map.get(contract.balance.tokens, token2_id, 0)
  end

  token1_id = [token_address: @TOKEN1, token_id: 0]
  [
    token1: Map.get(contract.balance.tokens, token1_id, 0),
    token2: token2_balance
  ]
end
