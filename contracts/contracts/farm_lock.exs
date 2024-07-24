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
  now = Time.now() - Math.rem(Time.now(), @ROUND_NOW_TO)

  available_levels = Map.new()
  available_levels = Map.set(available_levels, "0", now)
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
    State.set("lp_tokens_deposited0", Map.get(res.lp_tokens_deposited_by_level, "0", 0))
    State.set("lp_tokens_deposited1", Map.get(res.lp_tokens_deposited_by_level, "1", 0))
    State.set("lp_tokens_deposited2", Map.get(res.lp_tokens_deposited_by_level, "2", 0))
    State.set("lp_tokens_deposited3", Map.get(res.lp_tokens_deposited_by_level, "3", 0))
    State.set("lp_tokens_deposited4", Map.get(res.lp_tokens_deposited_by_level, "4", 0))
    State.set("lp_tokens_deposited5", Map.get(res.lp_tokens_deposited_by_level, "5", 0))
    State.set("lp_tokens_deposited6", Map.get(res.lp_tokens_deposited_by_level, "6", 0))
    State.set("lp_tokens_deposited7", Map.get(res.lp_tokens_deposited_by_level, "7", 0))
  else
    deposits = State.get("deposits", Map.new())
  end

  # ================================================
  # MERGE DEPOSITS
  # ================================================
  user_deposits = Map.get(deposits, user_genesis_address, [])
  same_deposit = nil

  new_user_deposits = []

  for user_deposit in user_deposits do
    if user_deposit.end == end_timestamp do
      same_deposit = user_deposit
    else
      new_user_deposits = List.prepend(new_user_deposits, user_deposit)
    end
  end

  new_deposit = nil

  if same_deposit == nil do
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

    new_deposit = [
      amount: transfer_amount,
      reward_amount: 0,
      level: deposit_level,
      start: start,
      end: end_timestamp,
      id: String.from_number(Time.now())
    ]

    new_user_deposits = List.prepend(new_user_deposits, new_deposit)
  else
    new_deposit = Map.set(same_deposit, "amount", same_deposit.amount + transfer_amount)
    new_user_deposits = List.prepend(new_user_deposits, same_deposit)
  end

  deposits = Map.set(deposits, user_genesis_address, new_user_deposits)
  State.set("deposits", deposits)

  lp_tokens_deposited = State.get("lp_tokens_deposited", 0)
  State.set("lp_tokens_deposited", lp_tokens_deposited + transfer_amount)

  lp_tokens_deposited_level = State.get("lp_tokens_deposited#{new_deposit.level}", 0)

  State.set(
    "lp_tokens_deposited#{new_deposit.level}",
    lp_tokens_deposited_level + transfer_amount
  )
end

condition triggered_by: transaction, on: claim(deposit_id) do
  if transaction.timestamp <= @START_DATE do
    throw(message: "farm is not started yet", code: 2001)
  end

  user_genesis_address = get_user_genesis()

  res = calculate_new_rewards()
  user_deposit = get_user_deposit(res.deposits, user_genesis_address, deposit_id)

  if user_deposit == nil do
    throw(message: "deposit not found", code: 2000)
  end

  if user_deposit.end > Time.now() do
    throw(message: "claiming before end of lock", code: 2002)
  end

  if user_deposit.reward_amount <= 0 do
    throw(message: "no reward to claim", code: 2003)
  end

  true
end

actions triggered_by: transaction, on: claim(deposit_id) do
  user_genesis_address = get_user_genesis()

  res = calculate_new_rewards()
  State.set("last_calculation_timestamp", res.last_calculation_timestamp)
  State.set("lp_tokens_deposited0", Map.get(res.lp_tokens_deposited_by_level, "0", 0))
  State.set("lp_tokens_deposited1", Map.get(res.lp_tokens_deposited_by_level, "1", 0))
  State.set("lp_tokens_deposited2", Map.get(res.lp_tokens_deposited_by_level, "2", 0))
  State.set("lp_tokens_deposited3", Map.get(res.lp_tokens_deposited_by_level, "3", 0))
  State.set("lp_tokens_deposited4", Map.get(res.lp_tokens_deposited_by_level, "4", 0))
  State.set("lp_tokens_deposited5", Map.get(res.lp_tokens_deposited_by_level, "5", 0))
  State.set("lp_tokens_deposited6", Map.get(res.lp_tokens_deposited_by_level, "6", 0))
  State.set("lp_tokens_deposited7", Map.get(res.lp_tokens_deposited_by_level, "7", 0))

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
  user_genesis_address = get_user_genesis()

  user_deposit =
    get_user_deposit(State.get("deposits", Map.new()), user_genesis_address, deposit_id)

  if user_deposit == nil do
    throw(message: "deposit not found", code: 3000)
  end

  if amount > user_deposit.amount do
    throw(message: "amount requested is greater than amount deposited", code: 3003)
  end

  if user_deposit.end > Time.now() do
    throw(message: "withdrawing before end of lock", code: 3004)
  end

  true
