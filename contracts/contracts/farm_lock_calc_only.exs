@version 1

condition triggered_by: transaction, on: calculate_rewards() do
  true
end

actions triggered_by: transaction, on: calculate_rewards() do
  rounded_now = Time.now() - Math.rem(Time.now(), @ROUND_NOW_TO)

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
  time_elapsed_since_last_calc = Time.now() - State.get("last_calculation_timestamp", @START_DATE)
  time_remaining_until_farm_end = @END_DATE - State.get("last_calculation_timestamp", @START_DATE)

  giveaways =
    remaining_rewards_balance + State.get("rewards_distributed", 0) -
      (@REWARDS_YEAR_1 + @REWARDS_YEAR_2 + @REWARDS_YEAR_3 + @REWARDS_YEAR_4)

  giveaways_to_allocate =
    giveaways *
      (time_elapsed_since_last_calc / time_remaining_until_farm_end)

  # loop through all the hours since last calculation
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
         State.get("rewards_reserved", 0)) *
        ((period_to - period_from) / seconds_until_end_of_year) +
        giveaway_for_period

    # calculate tokens_weighted for each level
    tokens_weighted_by_level = Map.new()

    tokens_weighted_by_level =
      Map.set(
        tokens_weighted_by_level,
        "0",
        State.get("lp_tokens_deposited0", 0) * weight_by_level["0"]
      )

    tokens_weighted_by_level =
      Map.set(
        tokens_weighted_by_level,
        "1",
        State.get("lp_tokens_deposited1", 0) * weight_by_level["1"]
      )

    tokens_weighted_by_level =
      Map.set(
        tokens_weighted_by_level,
        "2",
        State.get("lp_tokens_deposited2", 0) * weight_by_level["2"]
      )

    tokens_weighted_by_level =
      Map.set(
        tokens_weighted_by_level,
        "3",
        State.get("lp_tokens_deposited3", 0) * weight_by_level["3"]
      )

    tokens_weighted_by_level =
      Map.set(
        tokens_weighted_by_level,
        "4",
        State.get("lp_tokens_deposited4", 0) * weight_by_level["4"]
      )

    tokens_weighted_by_level =
      Map.set(
        tokens_weighted_by_level,
        "5",
        State.get("lp_tokens_deposited5", 0) * weight_by_level["5"]
      )

    tokens_weighted_by_level =
      Map.set(
        tokens_weighted_by_level,
        "6",
        State.get("lp_tokens_deposited6", 0) * weight_by_level["6"]
      )

    tokens_weighted_by_level =
      Map.set(
        tokens_weighted_by_level,
        "7",
        State.get("lp_tokens_deposited7", 0) * weight_by_level["7"]
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
    deposits = State.get("deposits", Map.new())
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
            State.set(
              "lp_tokens_deposited#{user_deposit.level}",
              State.get("lp_tokens_deposited#{user_deposit.level}") - user_deposit.amount
            )

            State.set(
              "lp_tokens_deposited#{previous_level}",
              State.get("lp_tokens_deposited#{previous_level}") + user_deposit.amount
            )

            user_deposit = Map.set(user_deposit, "level", previous_level)
          end
        end

        updated_user_deposits = List.prepend(updated_user_deposits, user_deposit)
      end

      updated_deposits = Map.set(updated_deposits, user_address, updated_user_deposits)
    end

    State.set("deposits", updated_deposits)
    State.set("rewards_reserved", State.get("rewards_reserved", 0) + rewards_to_allocate)
    State.set("last_calculation_timestamp", period_to)
  end
end
