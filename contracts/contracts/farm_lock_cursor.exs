@version 1

#      _                      _ _
#   __| | ___ _ __   ___  ___(_| |_
#  / _` |/ _ | '_ \ / _ \/ __| | __|
# | (_| |  __| |_) | (_) \__ | | |_
#  \__,_|\___| .__/ \___/|___|_|\__|

condition triggered_by: transaction, on: deposit(end_timestamp) do
  now = Time.now()
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
  day = @SECONDS_IN_DAY
  year = 365 * day

  if end_timestamp == "max" do
    end_timestamp = @END_DATE
  end

  if end_timestamp == "flex" do
    end_timestamp = 0
  end

  transfer_amount = get_user_transfer_amount()
  user_genesis_address = get_user_genesis()
  id = String.from_number(now)

  weight_by_level = Map.new()
  weight_by_level = Map.set(weight_by_level, "0", 0.007)
  weight_by_level = Map.set(weight_by_level, "1", 0.013)
  weight_by_level = Map.set(weight_by_level, "2", 0.024)
  weight_by_level = Map.set(weight_by_level, "3", 0.043)
  weight_by_level = Map.set(weight_by_level, "4", 0.077)
  weight_by_level = Map.set(weight_by_level, "5", 0.138)
  weight_by_level = Map.set(weight_by_level, "6", 0.249)
  weight_by_level = Map.set(weight_by_level, "7", 0.449)

  # split the deposit in many sub-deposits
  # 1 for each state change (level or year)
  deposit_splitted = []

  years_periods = get_years_periods(now, @END_DATE)

  if end_timestamp == 0 do
    # flexible
    for year_period in years_periods do
      deposit_splitted =
        List.append(deposit_splitted,
          user: user_genesis_address,
          id: id,
          since: now,
          level: "0",
          year: year_period.year,
          tokens: transfer_amount,
          weighted_tokens: transfer_amount * weight_by_level["0"],
          rewards: 0,
          from: year_period.from,
          to: year_period.to
        )
    end
  else
    levels_froms = Map.new()

    for level in all_levels() do
      levels_froms = Map.set(levels_froms, level, now + level_to_duration(level))
    end

    max_level = String.to_number(deposit_max_level(end_timestamp, levels_froms))

    # construct the periods from right to left
    # wich means from > to
    previous_from = @END_DATE

    for year_period in List.reverse(years_periods) do
      for level in 0..max_level do
        level = String.from_number(level)
        level_to = previous_from
        level_from = nil

        if level == "0" do
          level_from = end_timestamp
        else
          level_from = end_timestamp - level_to_duration(level)
        end

        if level_from < year_period.to && level_to > year_period.from do
          bounded_from = year_period.from

          if bounded_from < level_from do
            bounded_from = level_from
          end

          if bounded_from < now do
            bounded_from = now
          end

          bounded_to = year_period.to

          if bounded_to > level_to do
            bounded_to = level_to
          end

          deposit_splitted =
            List.prepend(deposit_splitted,
              user: user_genesis_address,
              id: id,
              since: now,
              level: level,
              year: year_period.year,
              tokens: transfer_amount,
              weighted_tokens: transfer_amount * weight_by_level[level],
              rewards: 0,
              from: bounded_from,
              to: bounded_to
            )

          previous_from = bounded_from
        end
      end
    end
  end

  # TODO: merge flexible

  res = calculate_new_rewards()
  State.set("cursor_timestamp", res.cursor_timestamp)
  State.set("cursor_year", res.cursor_year)
  State.set("cursor_weighted_tokens_total", res.cursor_weighted_tokens_total)
  State.set("cursor_weighted_tokens_by_level", res.cursor_weighted_tokens_by_level)
  State.set("rewards_reserved", res.rewards_reserved)

  sub_deposits = res.sub_deposits ++ deposit_splitted
  State.set("sub_deposits", List.sort_by(sub_deposits, "from"))
  State.set("tokens_deposited", State.get("tokens_deposited", 0) + transfer_amount)
end

#       _       _
#   ___| | __ _(_)_ __ ___
#  / __| |/ _` | | '_ ` _ \
# | (__| | (_| | | | | | | |
#  \___|_|\__,_|_|_| |_| |_|

condition triggered_by: transaction, on: claim(deposit_id) do
  if transaction.timestamp <= @START_DATE do
    throw(message: "farm is not started yet", code: 2001)
  end

  now = Time.now()
  res = calculate_new_rewards()

  user_genesis_address = get_user_genesis()
  user_deposit = get_deposit(user_genesis_address, deposit_id, res.sub_deposits)

  if user_deposit == nil do
    throw(message: "deposit not found", code: 2000)
  end

  if user_deposit.to != nil do
    throw(message: "claiming before end of lock", code: 2002)
  end

  user_deposit.rewards > 0
