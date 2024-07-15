#!/bin/bash


# Execute node dex create_user_wallet
# WARNING !!!!!!! Seed : Not use in testnet nor mainnet environment - ONLY devnet / localhost
# orient clog surface flat clever pizza damage nest squeeze chapter main annual another pill history robot payment course hint knock call this erode tiger
# 9C857368AC42A94B4DC4A4D384CE1904B099499B0DD9A1A629AF3DE207C19327
echo -e "\nExecuting: node dex create_user_wallet"
echo "--------------------------------------"
if ! node dex create_user_wallet --access_seed 9C857368AC42A94B4DC4A4D384CE1904B099499B0DD9A1A629AF3DE207C19327 --service_name archethic-wallet-BOB; then
  echo "Error: Command 'node dex create_user_wallet' failed."
  exit 1
fi

# Execute node dex init_keychain
echo -e "\nExecuting: node dex init_keychain"
echo "---------------------------------"
if ! node dex init_keychain; then
  echo "Error: Command 'node dex init_keychain' failed."
  exit 1
fi

# Execute node dex deploy_factory
echo -e "\nExecuting: node dex deploy_factory"
echo "----------------------------------"
if ! node dex deploy_factory; then
  echo "Error: Command 'node dex deploy_factory' failed."
  exit 1
fi

# Execute node dex deploy_router
echo -e "\nExecuting: node dex deploy_router"
echo "---------------------------------"
if ! node dex deploy_router; then
  echo "Error: Command 'node dex deploy_router' failed."
  exit 1
fi

# Execute node dex create_tokens
echo -e "\nExecuting: node dex create_tokens"
echo "---------------------------------"
if ! node dex create_tokens --number 1 --user_address_target 000079F989087E923C9CF084757E6F0F69A45C7680F29ABF7E8CF81116102EC924E3; then
  echo "Error: Command 'node dex create_tokens' failed."
  exit 1
fi

# Execute node dex deploy_pool
echo -e "\nExecuting: node dex deploy_pool"
echo "-------------------------------"
if ! node dex deploy_pool --token1 UCO --token2 token0 --token1_amount 500000 --token2_amount 2 --pool_seed pool_seed; then
  echo "Error: Command 'node dex deploy_pool' failed."
  exit 1
fi

# Execute node dex deploy_farm
echo -e "\nExecuting: node dex deploy_farm (lock)"
echo "-------------------------------"
if ! node dex deploy_farm --lp_token 00003DEAF4054179128208CA953B3B8171B739ACF0C549789AAE79041287C79D7DC6  --reward_token UCO --reward_token_amount 87500000 --start_date 1721044547 --end_date 1782972129 --farm_type 2 --farm_seed farm_lock_seed; then
  echo "Error: Command 'node dex deploy_farm' failed."
  exit 1
fi

# Execute node dex deploy_farm
echo -e "\nExecuting: node dex deploy_farm (legacy)"
if ! node dex deploy_farm --lp_token 00003DEAF4054179128208CA953B3B8171B739ACF0C549789AAE79041287C79D7DC6  --reward_token UCO --reward_token_amount 2500000 --start_date 1721044547 --end_date 1782972129 --farm_type 1 --farm_seed farm_legacy_seed; then
  echo "Error: Command 'node dex deploy_farm' failed."
  exit 1
fi

echo "Commands executed successfully."
