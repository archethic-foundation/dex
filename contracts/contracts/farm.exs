@version 1

condition triggered_by: transaction, on: deposit(), as: [
  timestamp: transaction.timestamp < @END_DATE,
  token_transfers: get_user_transfer_amount(transaction) > 0
]

actions triggered_by: transaction, on: deposit() do
  transfer_amount = get_user_transfer_amount(transaction)

  previous_address = Chain.get_previous_address(transaction)
  user_genesis_address = Chain.get_genesis_address(previous_address)

  deposits = nil
  if Time.now() > @START_DATE do
    res = calculate_new_rewards()
    deposits = res.deposits
    State.set("rewards_reserved", res.rewards_reserved)
    State.set("last_calculation_timestamp", res.last_calculation_timestamp)
  else
    deposits = State.get("deposits", Map.new())
  end

  user_deposit = Map.get(deposits, user_genesis_address, [amount: 0, reward_amount: 0])
  user_deposit = Map.set(user_deposit, "amount", user_deposit.amount + transfer_amount)
  deposits = Map.set(deposits, user_genesis_address, user_deposit)

  State.set("deposits", deposits)

  lp_token_deposited = State.get("lp_token_deposited", 0)
  State.set("lp_token_deposited", lp_token_deposited + transfer_amount)
end

condition triggered_by: transaction, on: claim(), as: [
  timestamp: transaction.timestamp > @START_DATE,
  previous_public_key: (
    previous_address = Chain.get_previous_address()
    genesis_address = Chain.get_genesis_address(previous_address)

    deposits = State.get("deposits", Map.new())
    if Map.get(deposits, genesis_address) != nil do
      res = calculate_new_rewards()
      user_deposit = Map.get(res.deposits, user_genesis_address)
      user_deposit.reward_amount > 0
    else
      false
    end
  )
]

actions triggered_by: transaction, on: claim() do
  previous_address = Chain.get_previous_address(transaction)
  user_genesis_address = Chain.get_genesis_address(previous_address)

  res = calculate_new_rewards()
  deposits = res.deposits
  State.set("last_calculation_timestamp", res.last_calculation_timestamp)

  user_deposit = Map.get(deposits, user_genesis_address)

  if @REWARD_TOKEN == "UCO" do
    Contract.add_uco_transfer(to: transaction.address, amount: user_deposit.reward_amount)
  else
    Contract.add_token_transfer(
      to: transaction.address,
      amount: user_deposit.reward_amount,
      token_address: @REWARD_TOKEN
    )
  end

  reward_distributed = State.get("reward_distributed", 0)
  State.set("reward_distributed", reward_distributed + user_deposit.reward_amount)

  State.set("rewards_reserved", res.rewards_reserved - user_deposit.reward_amount)

  new_user_deposit = Map.set(user_deposit, "reward_amount", 0)
  deposits = Map.set(deposits, user_genesis_address, new_user_deposit)

  State.set("deposits", deposits)
end

condition triggered_by: transaction, on: withdraw(amount), as: [
  previous_public_key: (
    previous_address = Chain.get_previous_address()
    genesis_address = Chain.get_genesis_address(previous_address)

    deposits = State.get("deposits", Map.new())
    user_deposit = Map.get(deposits, genesis_address)

    user_deposit != nil && user_deposit.amount >= amount
  )
]

