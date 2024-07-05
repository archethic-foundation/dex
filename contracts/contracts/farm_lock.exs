@version 1

condition triggered_by: transaction, on: deposit(end_timestamp) do
  if end_timestamp == "max" do
    end_timestamp = @END_DATE
  end

  if end_timestamp == "flex" do
    end_timestamp = 0
  end

  if transaction.timestamp >= @END_DATE do
    throw(message: "deposit impossible once farm is closed", code: 1001)
  end

  if end_timestamp > @END_DATE do
    throw(message: "deposit's end cannot be greater than farm's end", code: 1005)
  end

  if get_user_transfer_amount() <= 0 do
    throw(message: "deposit's amount must greater than 0", code: 1002)
  end

  true
end

actions triggered_by: transaction, on: deposit(end_timestamp) do
  now = Time.now()
  start = now

  if end_timestamp == "max" do
    end_timestamp = @END_DATE
  end

  if end_timestamp == "flex" do
    end_timestamp = 0
    start = nil
  end

  transfer_amount = get_user_transfer_amount()

  user_genesis_address = get_user_genesis(transaction)

  deposits = nil

  if now > @START_DATE do
    res = calculate_new_rewards()
    deposits = res.deposits
    State.set("rewards_reserved", res.rewards_reserved)
    State.set("last_calculation_timestamp", res.last_calculation_timestamp)
  else
    deposits = State.get("deposits", Map.new())
  end

  current_deposit = [amount: transfer_amount, reward_amount: 0, start: now, end: end_timestamp]

  user_deposits = Map.get(deposits, user_genesis_address, [])
  user_deposits = List.append(user_deposits, current_deposit)
  deposits = Map.set(deposits, user_genesis_address, user_deposits)

  State.set("deposits", deposits)

  lp_tokens_deposited = State.get("lp_tokens_deposited", 0)
  State.set("lp_tokens_deposited", lp_tokens_deposited + transfer_amount)
end

condition triggered_by: transaction, on: claim(deposit_index) do
  if transaction.timestamp <= @START_DATE do
    throw(message: "farm is not started yet", code: 2001)
  end

  now = Time.now()
  user_genesis_address = get_user_genesis(transaction)
  user_deposit = get_user_deposit(user_genesis_address, deposit_index)

  if user_deposit == nil do
    throw(message: "deposit not found", code: 2000)
  end

  if user_deposit.end > now do
    throw(message: "claiming before end of lock", code: 2002)
  end

  res = calculate_new_rewards()
  user_deposits = Map.get(res.deposits, user_genesis_address)
  user_deposit = List.at(user_deposits, deposit_index)

  user_deposit.reward_amount > 0
end

actions triggered_by: transaction, on: claim(deposit_index) do
  user_genesis_address = get_user_genesis(transaction)

  res = calculate_new_rewards()
  deposits = res.deposits
  State.set("last_calculation_timestamp", res.last_calculation_timestamp)

  user_deposits = Map.get(deposits, user_genesis_address)
  user_deposit = List.at(user_deposits, deposit_index)

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
  user_deposits = List.set_at(user_deposits, deposit_index, user_deposit)

  deposits = Map.set(deposits, user_genesis_address, user_deposits)
  State.set("deposits", deposits)
end

condition triggered_by: transaction, on: withdraw(amount, deposit_index) do
  user_genesis_address = get_user_genesis(transaction)
  user_deposit = get_user_deposit(user_genesis_address, deposit_index)

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