end

actions triggered_by: transaction, on: claim(deposit_id) do
  now = Time.now()
  res = calculate_new_rewards()
  user_genesis_address = get_user_genesis()
  user_deposit = get_deposit(user_genesis_address, deposit_id, res.sub_deposits)

  # transfer the rewards
  if @REWARD_TOKEN == "UCO" do
    Contract.add_uco_transfer(to: transaction.address, amount: user_deposit.rewards)
  else
    Contract.add_token_transfer(
      to: transaction.address,
      amount: user_deposit.rewards,
      token_address: @REWARD_TOKEN
    )
  end

  # clean rewards from sub_deposits
  updated_sub_deposits = []

  for sub_deposit in res.sub_deposits do
    if sub_deposit.user == user_genesis_address && sub_deposit.id == deposit_id do
      # no need to preserve the past sub_deposits any more
      if sub_deposit.to >= now do
        sub_deposit = Map.set(sub_deposit, "rewards", 0)
        updated_sub_deposits = List.prepend(updated_sub_deposits, sub_deposit)
      end
    else
      updated_sub_deposits = List.prepend(updated_sub_deposits, sub_deposit)
    end
  end

  State.set("sub_deposits", List.sort_by(updated_sub_deposits, "from"))
  State.set("rewards_distributed", State.get("rewards_distributed", 0) + user_deposit.rewards)
  State.set("rewards_reserved", res.rewards_reserved - user_deposit.rewards)

  # update cursor
  State.set("cursor_weighted_tokens_total", res.cursor_weighted_tokens_total)
  State.set("cursor_weighted_tokens_by_level", res.cursor_weighted_tokens_by_level)
  State.set("cursor_timestamp", res.cursor_timestamp)
  State.set("cursor_year", res.cursor_year)
end

#           _ _   _         _
# __      _(_| |_| |__   __| |_ __ __ ___      __
# \ \ /\ / | | __| '_ \ / _` | '__/ _` \ \ /\ / /
#  \ V  V /| | |_| | | | (_| | | | (_| |\ V  V /
#   \_/\_/ |_|\__|_| |_|\__,_|_|  \__,_| \_/\_/

condition triggered_by: transaction, on: withdraw(amount, deposit_id) do
  user_genesis_address = get_user_genesis()
  user_deposit = get_deposit(user_genesis_address, deposit_id, State.get("sub_deposits", []))

  if user_deposit == nil do
    throw(message: "deposit not found", code: 3000)
  end

  if amount > user_deposit.tokens do
    throw(message: "amount requested is greater than amount deposited", code: 3003)
  end

  if user_deposit.to != nil do
    throw(message: "withdrawing before end of lock", code: 3004)
  end

  true
end

actions triggered_by: transaction, on: withdraw(amount, deposit_index) do
  now = Time.now()
  res = calculate_new_rewards()
  sub_deposits = res.sub_deposits
  rewards_reserved = res.rewards_reserved

  user_genesis_address = get_user_genesis()
  user_deposit = get_deposit(user_genesis_address, deposit_id, sub_deposits)

  weight_by_level = Map.new()
  weight_by_level = Map.set(weight_by_level, "0", 0.007)
  weight_by_level = Map.set(weight_by_level, "1", 0.013)
  weight_by_level = Map.set(weight_by_level, "2", 0.024)
  weight_by_level = Map.set(weight_by_level, "3", 0.043)
  weight_by_level = Map.set(weight_by_level, "4", 0.077)
  weight_by_level = Map.set(weight_by_level, "5", 0.138)
  weight_by_level = Map.set(weight_by_level, "6", 0.249)
  weight_by_level = Map.set(weight_by_level, "7", 0.449)

  # transfer the rewards
  if user_deposit.rewards > 0 do
    if @REWARD_TOKEN == "UCO" do
      Contract.add_uco_transfer(to: transaction.address, amount: user_deposit.rewards)
    else
      Contract.add_token_transfer(
        to: transaction.address,
        amount: user_deposit.rewards,
        token_address: @REWARD_TOKEN
      )
    end

    rewards_reserved = rewards_reserved - user_deposit.rewards
  end

  # transfer the lp tokens
  Contract.add_token_transfer(
    to: transaction.address,
    amount: amount,
    token_address: @LP_TOKEN_ADDRESS
  )

  # update cursor
  weighted_tokens = user_deposit.tokens * weight_by_level[user_deposit.level]

  State.set(
    "cursor_weighted_tokens_total",
    res.cursor_weighted_tokens_total - weighted_tokens
  )

  State.set(
    "cursor_weighted_tokens_by_level",
    Map.set(
      res.cursor_weighted_tokens_by_level,
      user_deposit.level,
      Map.get(res.cursor_weighted_tokens_by_level, user_deposit.level, 0) -
        weighted_tokens
    )
  )

  State.set("cursor_timestamp", now)
  State.set("cursor_year", res.cursor_year)

  # reset rewards & update amount
  updated_sub_deposits = []

  for sub_deposit in sub_deposits do
    if sub_deposit.user == user_genesis_address && sub_deposit.id == deposit_id do
      remaining_tokens = sub_deposit.tokens - amount

      # no need to preserve the deposit if everything is withdrawn
      # no need to preserve the past sub_deposits any more
      if remaining_tokens > 0 && (sub_deposit.to == @END_DATE || sub_deposit.to >= now) do
        sub_deposit = Map.set(sub_deposit, "rewards", 0)
        sub_deposit = Map.set(sub_deposit, "tokens", remaining_tokens)

        sub_deposit =
          Map.set(
            sub_deposit,
            "weighted_tokens",
            remaining_tokens * weight_by_level[sub_deposit.level]
          )

        updated_sub_deposits = List.prepend(updated_sub_deposits, sub_deposit)
      end
    else
      updated_sub_deposits = List.prepend(updated_sub_deposits, sub_deposit)
    end
  end

  State.set("sub_deposits", List.sort_by(updated_sub_deposits, "from"))
  State.set("rewards_distributed", State.get("rewards_distributed", 0) + user_deposit.rewards)
  State.set("rewards_reserved", rewards_reserved)
  State.set("tokens_deposited", State.get("tokens_deposited", 0) - amount)