end

actions triggered_by: transaction, on: withdraw(amount, deposit_id) do
  user_genesis_address = get_user_genesis()

  deposits = nil
  rewards_reserved = nil

  if Time.now() > @START_DATE do
    res = calculate_new_rewards()
    deposits = res.deposits
    rewards_reserved = res.rewards_reserved
    State.set("last_calculation_timestamp", res.last_calculation_timestamp)
    State.set("lp_tokens_deposited0", Map.get(res.lp_tokens_deposited_by_level, "0", 0))
    State.set("lp_tokens_deposited1", Map.get(res.lp_tokens_deposited_by_level, "1", 0))
    State.set("lp_tokens_deposited2", Map.get(res.lp_tokens_deposited_by_level, "2", 0))
    State.set("lp_tokens_deposited3", Map.get(res.lp_tokens_deposited_by_level, "3", 0))
    State.set("lp_tokens_deposited4", Map.get(res.lp_tokens_deposited_by_level, "4", 0))
    State.set("lp_tokens_deposited5", Map.get(res.lp_tokens_deposited_by_level, "5", 0))
    State.set("lp_tokens_deposited6", Map.get(res.lp_tokens_deposited_by_level, "6", 0))
    State.set("lp_tokens_deposited7", Map.get(res.lp_tokens_deposited_by_level, "7", 0))
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

  lp_tokens_deposited_level = State.get("lp_tokens_deposited#{new_deposit.level}", 0)
  State.set("lp_tokens_deposited#{new_deposit.level}", lp_tokens_deposited_level - amount)

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
  if end_timestamp == "flex" do
    throw(message: "can't relock to flex", code: 4008)
  end

  if transaction.timestamp >= @END_DATE do
    throw(message: "relock impossible once farm is closed", code: 4002)
  end

  if end_timestamp > @END_DATE do
    throw(message: "relock's end cannot be past farm's end", code: 4003)
  end

  if end_timestamp == "max" do
    end_timestamp = @END_DATE
  end

  if end_timestamp - Time.now() > 3 * 365 * @SECONDS_IN_DAY do
    throw(message: "can't lock for more than 3 years", code: 4007)
  end

  user_genesis_address = get_user_genesis()

  user_deposit =
    get_user_deposit(State.get("deposits", Map.new()), user_genesis_address, deposit_id)

  if user_deposit == nil do
    throw(message: "deposit not found", code: 4000)
  end

  now = Time.now() - Math.rem(Time.now(), @ROUND_NOW_TO)

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

  for l in Map.keys(available_levels) do
    until = Map.get(available_levels, l)

    if relock_level == nil && end_timestamp <= until do
      relock_level = l
    end
  end

  if relock_level == nil do
    relock_level = "7"
  end

  if relock_level <= user_deposit.level do
    throw(message: "Relock's level must be greater than current level", code: 4004)
  end

  true
end

