@version 1

condition triggered_by: transaction, on: deposit(end_timestamp) do
  now = Time.now()

  if end_timestamp == "max" do
    end_timestamp = @END_DATE
  end

  if end_timestamp == "flex" do
    end_timestamp = 0
  end

  if end_timestamp - now > 3 * 365 * @SECONDS_IN_DAY do
    throw(message: "can't lock for more than 3 years", code: 1007)
  end

  if transaction.timestamp >= @END_DATE do
    throw(message: "deposit impossible once farm is closed", code: 1001)
  end

  if end_timestamp > @END_DATE do
    throw(message: "deposit's end cannot be greater than farm's end", code: 1005)
  end

  if end_timestamp != 0 && end_timestamp < now do
    throw(message: "deposit's end cannot be in the past", code: 1006)
  end

  if get_user_transfer_amount() < 0.00000143 do
    throw(message: "deposit's minimum amount is 0.00000143", code: 1002)
  end

  true
end

actions triggered_by: transaction, on: deposit(end_timestamp) do
  now = Time.now()
  now = now - Math.rem(now, @ROUND_NOW_TO)

  available_levels = Map.new()
  available_levels = Map.set(available_levels, "0", now + 0)
  available_levels = Map.set(available_levels, "1", now + 7 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "2", now + 30 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "3", now + 90 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "4", now + 180 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "5", now + 365 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "6", now + 730 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "7", now + 1095 * @SECONDS_IN_DAY)

  start = now

  if end_timestamp == "max" do
    end_timestamp = @END_DATE
  end

  if end_timestamp == "flex" do
    end_timestamp = 0
    start = nil
  end

  transfer_amount = get_user_transfer_amount()

  user_genesis_address = get_user_genesis()

  deposits = nil

  if now > @START_DATE do
    res = calculate_new_rewards()
    deposits = res.deposits
    State.set("rewards_reserved", res.rewards_reserved)
    State.set("last_calculation_timestamp", res.last_calculation_timestamp)
  else
    deposits = State.get("deposits", Map.new())
  end

  id = String.from_number(Time.now())

  # detect current level
  deposit_level = nil

  for l in Map.keys(available_levels) do
    until = Map.get(available_levels, l)

    if deposit_level == nil && end_timestamp <= until do
      deposit_level = l
    end
  end

  if deposit_level == nil do
    deposit_level = "7"
  end

  current_deposit = [
    amount: transfer_amount,
    reward_amount: 0,
    level: deposit_level,
    start: now,
    end: end_timestamp,
    id: id
  ]

  user_deposits = Map.get(deposits, user_genesis_address, [])
  user_deposits = List.append(user_deposits, current_deposit)

  # ================================================
  # MERGE FLEXIBLE DEPOSITS
  # ================================================
  user_deposits_flexible = []
  user_deposits_non_flexible = []

  for user_deposit in user_deposits do
    if user_deposit.end <= now do
      user_deposits_flexible = List.prepend(user_deposits_flexible, user_deposit)
    else
      user_deposits_non_flexible = List.prepend(user_deposits_non_flexible, user_deposit)
    end
  end

  if List.size(user_deposits_flexible) > 1 do
    amount = 0
    reward_amount = 0

    for f in user_deposits_flexible do
      amount = amount + f.amount
      reward_amount = reward_amount + f.reward_amount
    end

    user_deposits =
      List.prepend(user_deposits_non_flexible,
        amount: amount,
        reward_amount: reward_amount,
        start: nil,
        end: 0,
        level: "0",
        id: "merge"
      )
  end

  deposits = Map.set(deposits, user_genesis_address, user_deposits)
  State.set("deposits", deposits)

  lp_tokens_deposited = State.get("lp_tokens_deposited", 0)
  State.set("lp_tokens_deposited", lp_tokens_deposited + transfer_amount)
end

condition triggered_by: transaction, on: claim(deposit_id) do
  if transaction.timestamp <= @START_DATE do
    throw(message: "farm is not started yet", code: 2001)
  end

  now = Time.now()
  user_genesis_address = get_user_genesis()

  res = calculate_new_rewards()
  user_deposit = get_user_deposit(res.deposits, user_genesis_address, deposit_id)

  if user_deposit == nil do
    throw(message: "deposit not found", code: 2000)
  end

  if user_deposit.end > now do
    throw(message: "claiming before end of lock", code: 2002)
  end

  user_deposit.reward_amount > 0