end

#                  _       _                        _
#  _   _ _ __   __| | __ _| |_ ___     ___ ___   __| | ___
# | | | | '_ \ / _` |/ _` | __/ _ \   / __/ _ \ / _` |/ _ \
# | |_| | |_) | (_| | (_| | ||  __/  | (_| (_) | (_| |  __/
#  \__,_| .__/ \__,_|\__,_|\__\_______\___\___/ \__,_|\___|
#       |_|                      |_____|
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

#             _    __                      _        __
#   __ _  ___| |_ / _| __ _ _ __ _ __ ___ (_)_ __  / _| ___  ___
#  / _` |/ _ | __| |_ / _` | '__| '_ ` _ \| | '_ \| |_ / _ \/ __|
# | (_| |  __| |_|  _| (_| | |  | | | | | | | | | |  _| (_) \__ \
#  \__, |\___|\__|_|  \__,_|_|  |_| |_| |_|_|_| |_|_|  \___/|___/
#  |___/
export fun(get_farm_infos()) do
  now = Time.now()
  day = @SECONDS_IN_DAY
  year = 365 * day

  rewards_reserved = State.get("rewards_reserved", 0)
  rewards_distributed = State.get("rewards_distributed", 0)
  tokens_deposited = State.get("tokens_deposited", 0)
  sub_deposits = State.get("sub_deposits", [])

  weight_by_level = Map.new()
  weight_by_level = Map.set(weight_by_level, "0", 0.007)
  weight_by_level = Map.set(weight_by_level, "1", 0.013)
  weight_by_level = Map.set(weight_by_level, "2", 0.024)
  weight_by_level = Map.set(weight_by_level, "3", 0.043)
  weight_by_level = Map.set(weight_by_level, "4", 0.077)
  weight_by_level = Map.set(weight_by_level, "5", 0.138)
  weight_by_level = Map.set(weight_by_level, "6", 0.249)
  weight_by_level = Map.set(weight_by_level, "7", 0.449)

  levels_froms = Map.new()
  levels_froms = Map.set(levels_froms, "0", now + 0)
  levels_froms = Map.set(levels_froms, "1", now + 7 * day)
  levels_froms = Map.set(levels_froms, "2", now + 30 * day)
  levels_froms = Map.set(levels_froms, "3", now + 90 * day)
  levels_froms = Map.set(levels_froms, "4", now + 180 * day)
  levels_froms = Map.set(levels_froms, "5", now + 365 * day)
  levels_froms = Map.set(levels_froms, "6", now + 730 * day)
  levels_froms = Map.set(levels_froms, "7", now + 1095 * day)

  years = [
    [year: 1, from: @START_DATE, to: @START_DATE + year, rewards: @REWARDS_YEAR_1],
    [
      year: 2,
      from: @START_DATE + year,
      to: @START_DATE + 2 * year,
      rewards: @REWARDS_YEAR_2
    ],
    [
      year: 3,
      from: @START_DATE + 2 * year,
      to: @START_DATE + 3 * year,
      rewards: @REWARDS_YEAR_3
    ],
    [year: 4, from: @START_DATE + 3 * year, to: @END_DATE, rewards: @REWARDS_YEAR_4]
  ]

  # retrieve remaining balance
  rewards_balance = nil

  if @REWARD_TOKEN == "UCO" do
    rewards_balance = contract.balance.uco
  else
    key = [token_address: @REWARD_TOKEN, token_id: 0]
    rewards_balance = Map.get(contract.balance.tokens, key, 0)
  end

  # calc remaining rewards
  rewards_remaining = nil

  if rewards_balance != nil do
    rewards_remaining = rewards_balance - rewards_reserved
  end

  # determine available levels
  available_levels = Map.new()
  end_reached = false

  for level in Map.keys(levels_froms) do
    level_from = levels_froms[level]

    if level_from < @END_DATE do
      available_levels = Map.set(available_levels, level, level_from)
    else
      if !end_reached && Map.size(available_levels) > 0 do
        available_levels = Map.set(available_levels, level, @END_DATE)
        end_reached = true
      end
    end
  end

  # calc stats
  tokens_deposited_weighted_total = 0
  tokens_deposited_weighted_by_level = Map.new()
  tokens_deposited_by_level = Map.new()
  deposits_count_by_level = Map.new()

  for sub_deposit in sub_deposits do
    # we only consider the sub_deposits that contains "now" (1 per deposit)
    if (now >= @END_DATE && sub_deposit.to == @END_DATE) ||
         (now >= sub_deposit.from && now < sub_deposit.to) do
      tokens_deposited_weighted_total =
        tokens_deposited_weighted_total + sub_deposit.weighted_tokens

      tokens_deposited_by_level =
        Map.set(
          tokens_deposited_by_level,
          level,
          Map.get(tokens_deposited_by_level, level, 0) + sub_deposit.tokens
        )

      tokens_deposited_weighted_by_level =
        Map.set(
          tokens_deposited_weighted_by_level,
          level,
          Map.get(tokens_deposited_weighted_by_level, level, 0) + sub_deposit.weighted_tokens
        )

      deposits_count_by_level =
        Map.set(
          deposits_count_by_level,
          level,
          Map.get(deposits_count_by_level, level, 0) + 1
        )
    end
  end

  stats = Map.new()

  for level in ["0", "1", "2", "3", "4", "5", "6", "7"] do
    rewards_allocated = []

    for y in years do
      rewards = 0

      if tokens_deposited_weighted_total > 0 do
        rewards =
          Map.get(tokens_deposited_weighted_by_level, level, 0) /
            tokens_deposited_weighted_total * y.rewards
      end

      rewards_allocated =
        List.append(rewards_allocated, start: y.from, end: y.to, rewards: rewards)
    end

    stats =
      Map.set(stats, level,
        rewards_allocated: rewards_allocated,
        deposits_count: Map.get(deposits_count_by_level, level, 0),
        lp_tokens_deposited: Map.get(tokens_deposited_by_level, level, 0),
        weight: weight_by_level[level]
      )
  end

  [
    lp_token_address: @LP_TOKEN_ADDRESS,
    reward_token: @REWARD_TOKEN,
    start_date: @START_DATE,
    end_date: @END_DATE,
    lp_tokens_deposited: tokens_deposited,
    remaining_rewards: rewards_remaining,
    rewards_distributed: rewards_distributed,
    available_levels: available_levels,
    stats: stats
  ]
