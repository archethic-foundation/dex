@version 1

# allow code change
condition inherit: [
  code: true
]

actions triggered_by: datetime, at: 1848658200 do
  # stop the scheduler 10 minutes after farm's end
  Contract.set_type("data")
  Contract.set_content("so long and thanks for all the fish")
  Contract.set_code("")
end

# every hour trigger farm's "calculate_rewards" action
actions triggered_by: interval, at: "5 * * * *" do
  Contract.add_recipient(
    address: 0x0000B2339AADF5685B1C8D400C9092C921E51588DC049E097EC9437017E7DDED0FEB,
    action: "calculate_rewards",
    args: []
  )

  State.set("tick", Time.now())
end