end

actions triggered_by: transaction, on: claim(deposit_id) do
  user_genesis_address = get_user_genesis()

  res = calculate_new_rewards()
  State.set("last_calculation_timestamp", res.last_calculation_timestamp)

  user_deposit = get_user_deposit(res.deposits, user_genesis_address, deposit_id)

  if @REWARD_TOKEN == "UCO" do
    Contract.add_uco_transfer(to: transaction.address, amount: user_deposit.reward_amount)
  else
    Contract.add_token_transfer(
      to: transaction.address,
      amount: user_deposit.reward_amount,
      token_address: @REWARD_TOKEN
    )
  end

  rewards_distributed = State.get("rewards_distributed", 0)
  State.set("rewards_distributed", rewards_distributed + user_deposit.reward_amount)
  State.set("rewards_reserved", res.rewards_reserved - user_deposit.reward_amount)

  user_deposit = Map.set(user_deposit, "reward_amount", 0)
  State.set("deposits", set_user_deposit(res.deposits, user_genesis_address, user_deposit))
end

condition triggered_by: transaction, on: withdraw(amount, deposit_id) do
  now = Time.now()

  user_genesis_address = get_user_genesis()

  user_deposit =
    get_user_deposit(State.get("deposits", Map.new()), user_genesis_address, deposit_id)

  if user_deposit == nil do
    throw(message: "deposit not found", code: 3000)
  end

  if amount > user_deposit.amount do
    throw(message: "amount requested is greater than amount deposited", code: 3003)
  end

  if user_deposit.end > now do
    throw(message: "withdrawing before end of lock", code: 3004)
  end

  true
end

actions triggered_by: transaction, on: withdraw(amount, deposit_id) do
  now = Time.now()

  user_genesis_address = get_user_genesis()

  deposits = nil
  rewards_reserved = nil

  if now > @START_DATE do
    res = calculate_new_rewards()
    deposits = res.deposits
    rewards_reserved = res.rewards_reserved
    State.set("last_calculation_timestamp", res.last_calculation_timestamp)
  else
    deposits = State.get("deposits", Map.new())
    rewards_reserved = State.get("rewards_reserved", 0)
  end

  user_deposit = get_user_deposit(deposits, user_genesis_address, deposit_id)

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

    rewards_distributed = State.get("rewards_distributed", 0)
    State.set("rewards_distributed", rewards_distributed + user_deposit.reward_amount)

    rewards_reserved = rewards_reserved - user_deposit.reward_amount
  end

  State.set("rewards_reserved", rewards_reserved)

  Contract.add_token_transfer(
    to: transaction.address,
    amount: amount,
    token_address: @LP_TOKEN_ADDRESS
  )

  lp_tokens_deposited = State.get("lp_tokens_deposited", 0)
  State.set("lp_tokens_deposited", lp_tokens_deposited - amount)

  if amount == user_deposit.amount do
    deposits = remove_user_deposit(deposits, user_genesis_address, deposit_id)
  else
    user_deposit = Map.set(user_deposit, "reward_amount", 0)
    user_deposit = Map.set(user_deposit, "amount", user_deposit.amount - amount)
    deposits = set_user_deposit(deposits, user_genesis_address, user_deposit)
  end

  State.set("deposits", deposits)
end

condition triggered_by: transaction, on: relock(end_timestamp, deposit_id) do
  now = Time.now()

  if end_timestamp == "max" do
    end_timestamp = @END_DATE
  end

  if end_timestamp - now > 3 * 365 * @SECONDS_IN_DAY do
    throw(message: "can't lock for more than 3 years", code: 4007)
  end

  user_genesis_address = get_user_genesis()

  user_deposit =
    get_user_deposit(State.get("deposits", Map.new()), user_genesis_address, deposit_id)

  if user_deposit == nil do
    throw(message: "deposit not found", code: 4000)
  end

  if transaction.timestamp >= @END_DATE do
    throw(message: "relock impossible once farm is closed", code: 4002)
  end

  if end_timestamp > @END_DATE do
    throw(message: "relock's end cannot be past farm's end", code: 4003)
  end

  available_levels = Map.new()
  available_levels = Map.set(available_levels, "0", now + 0)
  available_levels = Map.set(available_levels, "1", now + 7 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "2", now + 30 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "3", now + 90 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "4", now + 180 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "5", now + 365 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "6", now + 730 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "7", now + 1095 * @SECONDS_IN_DAY)

  relock_level = nil
  deposit_level = nil

  for l in Map.keys(available_levels) do
    until = Map.get(available_levels, l)

    if deposit_level == nil && user_deposit.end <= until do
      deposit_level = l
    end

    if relock_level == nil && end_timestamp <= until do
      relock_level = l
    end
  end

  if relock_level == nil do
    relock_level = "7"
  end

  if deposit_level == nil do
    deposit_level = "7"
  end

  if relock_level <= deposit_level do
    throw(message: "Relock's level must be greater than current level", code: 4004)
  end

  true