actions triggered_by: transaction, on: withdraw(amount, deposit_index) do
  user_genesis_address = get_user_genesis(transaction)

  deposits = nil
  rewards_reserved = nil

  if Time.now() > @START_DATE do
    res = calculate_new_rewards()
    deposits = res.deposits
    rewards_reserved = res.rewards_reserved
    State.set("last_calculation_timestamp", res.last_calculation_timestamp)
  else
    deposits = State.get("deposits", Map.new())
    rewards_reserved = State.get("rewards_reserved", 0)
  end

  user_deposits = Map.get(deposits, user_genesis_address)
  user_deposit = List.at(user_deposits, deposit_index)

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

  lp_tokens_deposited = State.get("lp_tokens_deposited")
  State.set("lp_tokens_deposited", lp_tokens_deposited - amount)

  if amount == user_deposit.amount do
    user_deposits = List.delete_at(user_deposits, deposit_index)

    if List.size(user_deposits) > 0 do
      deposits = Map.set(deposits, user_genesis_address, user_deposits)
    else
      deposits = Map.delete(deposits, user_genesis_address)
    end
  else
    user_deposit = Map.set(user_deposit, "reward_amount", 0)
    user_deposit = Map.set(user_deposit, "amount", user_deposit.amount - amount)
    user_deposits = List.set_at(user_deposits, deposit_index, user_deposit)
    deposits = Map.set(deposits, user_genesis_address, user_deposits)
  end

  State.set("deposits", deposits)
end

condition triggered_by: transaction, on: relock(end_timestamp, deposit_index) do
  if end_timestamp == "max" do
    end_timestamp = @END_DATE
  end

  user_genesis_address = get_user_genesis(transaction)
  user_deposit = get_user_deposit(user_genesis_address, deposit_index)

  if user_deposit == nil do
    throw(message: "deposit not found", code: 4000)
  end

  if transaction.timestamp >= @END_DATE do
    throw(message: "relock impossible once farm is closed", code: 4002)
  end

  if end_timestamp > @END_DATE do
    throw(message: "relock's end cannot be past farm's end", code: 4003)
  end

  if user_deposit["end"] >= end_timestamp do
    throw(message: "relock's end cannot be inferior or equal to deposit's end", code: 4004)
  end

  true
end

actions triggered_by: transaction, on: relock(end_timestamp, deposit_index) do
  if end_timestamp == "max" do
    end_timestamp = @END_DATE
  end

  now = Time.now()
  user_genesis_address = get_user_genesis(transaction)

  res = calculate_new_rewards()
  deposits = res.deposits
  State.set("last_calculation_timestamp", res.last_calculation_timestamp)

  user_deposits = Map.get(deposits, user_genesis_address)
  user_deposit = List.at(user_deposits, deposit_index)

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
  user_deposit = Map.set(user_deposit, "end", end_timestamp)
  user_deposits = List.set_at(user_deposits, deposit_index, user_deposit)

  deposits = Map.set(deposits, user_genesis_address, user_deposits)
  State.set("deposits", deposits)
end