actions triggered_by: transaction, on: withdraw(amount) do
  previous_address = Chain.get_previous_address(transaction)
  user_genesis_address = Chain.get_genesis_address(previous_address)

  deposits = nil
  rewards_reserved = 0
  if Time.now() > @START_DATE do
    res = calculate_new_rewards()
    deposits = res.deposits
    rewards_reserved = res.rewards_reserved
    State.set("last_calculation_timestamp", res.last_calculation_timestamp)
  else
    deposits = State.get("deposits", Map.new())
    rewards_reserved = State.get("rewards_reserved", 0)
  end

  user_deposit = Map.get(deposits, user_genesis_address)

  if user_deposit.reward_amount > 0 do
    if @REWARD_TOKEN == "UCO" do
      Contract.add_uco_transfer(to: transaction.address, amount: user_deposit.reward_amount)
    else
      Contract.add_token_transfer(
        to: transaction.address,
        amount: user_deposit.reward_amount,
        token_address: @REWARD_TOKEN
      )
    end

    reward_distributed = State.get("reward_distributed", 0)
    State.set("reward_distributed", reward_distributed + user_deposit.reward_amount)
  
    rewards_reserved = rewards_reserved - user_deposit.reward_amount
  end

  State.set("rewards_reserved", rewards_reserved)

  Contract.add_token_transfer(
    to: transaction.address,
    amount: amount,
    token_address: @LP_TOKEN_ADDRESS
  )

  lp_token_deposited = State.get("lp_token_deposited")
  State.set("lp_token_deposited", lp_token_deposited - amount)

  if amount == user_deposit.amount do
    deposits = Map.delete(deposits, user_genesis_address)
  else
    new_deposit = Map.set(user_deposit, "reward_amount", 0)
    new_deposit = Map.set(new_deposit, "amount", user_deposit.amount - amount)
    deposits = Map.set(deposits, user_genesis_address, new_deposit)
  end

  State.set("deposits", deposits)
end

condition triggered_by: transaction, on: update_dates(new_start_date, new_end_date), as: [
  previous_public_key: (
    # Can only be updated by master chain of the dex
    previous_address = Chain.get_previous_address()
    Chain.get_genesis_address(previous_address) == @MASTER_ADDRESS
  ),
  content: (
    # Can update date only if farm is already ended
    now = Time.now()

    valid_update_date? = now >= @END_DATE
    valid_start_date? = now + 7200 <= new_start_date && now + 604800 >= new_start_date
    valid_end_date? = new_start_date + 2592000 <= new_end_date && new_start_date + 31536000 >= new_end_date 

    valid_update_date? && valid_start_date? && valid_end_date?
  )
]

actions triggered_by: transaction, on: update_dates(new_start_date, new_end_date) do
  params = [
    @LP_TOKEN_ADDRESS,
    new_start_date,
    new_end_date,
    @REWARD_TOKEN,
    @FARM_ADDRESS
  ]

  new_code = Contract.call_function(@FACTORY_ADDRESS, "get_farm_code", params)

  if Code.is_valid?(new_code) && !Code.is_same?(new_code, contract.code) do
    Contract.set_type("contract")
    Contract.set_code(new_code)
    Contract.add_recipient(
      address: @ROUTER_ADDRESS,
      action: "update_farm_dates",
      args: [new_start_date, new_end_date]
    )

    res = calculate_new_rewards()
    State.set("deposits", res.deposits)
    State.set("rewards_reserved", res.rewards_reserved)
    State.delete("last_calculation_timestamp")
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
    @LP_TOKEN_ADDRESS,
    @START_DATE,
    @END_DATE,
    @REWARD_TOKEN,
    @FARM_ADDRESS
  ]

  new_code = Contract.call_function(@FACTORY_ADDRESS, "get_farm_code", params)

  if Code.is_valid?(new_code) && !Code.is_same?(new_code, contract.code) do
    Contract.set_type("contract")
    Contract.set_code(new_code)
  end
end

fun get_reward_token_balance() do
  if @REWARD_TOKEN == "UCO" do
    contract.balance.uco
  else
    key = [token_address: @REWARD_TOKEN, token_id: 0]
    Map.get(contract.balance.tokens, key, 0)
  end
end

fun get_user_transfer_amount(tx) do
  transfers = Map.get(transaction.token_transfers, @FARM_ADDRESS, [])
  transfer = List.at(transfers, 0)

  if transfer != nil && transfer.token_address == @LP_TOKEN_ADDRESS do
    transfer.amount
  else
    0
  end
end