end

#             _                       _        __
#   __ _  ___| |_ _   _ ___  ___ _ __(_)_ __  / _| ___  ___
#  / _` |/ _ | __| | | / __|/ _ | '__| | '_ \| |_ / _ \/ __|
# | (_| |  __| |_| |_| \__ |  __| |  | | | | |  _| (_) \__ \
#  \__, |\___|\__ \__,_|___/\___|_|  |_|_| |_|_|  \___/|___/
#  |___/

export fun(get_user_infos(user_genesis_address)) do
  now = Time.now()
  day = @SECONDS_IN_DAY
  year = 365 * day

  user_genesis_address = String.to_hex(user_genesis_address)

  # ========== START calculate_new_rewards ============

  sub_deposits = State.get("sub_deposits", [])
  tokens_deposited = State.get("tokens_deposited", 0)
  rewards_reserved = State.get("rewards_reserved", 0)
  rewards_distributed = State.get("rewards_distributed", 0)

  # next state
  updated_sub_deposits = sub_deposits
  updated_cursor = initial_cursor
  updated_rewards_reserved = rewards_reserved

  # cursor is the latest calculated state
  # we use it to avoid looping through everything on each period
  initial_cursor = [
    timestamp: State.get("cursor_timestamp", @START_DATE),
    year: State.get("cursor_year", "1"),
    weighted_tokens_total: State.get("cursor_weighted_tokens_total", 0),
    weighted_tokens_by_level: State.get("cursor_weighted_tokens_by_level", Map.new())
  ]

  if now > @START_DATE do
    timestamps = []

    for sub_deposit in sub_deposits do
      if sub_deposit.from >= initial_cursor.timestamp && sub_deposit.from < now do
        timestamps = List.append(timestamps, sub_deposit.from)
      end
    end

    state_changes = List.uniq(timestamps)

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

    end_by_year = Map.new()

    for year in ["1", "2", "3", "4"] do
      end_by_year = Map.set(end_by_year, year, @START_DATE + String.to_number(year) * 365 * day)
    end

    # retrieve remaining balance
    rewards_balance = nil

    if @REWARD_TOKEN == "UCO" do
      rewards_balance = contract.balance.uco
    else
      key = [token_address: @REWARD_TOKEN, token_id: 0]
      rewards_balance = Map.get(contract.balance.tokens, key, 0)
    end

    time_elapsed_since_last_calc = now - initial_cursor.timestamp
    time_remaining_until_farm_end = @END_DATE - initial_cursor.timestamp

    # giveaways are donation on the pool that are not part of the initial rewards
    giveaways =
      rewards_balance + rewards_distributed -
        (@REWARDS_YEAR_1 + @REWARDS_YEAR_2 + @REWARDS_YEAR_3 + @REWARDS_YEAR_4)

    giveaways_to_allocate = nil

    if now < @END_DATE do
      giveaways_to_allocate =
        giveaways * (time_elapsed_since_last_calc / time_remaining_until_farm_end)
    else
      giveaways_to_allocate = giveaways
    end

    cursor_by_timestamp = Map.set(Map.new(), initial_cursor.timestamp, initial_cursor)

    if initial_cursor.timestamp < now && initial_cursor.timestamp < @END_DATE &&
         tokens_deposited > 0 do
      previous_timestamp = initial_cursor.timestamp

      # UPDATE CURSOR
      for timestamp in state_changes do
        # initiate cursor with previous one
        cursor = cursor_by_timestamp[previous_timestamp]

        # update year
        # TODO: no need to loop on past years
        current_year = nil

        for year in Map.keys(end_by_year) do
          year_end = end_by_year[year]

          if current_year == nil && timestamp < year_end do
            current_year = year
          end
        end

        cursor = Map.set(cursor, "timestamp", timestamp)
        cursor = Map.set(cursor, "year", current_year)

        # loop through every deposit to find state changes and update the cursor
        for sub_deposit in sub_deposits do
          if sub_deposit.to == timestamp do
            # remove this sub_deposit from state
            cursor =
              Map.set(
                cursor,
                "weighted_tokens_total",
                cursor["weighted_tokens_total"] - sub_deposit.weighted_tokens
              )

            cursor =
              Map.set(
                cursor,
                "weighted_tokens_by_level",
                Map.set(
                  cursor["weighted_tokens_by_level"],
                  sub_deposit.level,
                  Map.get(cursor["weighted_tokens_by_level"], sub_deposit.level, 0) -
                    sub_deposit.weighted_tokens
                )
              )
          end

          if sub_deposit.from == timestamp do
            # add this sub_deposit to state
            cursor =
              Map.set(
                cursor,
                "weighted_tokens_total",
                cursor["weighted_tokens_total"] + sub_deposit.weighted_tokens
              )

            cursor =
              Map.set(
                cursor,
                "weighted_tokens_by_level",
                Map.set(
                  cursor["weighted_tokens_by_level"],
                  sub_deposit.level,
                  Map.get(cursor["weighted_tokens_by_level"], sub_deposit.level, 0) +
                    sub_deposit.weighted_tokens
                )
              )
          end

          cursor_by_timestamp = Map.set(cursor_by_timestamp, timestamp, cursor)
        end

        previous_timestamp = timestamp
      end

      # CALCULATE REWARDS
      previous_timestamp = initial_cursor.timestamp

      until = now

      if now > @END_DATE do
        until = @END_DATE
      end

      timestamps = List.sort(List.append(Map.keys(cursor_by_timestamp), until))
      previous_year_reward_accumulated = 0

      for timestamp in timestamps do
        if timestamp != initial_cursor.timestamp && timestamp <= @END_DATE do
          cursor = cursor_by_timestamp[previous_timestamp]

          if cursor.weighted_tokens_total > 0 do
            giveaway_for_period =
              giveaways_to_allocate *
                ((timestamp - cursor.timestamp) / time_elapsed_since_last_calc)

            rewards_allocated_at_year_end = rewards_allocated_at_each_year_end[cursor.year]

            # calc rewards to allocated for the current period (cursor -> timestamp)
            remaining_until_end_of_year = end_by_year[cursor.year] - cursor.timestamp

            rewards_to_allocate =
              (rewards_allocated_at_year_end - rewards_distributed - rewards_reserved -
                 previous_year_reward_accumulated) *
                ((timestamp - cursor.timestamp) / remaining_until_end_of_year) +
                giveaway_for_period

            previous_year_reward_accumulated =
              previous_year_reward_accumulated + rewards_to_allocate

            # allocated them by level
            rewards_to_allocate_by_level = Map.new()

            for level in Map.keys(cursor.weighted_tokens_by_level) do
              rewards_to_allocate_by_level =
                Map.set(
                  rewards_to_allocate_by_level,
                  level,
                  cursor.weighted_tokens_by_level[level] / cursor.weighted_tokens_total *
                    rewards_to_allocate
                )
            end

            # set rewards to sub_deposits
            updated_sub_deposits2 = []

            for sub_deposit in updated_sub_deposits do
              if sub_deposit.from <= cursor.timestamp && sub_deposit.to > cursor.timestamp do
                rewards =
                  rewards_to_allocate_by_level[sub_deposit.level] *
                    (sub_deposit.weighted_tokens /
                       cursor.weighted_tokens_by_level[sub_deposit.level])

                updated_rewards_reserved = updated_rewards_reserved + rewards
                sub_deposit = Map.set(sub_deposit, "rewards", sub_deposit["rewards"] + rewards)
              end

              updated_sub_deposits2 = List.prepend(updated_sub_deposits2, sub_deposit)
            end

            updated_sub_deposits = updated_sub_deposits2
          end

          updated_cursor = Map.set(cursor, "timestamp", timestamp)
        end

        previous_timestamp = timestamp
      end
    end
  else
    updated_sub_deposits = sub_deposits
    updated_cursor = initial_cursor
    updated_rewards_reserved = rewards_reserved
  end

  # sub_deposits are unsorted
  # no point in sorting them if we update them right after
  res = [
    sub_deposits: updated_sub_deposits,
    cursor_timestamp: updated_cursor.timestamp,
    cursor_year: updated_cursor.year,
    cursor_weighted_tokens_total: updated_cursor.weighted_tokens_total,
    cursor_weighted_tokens_by_level: updated_cursor.weighted_tokens_by_level,
    rewards_reserved: updated_rewards_reserved
  ]

  # ========== END calculate_new_rewards ============

  sub_deposits = res.sub_deposits
  user_sub_deposits_by_id = Map.new()

  for sub_deposit in sub_deposits do
    if sub_deposit.user == user_genesis_address do
      previous_sub_deposits_for_id = Map.get(user_sub_deposits_by_id, sub_deposit.id, [])
      sub_deposits_for_id = List.append(previous_sub_deposits_for_id, sub_deposit)

      user_sub_deposits_by_id =
        Map.set(user_sub_deposits_by_id, sub_deposit.id, sub_deposits_for_id)
    end
  end

  reply = []

  # sub_deposits to deposits
  for id in Map.keys(user_sub_deposits_by_id) do
    sub_deposits_for_id = user_sub_deposits_by_id[id]
    max_level = 0
    since = nil
    max_to = nil
    tokens = nil
    rewards = 0

    for sub_deposit in sub_deposits_for_id do
      since = sub_deposit.since
      sub_deposit_level = String.to_number(sub_deposit.level)
      tokens = sub_deposit.tokens
      rewards = rewards + sub_deposit.rewards

      if sub_deposit_level != 0 && (max_to == nil || max_to < sub_deposit.to) do
        max_to = sub_deposit.to
      end

      if sub_deposit.to > now && max_level < sub_deposit_level do
        max_level = sub_deposit_level
      end
    end

    reply =
      List.append(reply,
        id: id,
        amount: tokens,
        reward_amount: rewards,
        level: String.from_number(max_level),
        start: since,
        end: max_to
      )
  end

  reply