actions triggered_by: transaction, on: relock(end_timestamp, deposit_id) do
  if end_timestamp == "max" do
    end_timestamp = @END_DATE
  end

  now = Time.now() - Math.rem(Time.now(), @ROUND_NOW_TO)

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
  State.set("lp_tokens_deposited0", Map.get(res.lp_tokens_deposited_by_level, "0", 0))
  State.set("lp_tokens_deposited1", Map.get(res.lp_tokens_deposited_by_level, "1", 0))
  State.set("lp_tokens_deposited2", Map.get(res.lp_tokens_deposited_by_level, "2", 0))
  State.set("lp_tokens_deposited3", Map.get(res.lp_tokens_deposited_by_level, "3", 0))
  State.set("lp_tokens_deposited4", Map.get(res.lp_tokens_deposited_by_level, "4", 0))
  State.set("lp_tokens_deposited5", Map.get(res.lp_tokens_deposited_by_level, "5", 0))
  State.set("lp_tokens_deposited6", Map.get(res.lp_tokens_deposited_by_level, "6", 0))
  State.set("lp_tokens_deposited7", Map.get(res.lp_tokens_deposited_by_level, "7", 0))

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
  now = Time.now() - Math.rem(Time.now(), @ROUND_NOW_TO)

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
  State.set("lp_tokens_deposited0", Map.get(res.lp_tokens_deposited_by_level, "0", 0))
  State.set("lp_tokens_deposited1", Map.get(res.lp_tokens_deposited_by_level, "1", 0))
  State.set("lp_tokens_deposited2", Map.get(res.lp_tokens_deposited_by_level, "2", 0))
  State.set("lp_tokens_deposited3", Map.get(res.lp_tokens_deposited_by_level, "3", 0))
  State.set("lp_tokens_deposited4", Map.get(res.lp_tokens_deposited_by_level, "4", 0))
  State.set("lp_tokens_deposited5", Map.get(res.lp_tokens_deposited_by_level, "5", 0))
  State.set("lp_tokens_deposited6", Map.get(res.lp_tokens_deposited_by_level, "6", 0))
  State.set("lp_tokens_deposited7", Map.get(res.lp_tokens_deposited_by_level, "7", 0))
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
  rounded_now = Time.now() - Math.rem(Time.now(), @ROUND_NOW_TO)

  lp_tokens_deposited = State.get("lp_tokens_deposited", 0)
  deposits = State.get("deposits", Map.new())
  rewards_reserved = State.get("rewards_reserved", 0)
  last_calculation_timestamp = State.get("last_calculation_timestamp", @START_DATE)

  lp_tokens_deposited_by_level = Map.new()

  lp_tokens_deposited_by_level =
    Map.set(lp_tokens_deposited_by_level, "0", State.get("lp_tokens_deposited0", 0))

  lp_tokens_deposited_by_level =
    Map.set(lp_tokens_deposited_by_level, "1", State.get("lp_tokens_deposited1", 0))

  lp_tokens_deposited_by_level =
    Map.set(lp_tokens_deposited_by_level, "2", State.get("lp_tokens_deposited2", 0))

  lp_tokens_deposited_by_level =
    Map.set(lp_tokens_deposited_by_level, "3", State.get("lp_tokens_deposited3", 0))

  lp_tokens_deposited_by_level =
    Map.set(lp_tokens_deposited_by_level, "4", State.get("lp_tokens_deposited4", 0))

  lp_tokens_deposited_by_level =
    Map.set(lp_tokens_deposited_by_level, "5", State.get("lp_tokens_deposited5", 0))

  lp_tokens_deposited_by_level =
    Map.set(lp_tokens_deposited_by_level, "6", State.get("lp_tokens_deposited6", 0))

  lp_tokens_deposited_by_level =
    Map.set(lp_tokens_deposited_by_level, "7", State.get("lp_tokens_deposited7", 0))

  if last_calculation_timestamp < rounded_now && last_calculation_timestamp < @END_DATE &&
       lp_tokens_deposited > 0 do
    duration_by_level = Map.new()
    duration_by_level = Map.set(duration_by_level, "0", 0)
    duration_by_level = Map.set(duration_by_level, "1", 7 * @SECONDS_IN_DAY)
    duration_by_level = Map.set(duration_by_level, "2", 30 * @SECONDS_IN_DAY)
    duration_by_level = Map.set(duration_by_level, "3", 90 * @SECONDS_IN_DAY)
    duration_by_level = Map.set(duration_by_level, "4", 180 * @SECONDS_IN_DAY)
    duration_by_level = Map.set(duration_by_level, "5", 365 * @SECONDS_IN_DAY)
    duration_by_level = Map.set(duration_by_level, "6", 730 * @SECONDS_IN_DAY)
    duration_by_level = Map.set(duration_by_level, "7", 1095 * @SECONDS_IN_DAY)

    weight_by_level = Map.new()
    weight_by_level = Map.set(weight_by_level, "0", 0.007)
    weight_by_level = Map.set(weight_by_level, "1", 0.013)
    weight_by_level = Map.set(weight_by_level, "2", 0.024)
    weight_by_level = Map.set(weight_by_level, "3", 0.043)
    weight_by_level = Map.set(weight_by_level, "4", 0.077)
    weight_by_level = Map.set(weight_by_level, "5", 0.138)
    weight_by_level = Map.set(weight_by_level, "6", 0.249)
    weight_by_level = Map.set(weight_by_level, "7", 0.449)

    rewards_allocated_at_each_year_end = Map.new()

    rewards_allocated_at_each_year_end =
      Map.set(rewards_allocated_at_each_year_end, "1", @REWARDS_YEAR_1)

    rewards_allocated_at_each_year_end =
      Map.set(rewards_allocated_at_each_year_end, "2", @REWARDS_YEAR_1 + @REWARDS_YEAR_2)

    rewards_allocated_at_each_year_end =
      Map.set(
        rewards_allocated_at_each_year_end,
        "3",
        @REWARDS_YEAR_1 + @REWARDS_YEAR_2 + @REWARDS_YEAR_3
      )

    rewards_allocated_at_each_year_end =
      Map.set(
        rewards_allocated_at_each_year_end,
        "4",
        @REWARDS_YEAR_1 + @REWARDS_YEAR_2 + @REWARDS_YEAR_3 + @REWARDS_YEAR_4
      )

    # remaining reward balance
    remaining_rewards_balance = 0

    if @REWARD_TOKEN == "UCO" do
      remaining_rewards_balance = contract.balance.uco
    else
      key = [token_address: @REWARD_TOKEN, token_id: 0]
      remaining_rewards_balance = Map.get(contract.balance.tokens, key, 0)
    end

    # giveaways are distributed linearly over time
    time_elapsed_since_last_calc =
      Time.now() - State.get("last_calculation_timestamp", @START_DATE)

    time_remaining_until_farm_end =
      @END_DATE - State.get("last_calculation_timestamp", @START_DATE)

    giveaways =
      remaining_rewards_balance + State.get("rewards_distributed", 0) -
        (@REWARDS_YEAR_1 + @REWARDS_YEAR_2 + @REWARDS_YEAR_3 + @REWARDS_YEAR_4)

    giveaways_to_allocate =
      giveaways *
        (time_elapsed_since_last_calc / time_remaining_until_farm_end)

    # loop through all the hours since last calculation
    # period count is always minimum 1 because we ensure previously
    # rounded_now > last_calculation_timestamp
    periods_count =
      (rounded_now - State.get("last_calculation_timestamp", @START_DATE)) / @ROUND_NOW_TO

    period_from = State.get("last_calculation_timestamp", @START_DATE)

    for i in 1..periods_count do
      period_to = period_from + @ROUND_NOW_TO

      # find year / seconds remaining
      year = nil
      seconds_until_end_of_year = nil

      if period_from < @START_DATE + 365 * @SECONDS_IN_DAY do
        year = "1"
        seconds_until_end_of_year = @START_DATE + 365 * @SECONDS_IN_DAY - period_from
      end

      if year == nil && period_from < @START_DATE + 730 * @SECONDS_IN_DAY do
        year = "2"
        seconds_until_end_of_year = @START_DATE + 730 * @SECONDS_IN_DAY - period_from
      end

      if year == nil && period_from < @START_DATE + 1095 * @SECONDS_IN_DAY do
        year = "3"
        seconds_until_end_of_year = @START_DATE + 1095 * @SECONDS_IN_DAY - period_from
      end

      if year == nil do
        year = "4"
        seconds_until_end_of_year = @END_DATE - period_from
      end

      giveaway_for_period =
        giveaways_to_allocate * ((period_to - period_from) / time_elapsed_since_last_calc)

      # calculate reward for this period
      rewards_to_allocate =
        (rewards_allocated_at_each_year_end[year] - State.get("rewards_distributed", 0) -
           rewards_reserved) * ((period_to - period_from) / seconds_until_end_of_year) +
          giveaway_for_period

      # calculate tokens_weighted for each level
      tokens_weighted_by_level = Map.new()

      tokens_weighted_by_level =
        Map.set(
          tokens_weighted_by_level,
          "0",
          Map.get(lp_tokens_deposited_by_level, "0", 0) * weight_by_level["0"]
        )

      tokens_weighted_by_level =
        Map.set(
          tokens_weighted_by_level,
          "1",
          Map.get(lp_tokens_deposited_by_level, "1", 0) * weight_by_level["1"]
        )

      tokens_weighted_by_level =
        Map.set(
          tokens_weighted_by_level,
          "2",
          Map.get(lp_tokens_deposited_by_level, "2", 0) * weight_by_level["2"]
        )

      tokens_weighted_by_level =
        Map.set(
          tokens_weighted_by_level,
          "3",
          Map.get(lp_tokens_deposited_by_level, "3", 0) * weight_by_level["3"]
        )

      tokens_weighted_by_level =
        Map.set(
          tokens_weighted_by_level,
          "4",
          Map.get(lp_tokens_deposited_by_level, "4", 0) * weight_by_level["4"]
        )

      tokens_weighted_by_level =
        Map.set(
          tokens_weighted_by_level,
          "5",
          Map.get(lp_tokens_deposited_by_level, "5", 0) * weight_by_level["5"]
        )

      tokens_weighted_by_level =
        Map.set(
          tokens_weighted_by_level,
          "6",
          Map.get(lp_tokens_deposited_by_level, "6", 0) * weight_by_level["6"]
        )

      tokens_weighted_by_level =
        Map.set(
          tokens_weighted_by_level,
          "7",
          Map.get(lp_tokens_deposited_by_level, "7", 0) * weight_by_level["7"]
        )

      # calculate tokens weighted total
      tokens_weighted_total = 0

      for weighted_amount in Map.values(tokens_weighted_by_level) do
        tokens_weighted_total = tokens_weighted_total + weighted_amount
      end

      # calculate rewards per level
      rewards_to_allocated_by_level = Map.new()

      rewards_to_allocated_by_level =
        Map.set(
          rewards_to_allocated_by_level,
          "0",
          tokens_weighted_by_level["0"] / tokens_weighted_total * rewards_to_allocate
        )

      rewards_to_allocated_by_level =
        Map.set(
          rewards_to_allocated_by_level,
          "1",
          tokens_weighted_by_level["1"] / tokens_weighted_total * rewards_to_allocate
        )

      rewards_to_allocated_by_level =
        Map.set(
          rewards_to_allocated_by_level,
          "2",
          tokens_weighted_by_level["2"] / tokens_weighted_total * rewards_to_allocate
        )

      rewards_to_allocated_by_level =
        Map.set(
          rewards_to_allocated_by_level,
          "3",
          tokens_weighted_by_level["3"] / tokens_weighted_total * rewards_to_allocate
        )

      rewards_to_allocated_by_level =
        Map.set(
          rewards_to_allocated_by_level,
          "4",
          tokens_weighted_by_level["4"] / tokens_weighted_total * rewards_to_allocate
        )

      rewards_to_allocated_by_level =
        Map.set(
          rewards_to_allocated_by_level,
          "5",
          tokens_weighted_by_level["5"] / tokens_weighted_total * rewards_to_allocate
        )

      rewards_to_allocated_by_level =
        Map.set(
          rewards_to_allocated_by_level,
          "6",
          tokens_weighted_by_level["6"] / tokens_weighted_total * rewards_to_allocate
        )

      rewards_to_allocated_by_level =
        Map.set(
          rewards_to_allocated_by_level,
          "7",
          tokens_weighted_by_level["7"] / tokens_weighted_total * rewards_to_allocate
        )

      # update each deposit with the rewards
      updated_deposits = Map.new()

      for user_address in Map.keys(deposits) do
        user_deposits = deposits[user_address]
        updated_user_deposits = []

        for user_deposit in user_deposits do
          # calc rewards
          user_deposit =
            Map.set(
              user_deposit,
              "reward_amount",
              user_deposit.reward_amount +
                user_deposit.amount * weight_by_level[user_deposit.level] /
                  tokens_weighted_by_level[user_deposit.level] *
                  rewards_to_allocated_by_level[user_deposit.level]
            )

          # on level change, update cursors and deposit
          if user_deposit.level != "0" do
            previous_level = String.from_number(String.to_number(user_deposit.level) - 1)

            if user_deposit.end - duration_by_level[previous_level] <= period_to do
              Map.set(
                lp_tokens_deposited_by_level,
                user_deposit.level,
                Map.get(lp_tokens_deposited_by_level, user_deposit.level) - user_deposit.amount
              )

              Map.set(
                lp_tokens_deposited_by_level,
                previous_level,
                Map.get(lp_tokens_deposited_by_level, previous_level) + user_deposit.amount
              )

              user_deposit = Map.set(user_deposit, "level", previous_level)
            end
          end

          updated_user_deposits = List.prepend(updated_user_deposits, user_deposit)
        end

        updated_deposits = Map.set(updated_deposits, user_address, updated_user_deposits)
      end

      deposits = updated_deposits
      rewards_reserved = rewards_reserved + rewards_to_allocate
      last_calculation_timestamp = period_to
    end
  end

  [
    deposits: deposits,
    rewards_reserved: rewards_reserved,
    last_calculation_timestamp: last_calculation_timestamp,
    lp_tokens_deposited_by_level: lp_tokens_deposited_by_level
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
