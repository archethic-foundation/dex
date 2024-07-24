@version 1

condition triggered_by: transaction, on: deposit(end_timestamp) do
  now = Time.now()
  now = now - Math.rem(now, @ROUND_NOW_TO)
  day = @SECONDS_IN_DAY

  if end_timestamp == "max" do
    end_timestamp = @END_DATE
  end

  if end_timestamp == "flex" do
    end_timestamp = 0
  end

  if end_timestamp - now > 3 * 365 * day do
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

  current_deposit = [
    amount: transfer_amount,
    reward_amount: 0,
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
  now = now - Math.rem(now, @ROUND_NOW_TO)

  day = @SECONDS_IN_DAY

  if end_timestamp == "max" do
    end_timestamp = @END_DATE
  end

  if end_timestamp - now > 3 * 365 * day do
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
  available_levels = Map.set(available_levels, "1", now + 7 * day)
  available_levels = Map.set(available_levels, "2", now + 30 * day)
  available_levels = Map.set(available_levels, "3", now + 90 * day)
  available_levels = Map.set(available_levels, "4", now + 180 * day)
  available_levels = Map.set(available_levels, "5", now + 365 * day)
  available_levels = Map.set(available_levels, "6", now + 730 * day)
  available_levels = Map.set(available_levels, "7", now + 1095 * day)

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

  rewards_distributed = State.get("rewards_distributed", 0)
  State.set("rewards_distributed", rewards_distributed + user_deposit.reward_amount)
  State.set("rewards_reserved", res.rewards_reserved - user_deposit.reward_amount)

  user_deposit = Map.set(user_deposit, "reward_amount", 0)
  user_deposit = Map.set(user_deposit, "start", now)
  user_deposit = Map.set(user_deposit, "end", end_timestamp)

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
  now = Time.now()
  now = now - Math.rem(now, @ROUND_NOW_TO)
  day = @SECONDS_IN_DAY
  year = 365 * day

  deposits = State.get("deposits", Map.new())
  lp_tokens_deposited = State.get("lp_tokens_deposited", 0)
  rewards_reserved = State.get("rewards_reserved", 0)
  rewards_distributed = State.get("rewards_distributed", 0)
  last_calculation_timestamp = State.get("last_calculation_timestamp", @START_DATE)

  if last_calculation_timestamp < now && last_calculation_timestamp < @END_DATE &&
       lp_tokens_deposited > 0 do
    # ================================================
    # INITIALIZATION
    # ================================================
    duration_per_level = Map.new()
    duration_per_level = Map.set(duration_per_level, "0", 0)
    duration_per_level = Map.set(duration_per_level, "1", 7 * day)
    duration_per_level = Map.set(duration_per_level, "2", 30 * day)
    duration_per_level = Map.set(duration_per_level, "3", 90 * day)
    duration_per_level = Map.set(duration_per_level, "4", 180 * day)
    duration_per_level = Map.set(duration_per_level, "5", 365 * day)
    duration_per_level = Map.set(duration_per_level, "6", 730 * day)
    duration_per_level = Map.set(duration_per_level, "7", 1095 * day)

    weight_per_level = Map.new()
    weight_per_level = Map.set(weight_per_level, "0", 0.007)
    weight_per_level = Map.set(weight_per_level, "1", 0.013)
    weight_per_level = Map.set(weight_per_level, "2", 0.024)
    weight_per_level = Map.set(weight_per_level, "3", 0.043)
    weight_per_level = Map.set(weight_per_level, "4", 0.077)
    weight_per_level = Map.set(weight_per_level, "5", 0.138)
    weight_per_level = Map.set(weight_per_level, "6", 0.249)
    weight_per_level = Map.set(weight_per_level, "7", 0.449)

    # TODO: IF NOW >= END_DATE ALLOCATE ALL REMAINING
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

    end_of_years = [
      [year: 1, timestamp: @START_DATE + year],
      [year: 2, timestamp: @START_DATE + 2 * year],
      [year: 3, timestamp: @START_DATE + 3 * year],
      [year: 4, timestamp: @START_DATE + 4 * year]
    ]

    reward_per_deposit = Map.new()

    # ================================================
    # CALCULATE HOW MANY YEARS PASSED SINCE LAST CALC
    # ================================================
    year_periods = []

    current_start = last_calculation_timestamp
    current_year = 1
    current_year_end = @START_DATE + year

    start = monotonic()

    for end_of_year in end_of_years do
      if now > end_of_year.timestamp do
        current_year = current_year + 1
        current_year_end = end_of_year.timestamp + year
      end

      if end_of_year.timestamp > current_start && end_of_year.timestamp < now do
        year_periods =
          List.append(year_periods,
            start: current_start,
            end: end_of_year.timestamp,
            year: end_of_year.year,
            remaining_until_end_of_year: end_of_year.timestamp - current_start
          )

        current_start = end_of_year.timestamp
      end
    end

    if current_start != now && now < @END_DATE do
      year_periods =
        List.append(year_periods,
          start: current_start,
          end: now,
          year: current_year,
          remaining_until_end_of_year: current_year_end - current_start
        )
    end

    log("#{monotonic() - start} ms year_periods")

    # ================================================
    # CALCULATED AVAILABLE BALANCE
    # ================================================
    rewards_balance = 0

    if @REWARD_TOKEN == "UCO" do
      rewards_balance = contract.balance.uco
    else
      key = [token_address: @REWARD_TOKEN, token_id: 0]
      rewards_balance = Map.get(contract.balance.tokens, key, 0)
    end

    # ================================================
    # CALCULATE GIVEAWAYS TO ALLOCATE
    #
    # Extra balance on the chain is considered give away
    # we distributed them linearly
    # ================================================
    start = monotonic()
    time_elapsed_since_last_calc = now - last_calculation_timestamp
    time_remaining_until_farm_end = @END_DATE - last_calculation_timestamp

    giveaways =
      rewards_balance + rewards_distributed -
        (@REWARDS_YEAR_1 + @REWARDS_YEAR_2 + @REWARDS_YEAR_3 + @REWARDS_YEAR_4)

    giveaways_to_allocate =
      giveaways * (time_elapsed_since_last_calc / time_remaining_until_farm_end)

    log("#{monotonic() - start} ms giveaways_to_allocate")


      # ================================================
      # CALCULATE THE PERIODS FOR EVERY DEPOSIT
      # ================================================

      start = monotonic()
      
      deposit_periods = []
      start_periods = []

      for address in Map.keys(deposits) do
        user_deposits = Map.get(deposits, address)
        user_deposits_updated = []

        for user_deposit in user_deposits do
          start_per_level = Map.new()

          for l in Map.keys(duration_per_level) do
            duration = Map.get(duration_per_level, l)
            end_current_level = user_deposit.end - duration

            start_per_level =
              Map.set(
                start_per_level,
                l,
                end_current_level
              )
          end

          for year_period in year_periods do
            deposit_periods_for_year = []
            current_level = nil
            current_end = year_period.end

            # level is ASC but start_of_level is DESC
            # assumption that keys are ordered in a map
            for l in Map.keys(start_per_level) do
              start_of_level = Map.get(start_per_level, l)

              if year_period.start < start_of_level do
                current_level = String.from_number(String.to_number(l) + 1)

                if current_level == "8" do
                  current_level = "7"
                end
              end

              if start_of_level >= year_period.start && start_of_level < year_period.end do
                deposit_periods_for_year =
                  List.prepend(deposit_periods_for_year,
                    start: start_of_level,
                    end: current_end,
                    elapsed: current_end - start_of_level,
                    remaining_until_end_of_year: year_period.remaining_until_end_of_year,
                    level: l,
                    year: year_period.year,
                    amount: user_deposit.amount,
                    user_address: address,
                    id: user_deposit.id
                  )
                  
                start_periods = List.append(start_periods,
                  start: start_of_level,
                  year: year_period.year,
                  remaining_until_end_of_year: year_period.remaining_until_end_of_year
                )

                current_end = start_of_level
              end
            end

            if current_end != year_period.start do
              if current_level == nil do
                current_level = "0"
              end

              deposit_periods_for_year =
                List.prepend(deposit_periods_for_year,
                  start: year_period.start,
                  end: current_end,
                  elapsed: current_end - year_period.start,
                  remaining_until_end_of_year: year_period.remaining_until_end_of_year,
                  level: current_level,
                  year: year_period.year,
                  amount: user_deposit.amount,
                  user_address: address,
                  id: user_deposit.id
                )
                
                
              start_periods = List.append(start_periods,
                start: year_period.start,
                year: year_period.year,
                remaining_until_end_of_year: year_period.remaining_until_end_of_year
              )
            end

            deposit_periods = deposit_periods ++ deposit_periods_for_year
          end
        end
      end

      deposit_periods = List.sort_by(deposit_periods, "start")
      log("#{monotonic() - start} ms deposit_periods")

      # ================================================
      # DETERMINE ALL THE PERIODS STARTS
      # ================================================

      start = monotonic()

      start_periods = List.sort_by(List.uniq(start_periods), "start")

      log("#{monotonic() - start} ms start_periods")

      # ================================================
      # CREATE PERIODS
      # ================================================

      start = monotonic()
      start_end_years = []
      previous = nil

      for start_period in start_periods do
        if previous != nil do
          start_end_years =
            List.append(start_end_years,
              start: previous.start,
              end: start_period.start,
              year: previous.year,
              remaining_until_end_of_year: previous.remaining_until_end_of_year
            )
        end

        previous = start_period
      end

      max_end = now

      if now > @END_DATE do
        max_end = @END_DATE
      end

      start_end_years =
        List.append(start_end_years,
          start: previous.start,
          end: max_end,
          year: previous.year,
          remaining_until_end_of_year: previous.remaining_until_end_of_year
        )

      log("#{monotonic() - start} ms start_end_years")
      # ================================================
      # FOR EACH PERIOD DETERMINE THE DEPOSITS STATES
      # ================================================
      start = monotonic()

      deposits_per_period = Map.new()

      for start_end_year in start_end_years do
        deposits_in_period = []

        for deposit_period in deposit_periods do
          if deposit_period.start < start_end_year.end &&
               deposit_period.end > start_end_year.start do
            deposits_in_period =
              List.append(deposits_in_period,
                amount: deposit_period.amount,
                level: deposit_period.level,
                id: deposit_period.id,
                user_address: deposit_period.user_address
              )
          end
        end

        deposits_per_period = Map.set(deposits_per_period, start_end_year, deposits_in_period)
      end

      log("#{monotonic() - start} ms deposits_per_period")

      # ================================================
      # FOR EACH PERIOD DETERMINE THE REWARD TO ALLOCATE FOR EACH LEVEL
      # ================================================
      start = monotonic()
      current_year_reward_accumulated = 0
      previous_year_reward_accumulated = 0
      previous_year = nil

      periods = Map.keys(deposits_per_period)
      periods = List.sort_by(periods, "start")

      for period in periods do
        if previous_year == nil || previous_year != period.year do
          previous_year = period.year

          previous_year_reward_accumulated =
            previous_year_reward_accumulated + current_year_reward_accumulated

          current_year_reward_accumulated = 0
        end

        deposits_in_period = Map.get(deposits_per_period, period)

        rewards_allocated_at_year_end =
          Map.get(rewards_allocated_at_each_year_end, String.from_number(period.year), 0)

        giveaway_for_period =
          giveaways_to_allocate * ((period.end - period.start) / time_elapsed_since_last_calc)

        # rounding imprecision here due to max 8 decimals in the ratio
        reward_to_allocate =
          (rewards_allocated_at_year_end - rewards_distributed - rewards_reserved -
             previous_year_reward_accumulated) *
            ((period.end - period.start) / period.remaining_until_end_of_year) +
            giveaway_for_period

        total_weighted_lp_deposited = 0
        weighted_lp_deposited_per_level = Map.new()

        for deposit in deposits_in_period do
          current_weighted_amount = Map.get(weighted_lp_deposited_per_level, deposit.level, 0)
          weight = Map.get(weight_per_level, deposit.level)
          deposit_weighted_amount = deposit.amount * weight

          weighted_lp_deposited_per_level =
            Map.set(
              weighted_lp_deposited_per_level,
              deposit.level,
              current_weighted_amount + deposit_weighted_amount
            )

          total_weighted_lp_deposited = total_weighted_lp_deposited + deposit_weighted_amount
        end

        reward_to_allocate_per_level = Map.new()

        for level in Map.keys(weight_per_level) do
          weighted_lp_deposited_for_level = Map.get(weighted_lp_deposited_per_level, level, 0)

          if total_weighted_lp_deposited > 0 do
            reward_to_allocate_per_level =
              Map.set(
                reward_to_allocate_per_level,
                level,
                weighted_lp_deposited_for_level / total_weighted_lp_deposited * reward_to_allocate
              )
          else
            reward_to_allocate_per_level =
              Map.set(
                reward_to_allocate_per_level,
                level,
                0
              )
          end
        end

        for deposit in deposits_in_period do
          deposit_key = [user_address: deposit.user_address, id: deposit.id]
          weight = Map.get(weight_per_level, deposit.level)

          weighted_lp_deposited_for_level =
            Map.get(weighted_lp_deposited_per_level, deposit.level)

          reward_to_allocate_for_level = Map.get(reward_to_allocate_per_level, deposit.level)

          reward = 0

          if weighted_lp_deposited_for_level > 0 do
            reward =
              deposit.amount * weight / weighted_lp_deposited_for_level *
                reward_to_allocate_for_level
          end

          current_year_reward_accumulated = current_year_reward_accumulated + reward
          previous_reward = Map.get(reward_per_deposit, deposit_key, 0)
          reward_per_deposit = Map.set(reward_per_deposit, deposit_key, previous_reward + reward)
        end
      end

      log("#{monotonic() - start} ms reward_per_deposit")
    

    start = monotonic()

    for address in Map.keys(deposits) do
      user_deposits = Map.get(deposits, address)

      user_deposits_updated = []

      for user_deposit in user_deposits do
        deposit_key = [id: user_deposit.id, user_address: address]
        new_reward_amount = Map.get(reward_per_deposit, deposit_key)

        user_deposit =
          Map.set(user_deposit, "reward_amount", user_deposit.reward_amount + new_reward_amount)

        rewards_reserved = rewards_reserved + new_reward_amount
        user_deposits_updated = List.append(user_deposits_updated, user_deposit)
      end

      deposits = Map.set(deposits, address, user_deposits_updated)
    end

    log("#{monotonic() - start} ms update deposits")
  end

  [
    deposits: deposits,
    rewards_reserved: rewards_reserved,
    last_calculation_timestamp: now
  ]
end

export fun(get_farm_infos()) do
  now = Time.now()
  now = now - Math.rem(now, @ROUND_NOW_TO)

  reward_token_balance = 0
  day = @SECONDS_IN_DAY
  year = 365 * day

  years = [
    [year: 1, start: @START_DATE, end: @START_DATE + year - 1, rewards: @REWARDS_YEAR_1],
    [
      year: 2,
      start: @START_DATE + year,
      end: @START_DATE + 2 * year - 1,
      rewards: @REWARDS_YEAR_2
    ],
    [
      year: 3,
      start: @START_DATE + 2 * year,
      end: @START_DATE + 3 * year - 1,
      rewards: @REWARDS_YEAR_3
    ],
    [year: 4, start: @START_DATE + 3 * year, end: @END_DATE, rewards: @REWARDS_YEAR_4]
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
  available_levels = Map.set(available_levels, "1", now + 7 * day)
  available_levels = Map.set(available_levels, "2", now + 30 * day)
  available_levels = Map.set(available_levels, "3", now + 90 * day)
  available_levels = Map.set(available_levels, "4", now + 180 * day)
  available_levels = Map.set(available_levels, "5", now + 365 * day)
  available_levels = Map.set(available_levels, "6", now + 730 * day)
  available_levels = Map.set(available_levels, "7", now + 1095 * day)

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

  start = monotonic()

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

  log("#{monotonic() - start} ms state calc")

  stats = Map.new()

  start = monotonic()

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

  log("#{monotonic() - start} ms stats")

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
  day = @SECONDS_IN_DAY
  year = 365 * day

  deposits = State.get("deposits", Map.new())

  reply = []

  user_genesis_address = String.to_hex(user_genesis_address)

  available_levels = Map.new()
  available_levels = Map.set(available_levels, "0", now + 0)
  available_levels = Map.set(available_levels, "1", now + 7 * day)
  available_levels = Map.set(available_levels, "2", now + 30 * day)
  available_levels = Map.set(available_levels, "3", now + 90 * day)
  available_levels = Map.set(available_levels, "4", now + 180 * day)
  available_levels = Map.set(available_levels, "5", now + 365 * day)
  available_levels = Map.set(available_levels, "6", now + 730 * day)
  available_levels = Map.set(available_levels, "7", now + 1095 * day)

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
