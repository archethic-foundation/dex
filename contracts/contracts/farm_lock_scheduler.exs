@version 1

actions triggered_by: interval, at: "5 * * * *" do
  Contract.add_recipient(
    address: 0x0000B2339AADF5685B1C8D400C9092C921E51588DC049E097EC9437017E7DDED0FEB,
    action: "calculate_rewards",
    args: []
  )

  State.set("tick", Time.now())
end