end

fun get_deposit(user_genesis_address, deposit_id, sub_deposits) do
  now = Time.now()
  sub_deposits_relevant = []

  max_level = 0
  since = nil
  max_to = nil
  tokens = nil
  rewards = 0

  for sub_deposit in sub_deposits do
    if sub_deposit.user == user_genesis_address && sub_deposit.id == deposit_id do
      since = sub_deposit.since
      sub_deposit_level = String.to_number(sub_deposit.level)
      tokens = sub_deposit.tokens
      rewards = rewards + sub_deposit.rewards

      # only consider the sub_deposits remaining
      if sub_deposit.to >= now do
        if sub_deposit_level != 0 &&
             (max_to == nil || max_to < sub_deposit.to) do
          max_to = sub_deposit.to
        end

        if max_level < sub_deposit_level do
          max_level = sub_deposit_level
        end
      end
    end
  end

  reply = nil

  if tokens != nil do
    reply = [
      id: deposit_id,
      tokens: tokens,
      rewards: rewards,
      level: String.from_number(max_level),
      from: since,
      to: max_to
    ]
  end

  reply
end

fun get_years_periods(from, to) do
  day = @SECONDS_IN_DAY
  year = 365 * day

  years = [
    [year: 1, from: @START_DATE, to: @START_DATE + 1 * year],
    [year: 2, from: @START_DATE + 1 * year, to: @START_DATE + 2 * year],
    [year: 3, from: @START_DATE + 2 * year, to: @START_DATE + 3 * year],
    [year: 4, from: @START_DATE + 3 * year, to: @START_DATE + 4 * year]
  ]

  periods = []

  for year in years do
    if from < year.to && to > year.from do
      bounded_from = year.from

      if bounded_from < from do
        bounded_from = from
      end

      bounded_to = year.to

      if bounded_to > to do
        bounded_to = to
      end

      periods =
        List.append(periods,
          year: year.year,
          from: bounded_from,
          to: bounded_to
        )
    end
  end

  periods