condition(
  triggered_by: transaction,
  on: update_dates(new_start_date, new_end_date),
  as: [
    previous_public_key:
      (
        # Can only be updated by master chain of the dex
        previous_address = Chain.get_previous_address()
        Chain.get_genesis_address(previous_address) == @MASTER_ADDRESS
      ),
    content:
      (
        # Can update date only if farm is already ended
        now = Time.now()

        valid_update_date? = now >= @END_DATE
        valid_start_date? = now + 7200 <= new_start_date && now + 604_800 >= new_start_date

        valid_end_date? =
          new_start_date + 2_592_000 <= new_end_date &&
            new_start_date + 31_536_000 >= new_end_date

        valid_update_date? && valid_start_date? && valid_end_date?
      )
  ]
)

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
  day = 86400
  year = 31_536_000

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
      Map.set(rewards_allocated_at_each_year_end, "1", @INITIAL_BALANCE * 0.5)

    rewards_allocated_at_each_year_end =
      Map.set(rewards_allocated_at_each_year_end, "2", @INITIAL_BALANCE * 0.75)

    rewards_allocated_at_each_year_end =
      Map.set(rewards_allocated_at_each_year_end, "3", @INITIAL_BALANCE * 0.875)

    rewards_allocated_at_each_year_end =
      Map.set(rewards_allocated_at_each_year_end, "4", @INITIAL_BALANCE)

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
    time_elapsed_since_last_calc = now - last_calculation_timestamp
    time_remaining_until_farm_end = @END_DATE - last_calculation_timestamp
    giveaways = rewards_balance + rewards_distributed - @INITIAL_BALANCE

    giveaways_to_allocate =
      giveaways * (time_elapsed_since_last_calc / time_remaining_until_farm_end)

    if lp_tokens_deposited > 0 do
      deposit_periods = []

      # ================================================
      # CALCULATE THE PERIODS FOR EVERY DEPOSIT
      # ================================================

      for address in Map.keys(deposits) do
        user_deposits = Map.get(deposits, address)
        user_deposits_updated = []

        i = 0

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
                    deposit_index: i
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
                  deposit_index: i
                )
            end

            deposit_periods = deposit_periods ++ deposit_periods_for_year
          end

          i = i + 1
        end
      end

      deposit_periods = List.sort_by(deposit_periods, "start")

      # ================================================
      # DETERMINE ALL THE PERIODS STARTS
      # ================================================

      start_periods = []

      for deposit_period in deposit_periods do
        start_periods =
          List.append(start_periods,
            start: deposit_period.start,
            year: deposit_period.year,
            remaining_until_end_of_year: deposit_period.remaining_until_end_of_year
          )
      end

      start_periods = List.uniq(start_periods)

      # ================================================
      # CREATE PERIODS
      # ================================================

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
        max_end = @END_DATE - day
      end

      start_end_years =
        List.append(start_end_years,
          start: previous.start,
          end: max_end,
          year: previous.year,
          remaining_until_end_of_year: previous.remaining_until_end_of_year
        )

      # ================================================
      # FOR EACH PERIOD DETERMINE THE DEPOSITS STATES
      # ================================================

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
                deposit_index: deposit_period.deposit_index,
                user_address: deposit_period.user_address
              )
          end
        end

        deposits_per_period = Map.set(deposits_per_period, start_end_year, deposits_in_period)
      end

      # ================================================
      # FOR EACH PERIOD DETERMINE THE REWARD TO ALLOCATE FOR EACH LEVEL
      # ================================================
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
          deposit_key = [user_address: deposit.user_address, deposit_index: deposit.deposit_index]
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
    end

    for address in Map.keys(deposits) do
      user_deposits = Map.get(deposits, address)

      i = 0
      user_deposits_updated = []

      for user_deposit in user_deposits do
        deposit_key = [deposit_index: i, user_address: address]
        new_reward_amount = Map.get(reward_per_deposit, deposit_key)

        user_deposit =
          Map.set(user_deposit, "reward_amount", user_deposit.reward_amount + new_reward_amount)

        rewards_reserved = rewards_reserved + new_reward_amount
        user_deposits_updated = List.append(user_deposits_updated, user_deposit)
        i = i + 1
      end

      deposits = Map.set(deposits, address, user_deposits_updated)
    end
  end

  [
    deposits: deposits,
    rewards_reserved: rewards_reserved,
    last_calculation_timestamp: now
  ]
end