end

actions triggered_by: transaction, on: relock(end_timestamp, deposit_id) do
  if end_timestamp == "max" do
    end_timestamp = @END_DATE
  end

  now = Time.now()
  now = now - Math.rem(now, @ROUND_NOW_TO)

  available_levels = Map.new()
  available_levels = Map.set(available_levels, "0", now + 0)
  available_levels = Map.set(available_levels, "1", now + 7 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "2", now + 30 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "3", now + 90 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "4", now + 180 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "5", now + 365 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "6", now + 730 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "7", now + 1095 * @SECONDS_IN_DAY)

  user_genesis_address = get_user_genesis()

  res = calculate_new_rewards()
  State.set("last_calculation_timestamp", res.last_calculation_timestamp)

  user_deposit = get_user_deposit(res.deposits, user_genesis_address, deposit_id)

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
  end

  # detect current_level
  deposit_level = nil

  for l in Map.keys(available_levels) do
    until = Map.get(available_levels, l)

    if deposit_level == nil && end_timestamp <= until do
      deposit_level = l
    end
  end

  if deposit_level == nil do
    deposit_level = "7"
  end

  rewards_distributed = State.get("rewards_distributed", 0)
  State.set("rewards_distributed", rewards_distributed + user_deposit.reward_amount)
  State.set("rewards_reserved", res.rewards_reserved - user_deposit.reward_amount)

  user_deposit = Map.set(user_deposit, "reward_amount", 0)
  user_deposit = Map.set(user_deposit, "start", now)
  user_deposit = Map.set(user_deposit, "end", end_timestamp)
  user_deposit = Map.set(user_deposit, "level", deposit_level)

  State.set("deposits", set_user_deposit(res.deposits, user_genesis_address, user_deposit))
end

condition triggered_by: transaction, on: calculate_rewards() do
  now = Time.now()
  now = now - Math.rem(now, @ROUND_NOW_TO)

  if now < @START_DATE do
    throw(message: "cannot calculate rewards before the farm start", code: 5000)
  end

  if now > @END_DATE do
    throw(message: "cannot calculate rewards after the farm start", code: 5001)
  end

  if now == State.get("last_calculation_timestamp", @START_DATE) do
    throw(message: "rewards already calculated for period", code: 5002)
  end

  true
end

actions triggered_by: transaction, on: calculate_rewards() do
  res = calculate_new_rewards()
  State.set("last_calculation_timestamp", res.last_calculation_timestamp)
  State.set("deposits", res.deposits)
  State.set("rewards_reserved", res.rewards_reserved)
end

condition(
  triggered_by: transaction,
  on: update_code(),
  as: [
    previous_public_key:
      (
        # Pool code can only be updated from the router contract of the dex

        # Transaction is not yet validated so we need to use previous address
        # to get the genesis address
        previous_address = Chain.get_previous_address()
        Chain.get_genesis_address(previous_address) == @ROUTER_ADDRESS
      )
  ]
)

actions triggered_by: transaction, on: update_code() do
  params = [
    @LP_TOKEN_ADDRESS,
    @START_DATE,
    @END_DATE,
    @REWARD_TOKEN,
    @FARM_ADDRESS
  ]

  new_code = Contract.call_function(@FACTORY_ADDRESS, "get_farm_lock_code", params)

  if Code.is_valid?(new_code) && !Code.is_same?(new_code, contract.code) do
    Contract.set_type("contract")
    Contract.set_code(new_code)
  end
end