end

fun deposit_max_level(end_timestamp, levels_froms) do
  deposit_level = nil

  for level in Map.keys(levels_froms) do
    level_from = levels_froms[level]

    if deposit_level == nil && end_timestamp <= level_from do
      deposit_level = level
    end
  end

  if deposit_level == nil do
    deposit_level = "7"
  end

  deposit_level
end

fun all_levels() do
  ["0", "1", "2", "3", "4", "5", "6", "7"]
end

fun level_to_duration(level) do
  day = @SECONDS_IN_DAY

  duration = nil

  if level == "0" do
    duration = 0
  end

  if level == "1" do
    duration = 7 * day
  end

  if level == "2" do
    duration = 30 * day
  end

  if level == "3" do
    duration = 90 * day
  end

  if level == "4" do
    duration = 180 * day
  end

  if level == "5" do
    duration = 365 * day
  end

  if level == "6" do
    duration = 730 * day
  end

  if level == "7" do
    duration = 1095 * day
  end

  duration
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

fun get_user_genesis() do
  previous_address = Chain.get_previous_address(transaction)
  Chain.get_genesis_address(previous_address)
end

fun calculate_new_rewards() do
  now = Time.now()
  day = @SECONDS_IN_DAY

  sub_deposits = State.get("sub_deposits", [])
  tokens_deposited = State.get("tokens_deposited", 0)
  rewards_reserved = State.get("rewards_reserved", 0)
  rewards_distributed = State.get("rewards_distributed", 0)

  # next state
  updated_sub_deposits = sub_deposits
  updated_cursor = initial_cursor
  updated_rewards_reserved = rewards_reserved

  # cursor is the latest calculated state
  # we use it to avoid looping through everything on each period
  initial_cursor = [
    timestamp: State.get("cursor_timestamp", @START_DATE),
    year: State.get("cursor_year", "1"),
    weighted_tokens_total: State.get("cursor_weighted_tokens_total", 0),
    weighted_tokens_by_level: State.get("cursor_weighted_tokens_by_level", Map.new())
  ]

  if now > @START_DATE do
    timestamps = []

    for sub_deposit in sub_deposits do
      if sub_deposit.from >= initial_cursor.timestamp && sub_deposit.from < now do
        timestamps = List.append(timestamps, sub_deposit.from)
      end
    end

    state_changes = List.uniq(timestamps)

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

    end_by_year = Map.new()

    for year in ["1", "2", "3", "4"] do
      end_by_year = Map.set(end_by_year, year, @START_DATE + String.to_number(year) * 365 * day)
    end

    # retrieve remaining balance
    rewards_balance = nil

    if @REWARD_TOKEN == "UCO" do
      rewards_balance = contract.balance.uco
    else
      key = [token_address: @REWARD_TOKEN, token_id: 0]
      rewards_balance = Map.get(contract.balance.tokens, key, 0)
    end

    time_elapsed_since_last_calc = now - initial_cursor.timestamp
    time_remaining_until_farm_end = @END_DATE - initial_cursor.timestamp

    # giveaways are donation on the pool that are not part of the initial rewards
    giveaways =
      rewards_balance + rewards_distributed -
        (@REWARDS_YEAR_1 + @REWARDS_YEAR_2 + @REWARDS_YEAR_3 + @REWARDS_YEAR_4)

    giveaways_to_allocate = nil

    if now < @END_DATE do
      giveaways_to_allocate =
        giveaways * (time_elapsed_since_last_calc / time_remaining_until_farm_end)
    else
      giveaways_to_allocate = giveaways
    end

    cursor_by_timestamp = Map.set(Map.new(), initial_cursor.timestamp, initial_cursor)

    if initial_cursor.timestamp < now && initial_cursor.timestamp < @END_DATE &&
         tokens_deposited > 0 do
      previous_timestamp = initial_cursor.timestamp

      # UPDATE CURSOR
      for timestamp in state_changes do
        # initiate cursor with previous one
        cursor = cursor_by_timestamp[previous_timestamp]

        # update year
        # TODO: no need to loop on past years
        current_year = nil

        for year in Map.keys(end_by_year) do
          year_end = end_by_year[year]

          if current_year == nil && timestamp < year_end do
            current_year = year
          end
        end

        cursor = Map.set(cursor, "timestamp", timestamp)
        cursor = Map.set(cursor, "year", current_year)

        # loop through every deposit to find state changes and update the cursor
        for sub_deposit in sub_deposits do
          if sub_deposit.to == timestamp do
            # remove this sub_deposit from state
            cursor =
              Map.set(
                cursor,
                "weighted_tokens_total",
                cursor["weighted_tokens_total"] - sub_deposit.weighted_tokens
              )

            cursor =
              Map.set(
                cursor,
                "weighted_tokens_by_level",
                Map.set(
                  cursor["weighted_tokens_by_level"],
                  sub_deposit.level,
                  Map.get(cursor["weighted_tokens_by_level"], sub_deposit.level, 0) -
                    sub_deposit.weighted_tokens
                )
              )
          end

          if sub_deposit.from == timestamp do
            # add this sub_deposit to state
            cursor =
              Map.set(
                cursor,
                "weighted_tokens_total",
                cursor["weighted_tokens_total"] + sub_deposit.weighted_tokens
              )

            cursor =
              Map.set(
                cursor,
                "weighted_tokens_by_level",
                Map.set(
                  cursor["weighted_tokens_by_level"],
                  sub_deposit.level,
                  Map.get(cursor["weighted_tokens_by_level"], sub_deposit.level, 0) +
                    sub_deposit.weighted_tokens
                )
              )
          end

          cursor_by_timestamp = Map.set(cursor_by_timestamp, timestamp, cursor)
        end

        previous_timestamp = timestamp
      end

      # CALCULATE REWARDS
      previous_timestamp = initial_cursor.timestamp

      until = now

      if now > @END_DATE do
        until = @END_DATE
      end

      timestamps = List.sort(List.append(Map.keys(cursor_by_timestamp), until))
      previous_year_reward_accumulated = 0

      for timestamp in timestamps do
        if timestamp != initial_cursor.timestamp && timestamp <= @END_DATE do
          cursor = cursor_by_timestamp[previous_timestamp]

          if cursor.weighted_tokens_total > 0 do
            giveaway_for_period =
              giveaways_to_allocate *
                ((timestamp - cursor.timestamp) / time_elapsed_since_last_calc)

            rewards_allocated_at_year_end = rewards_allocated_at_each_year_end[cursor.year]

            # calc rewards to allocated for the current period (cursor -> timestamp)
            remaining_until_end_of_year = end_by_year[cursor.year] - cursor.timestamp

            rewards_to_allocate =
              (rewards_allocated_at_year_end - rewards_distributed - rewards_reserved -
                 previous_year_reward_accumulated) *
                ((timestamp - cursor.timestamp) / remaining_until_end_of_year) +
                giveaway_for_period

            previous_year_reward_accumulated =
              previous_year_reward_accumulated + rewards_to_allocate

            # allocated them by level
            rewards_to_allocate_by_level = Map.new()

            for level in Map.keys(cursor.weighted_tokens_by_level) do
              rewards_to_allocate_by_level =
                Map.set(
                  rewards_to_allocate_by_level,
                  level,
                  cursor.weighted_tokens_by_level[level] / cursor.weighted_tokens_total *
                    rewards_to_allocate
                )
            end

            # set rewards to sub_deposits
            updated_sub_deposits2 = []

            for sub_deposit in updated_sub_deposits do
              if sub_deposit.from <= cursor.timestamp && sub_deposit.to > cursor.timestamp do
                rewards =
                  rewards_to_allocate_by_level[sub_deposit.level] *
                    (sub_deposit.weighted_tokens /
                       cursor.weighted_tokens_by_level[sub_deposit.level])

                updated_rewards_reserved = updated_rewards_reserved + rewards
                sub_deposit = Map.set(sub_deposit, "rewards", sub_deposit["rewards"] + rewards)
              end

              updated_sub_deposits2 = List.prepend(updated_sub_deposits2, sub_deposit)
            end

            updated_sub_deposits = updated_sub_deposits2
          end

          updated_cursor = Map.set(cursor, "timestamp", timestamp)
        end

        previous_timestamp = timestamp
      end
    end
  else
    updated_sub_deposits = sub_deposits
    updated_cursor = initial_cursor
    updated_rewards_reserved = rewards_reserved
  end

  # sub_deposits are unsorted
  # no point in sorting them if we update them right after
  [
    sub_deposits: updated_sub_deposits,
    cursor_timestamp: updated_cursor.timestamp,
    cursor_year: updated_cursor.year,
    cursor_weighted_tokens_total: updated_cursor.weighted_tokens_total,
    cursor_weighted_tokens_by_level: updated_cursor.weighted_tokens_by_level,
    rewards_reserved: updated_rewards_reserved
  ]
end