export fun(get_farm_infos()) do
  now = Time.now()
  reward_token_balance = 0
  day = 86400

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

  stats = Map.new()

  stats =
    Map.set(stats, "0",
      weight: Map.get(weight_per_level, "0"),
      rewards_allocated: Map.get(weight_per_level, "0") * reward_token_balance,
      lp_tokens_deposited: 0,
      deposits_count: 0,
      tvl_ratio: 0
    )

  stats =
    Map.set(stats, "1",
      weight: Map.get(weight_per_level, "1"),
      rewards_allocated: Map.get(weight_per_level, "1") * reward_token_balance,
      lp_tokens_deposited: 0,
      deposits_count: 0,
      tvl_ratio: 0
    )

  stats =
    Map.set(stats, "2",
      weight: Map.get(weight_per_level, "2"),
      rewards_allocated: Map.get(weight_per_level, "2") * reward_token_balance,
      lp_tokens_deposited: 0,
      deposits_count: 0,
      tvl_ratio: 0
    )

  stats =
    Map.set(stats, "3",
      weight: Map.get(weight_per_level, "3"),
      rewards_allocated: Map.get(weight_per_level, "3") * reward_token_balance,
      lp_tokens_deposited: 0,
      deposits_count: 0,
      tvl_ratio: 0
    )

  stats =
    Map.set(stats, "4",
      weight: Map.get(weight_per_level, "4"),
      rewards_allocated: Map.get(weight_per_level, "4") * reward_token_balance,
      lp_tokens_deposited: 0,
      deposits_count: 0,
      tvl_ratio: 0
    )

  stats =
    Map.set(stats, "5",
      weight: Map.get(weight_per_level, "5"),
      rewards_allocated: Map.get(weight_per_level, "5") * reward_token_balance,
      lp_tokens_deposited: 0,
      deposits_count: 0,
      tvl_ratio: 0
    )

  stats =
    Map.set(stats, "6",
      weight: Map.get(weight_per_level, "6"),
      rewards_allocated: Map.get(weight_per_level, "6") * reward_token_balance,
      lp_tokens_deposited: 0,
      deposits_count: 0,
      tvl_ratio: 0
    )

  stats =
    Map.set(stats, "7",
      weight: Map.get(weight_per_level, "7"),
      rewards_allocated: Map.get(weight_per_level, "7") * reward_token_balance,
      lp_tokens_deposited: 0,
      deposits_count: 0,
      tvl_ratio: 0
    )

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

      stats_for_level = Map.get(stats, level)

      lp_tokens_deposited_for_level =
        Map.get(stats_for_level, "lp_tokens_deposited") + user_deposit.amount

      deposits_count_for_level = Map.get(stats_for_level, "deposits_count") + 1
      tvl_ratio = lp_tokens_deposited_for_level / lp_tokens_deposited

      stats_for_level =
        Map.set(stats_for_level, "lp_tokens_deposited", lp_tokens_deposited_for_level)

      stats_for_level = Map.set(stats_for_level, "tvl_ratio", tvl_ratio)

      stats_for_level = Map.set(stats_for_level, "deposits_count", deposits_count_for_level)
      stats = Map.set(stats, level, stats_for_level)
    end
  end

  [
    lp_token_address: @LP_TOKEN_ADDRESS,
    reward_token: @REWARD_TOKEN,
    start_date: @START_DATE,
    end_date: @END_DATE,
    remaining_rewards: remaining_rewards,
    rewards_distributed: State.get("rewards_distributed", 0),
    available_levels: available_levels,
    stats: stats
  ]
end

export fun(get_user_infos(user_genesis_address)) do
  now = Time.now()
  day = 86400
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

  deposits = State.get("deposits", Map.new())
  user_deposits = Map.get(deposits, user_genesis_address, [])

  # REFAIRE l'equivalent d'un calculate_new_reward

  i = 0

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
      index: i,
      amount: user_deposit.amount,
      reward_amount: user_deposit.reward_amount,
      level: level
    ]

    if user_deposit.end > now do
      info = Map.set(info, "end", user_deposit.end)
      info = Map.set(info, "start", user_deposit.start)
    end

    reply = List.append(reply, info)
    i = i + 1
  end

  reply
end

fun get_user_genesis(transaction) do
  previous_address = Chain.get_previous_address(transaction)
  Chain.get_genesis_address(previous_address)
end

fun get_user_deposit(user_genesis_address, deposit_index) do
  deposits = State.get("deposits", Map.new())
  user_deposits = Map.get(deposits, user_genesis_address, [])
  List.at(user_deposits, deposit_index)
end