fun get_user_transfer_amount() do
  transfers = Map.get(transaction.token_transfers, @FARM_ADDRESS, [])
  transfer = List.at(transfers, 0)

  if transfer == nil do
    throw(message: "no transfer found to the farm", code: 1003)
  end

  if transfer.token_address != @LP_TOKEN_ADDRESS do
    throw(message: "invalid token transfered to the farm", code: 1004)
  end

  transfer.amount
end

fun calculate_new_rewards() do
  # being refactored

  [
    deposits: State.get("deposits", Map.new()),
    rewards_reserved: State.get("rewards_reserved", 0),
    last_calculation_timestamp: State.get("last_calculation_timestamp", @START_DATE)
  ]
end

export fun(get_farm_infos()) do
  now = Time.now()
  now = now - Math.rem(now, @ROUND_NOW_TO)

  reward_token_balance = 0

  years = [
    [
      year: 1,
      start: @START_DATE,
      end: @START_DATE + 365 * @SECONDS_IN_DAY - 1,
      rewards: @REWARDS_YEAR_1
    ],
    [
      year: 2,
      start: @START_DATE + 365 * @SECONDS_IN_DAY,
      end: @START_DATE + 730 * @SECONDS_IN_DAY - 1,
      rewards: @REWARDS_YEAR_2
    ],
    [
      year: 3,
      start: @START_DATE + 730 * @SECONDS_IN_DAY,
      end: @START_DATE + 1095 * @SECONDS_IN_DAY - 1,
      rewards: @REWARDS_YEAR_3
    ],
    [
      year: 4,
      start: @START_DATE + 1095 * @SECONDS_IN_DAY,
      end: @END_DATE,
      rewards: @REWARDS_YEAR_4
    ]
  ]

  if @REWARD_TOKEN == "UCO" do
    reward_token_balance = contract.balance.uco
  else
    key = [token_address: @REWARD_TOKEN, token_id: 0]
    reward_token_balance = Map.get(contract.balance.tokens, key, 0)
  end

  remaining_rewards = nil

  if reward_token_balance != nil do
    remaining_rewards = reward_token_balance - State.get("rewards_reserved", 0)
  end

  deposits = State.get("deposits", Map.new())
  lp_tokens_deposited = State.get("lp_tokens_deposited", 0)

  weight_per_level = Map.new()
  weight_per_level = Map.set(weight_per_level, "0", 0.007)
  weight_per_level = Map.set(weight_per_level, "1", 0.013)
  weight_per_level = Map.set(weight_per_level, "2", 0.024)
  weight_per_level = Map.set(weight_per_level, "3", 0.043)
  weight_per_level = Map.set(weight_per_level, "4", 0.077)
  weight_per_level = Map.set(weight_per_level, "5", 0.138)
  weight_per_level = Map.set(weight_per_level, "6", 0.249)
  weight_per_level = Map.set(weight_per_level, "7", 0.449)

  available_levels = Map.new()
  available_levels = Map.set(available_levels, "0", now + 0)
  available_levels = Map.set(available_levels, "1", now + 7 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "2", now + 30 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "3", now + 90 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "4", now + 180 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "5", now + 365 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "6", now + 730 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "7", now + 1095 * @SECONDS_IN_DAY)

  filtered_levels = Map.new()

  end_reached = false

  for level in Map.keys(available_levels) do
    start_level = Map.get(available_levels, level)

    if start_level < @END_DATE do
      filtered_levels = Map.set(filtered_levels, level, start_level)
    else
      if !end_reached && Map.size(filtered_levels) > 0 do
        filtered_levels = Map.set(filtered_levels, level, @END_DATE)
        end_reached = true
      end
    end
  end

  weighted_lp_tokens_deposited = 0
  lp_tokens_deposited_per_level = Map.new()
  deposits_count_per_level = Map.new()

  for user_genesis in Map.keys(deposits) do
    user_deposits = Map.get(deposits, user_genesis)

    for user_deposit in user_deposits do
      level = nil

      for l in Map.keys(available_levels) do
        if level == nil do
          until = Map.get(available_levels, l)

          if user_deposit.end <= until do
            level = l
          end
        end
      end

      if level == nil do
        level = "7"
      end

      weighted_lp_tokens_deposited =
        weighted_lp_tokens_deposited + user_deposit.amount * Map.get(weight_per_level, level)

      lp_tokens_deposited_per_level =
        Map.set(
          lp_tokens_deposited_per_level,
          level,
          Map.get(lp_tokens_deposited_per_level, level, 0) + user_deposit.amount
        )

      deposits_count_per_level =
        Map.set(
          deposits_count_per_level,
          level,
          Map.get(deposits_count_per_level, level, 0) + 1
        )
    end
  end

  stats = Map.new()

  for level in Map.keys(available_levels) do
    rewards_allocated = []

    for y in years do
      rewards = Map.get(weight_per_level, level) * y.rewards

      if weighted_lp_tokens_deposited > 0 do
        rewards =
          Map.get(lp_tokens_deposited_per_level, level, 0) * Map.get(weight_per_level, level) /
            weighted_lp_tokens_deposited * y.rewards
      end

      rewards_allocated =
        List.append(rewards_allocated, start: y.start, end: y.end, rewards: rewards)
    end

    stats =
      Map.set(stats, level,
        weight: Map.get(weight_per_level, level),
        lp_tokens_deposited: Map.get(lp_tokens_deposited_per_level, level, 0),
        deposits_count: Map.get(deposits_count_per_level, level, 0),
        rewards_allocated: rewards_allocated
      )
  end

  [
    lp_token_address: @LP_TOKEN_ADDRESS,
    reward_token: @REWARD_TOKEN,
    start_date: @START_DATE,
    end_date: @END_DATE,
    lp_tokens_deposited: lp_tokens_deposited,
    remaining_rewards: remaining_rewards,
    rewards_distributed: State.get("rewards_distributed", 0),
    available_levels: filtered_levels,
    stats: stats
  ]