fun calculate_new_rewards() do
  deposits = State.get("deposits", Map.new())
  lp_token_deposited = State.get("lp_token_deposited", 0)
  rewards_reserved = State.get("rewards_reserved", 0)
  last_calculation_timestamp = State.get("last_calculation_timestamp", @START_DATE)

  now = Time.now()

  if last_calculation_timestamp < now && last_calculation_timestamp < @END_DATE && lp_token_deposited > 0 do
    rewards_balance = 0
    if @REWARD_TOKEN == "UCO" do
      rewards_balance = contract.balance.uco
    else
      key = [token_address: @REWARD_TOKEN, token_id: 0]
      rewards_balance = Map.get(contract.balance.tokens, key, 0)
    end

    available_balance = rewards_balance - rewards_reserved

    amount_to_allocate = 0
    if now >= @END_DATE do
      amount_to_allocate = available_balance
    else
      time_elapsed = now - last_calculation_timestamp
      time_remaining = @END_DATE - last_calculation_timestamp

      amount_to_allocate = available_balance * (time_elapsed / time_remaining)
    end

    if amount_to_allocate > 0 do
      for address in Map.keys(deposits) do
        deposit = Map.get(deposits, address)
        new_reward_amount = amount_to_allocate * (deposit.amount / lp_token_deposited)

        if new_reward_amount > 0 do
          deposit = Map.set(deposit, "reward_amount", deposit.reward_amount + new_reward_amount)
          deposits = Map.set(deposits, address, deposit)

          rewards_reserved = rewards_reserved + new_reward_amount
          last_calculation_timestamp = now
        end
      end
    end
  end

  [
    deposits: deposits,
    rewards_reserved: rewards_reserved,
    last_calculation_timestamp: last_calculation_timestamp
  ]
end

export fun get_farm_infos() do
  reward_token_balance = 0
  if @REWARD_TOKEN == "UCO" do
    reward_token_balance = contract.balance.uco
  else
    key = [token_address: @REWARD_TOKEN, token_id: 0]
    reward_token_balance = Map.get(contract.balance.tokens, key, 0)
  end

  remaining_reward = nil
  if reward_token_balance != nil do
    remaining_reward = reward_token_balance - State.get("rewards_reserved", 0)
  end

  [
    lp_token_address: @LP_TOKEN_ADDRESS,
    reward_token: @REWARD_TOKEN,
    start_date: @START_DATE,
    end_date: @END_DATE,
    remaining_reward: remaining_reward,
    lp_token_deposited: State.get("lp_token_deposited", 0),
    nb_deposit: Map.size(State.get("deposits", Map.new())),
    stats: [
      reward_distributed: State.get("reward_distributed", 0)
    ]
  ]
end

export fun get_user_infos(user_genesis_address) do
  user_genesis_address = String.to_hex(user_genesis_address)

  deposits = State.get("deposits", Map.new())
  user_deposit = Map.get(deposits, user_genesis_address)

  if user_deposit != nil do
    lp_token_deposited = State.get("lp_token_deposited", 0)
    last_calculation_timestamp = State.get("last_calculation_timestamp", @START_DATE)

    now = Time.now()

    if now > @START_DATE && last_calculation_timestamp < now && last_calculation_timestamp < @END_DATE && lp_token_deposited > 0 do
      rewards_balance = 0
      if @REWARD_TOKEN == "UCO" do
        rewards_balance = contract.balance.uco
      else
        key = [token_address: @REWARD_TOKEN, token_id: 0]
        rewards_balance = Map.get(contract.balance.tokens, key, 0)
      end

      rewards_reserved = State.get("rewards_reserved", 0)

      available_balance = rewards_balance - rewards_reserved

      amount_to_allocate = 0
      if now >= @END_DATE do
        amount_to_allocate = available_balance
      else
        time_elapsed = now - last_calculation_timestamp
        time_remaining = @END_DATE - last_calculation_timestamp

        amount_to_allocate = available_balance * (time_elapsed / time_remaining)
      end

      if amount_to_allocate > 0 do
        new_reward_amount = amount_to_allocate * (user_deposit.amount / lp_token_deposited)

        if new_reward_amount > 0 do
          user_deposit = Map.set(user_deposit, "reward_amount", user_deposit.reward_amount + new_reward_amount)
        end
      end
    end
    [deposited_amount: user_deposit.amount, reward_amount: user_deposit.reward_amount]
  else
    [deposited_amount: 0, reward_amount: 0]
  end
end