end

export fun(get_user_infos(user_genesis_address)) do
  now = Time.now()

  deposits = State.get("deposits", Map.new())

  reply = []

  user_genesis_address = String.to_hex(user_genesis_address)

  available_levels = Map.new()
  available_levels = Map.set(available_levels, "0", now + 0)
  available_levels = Map.set(available_levels, "1", now + 7 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "2", now + 30 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "3", now + 90 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "4", now + 180 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "5", now + 365 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "6", now + 730 * @SECONDS_IN_DAY)
  available_levels = Map.set(available_levels, "7", now + 1095 * @SECONDS_IN_DAY)

  user_deposits = Map.get(deposits, user_genesis_address, [])

  for user_deposit in user_deposits do
    level = nil

    for l in Map.keys(available_levels) do
      if level == nil do
        until = Map.get(available_levels, l)

        if user_deposit.end <= until do
          level = l
        end
      end
    end

    if level == nil do
      level = "7"
    end

    info = [
      id: user_deposit.id,
      amount: user_deposit.amount,
      reward_amount: user_deposit.reward_amount,
      level: level
    ]

    if user_deposit.end > now do
      info = Map.set(info, "end", user_deposit.end)
      info = Map.set(info, "start", user_deposit.start)
    end

    reply = List.append(reply, info)
  end

  reply
end

fun get_user_genesis() do
  Chain.get_genesis_address(Chain.get_previous_address(transaction))
end

fun get_user_deposit(deposits, user_genesis_address, deposit_id) do
  reply = nil

  for user_deposit in Map.get(deposits, user_genesis_address, []) do
    if user_deposit.id == deposit_id do
      reply = user_deposit
    end
  end

  reply
end

fun set_user_deposit(deposits, user_genesis_address, deposit) do
  updated_user_deposits = []

  for user_deposit in Map.get(deposits, user_genesis_address, []) do
    if user_deposit.id == deposit.id do
      updated_user_deposits = List.prepend(updated_user_deposits, deposit)
    else
      updated_user_deposits = List.prepend(updated_user_deposits, user_deposit)
    end
  end

  Map.set(deposits, user_genesis_address, updated_user_deposits)
end

fun remove_user_deposit(deposits, user_genesis_address, deposit_id) do
  updated_user_deposits = []

  for user_deposit in Map.get(deposits, user_genesis_address, []) do
    if user_deposit.id != deposit_id do
      updated_user_deposits = List.prepend(updated_user_deposits, user_deposit)
    end
  end

  if List.size(updated_user_deposits) == 0 do
    Map.delete(deposits, user_genesis_address)
  else
    Map.set(deposits, user_genesis_address, updated_user_deposits)
  end
end
