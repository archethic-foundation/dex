#!/bin/bash


# Execute node dex create_user_wallet
# WARNING !!!!!!! Seed : Not use in testnet nor mainnet environment - ONLY devnet / localhost
# orient clog surface flat clever pizza damage nest squeeze chapter main annual another pill history robot payment course hint knock call this erode tiger
# 9C857368AC42A94B4DC4A4D384CE1904B099499B0DD9A1A629AF3DE207C19327
echo -e "\nExecuting: node dex create_user_wallet"
echo "--------------------------------------"
node dex create_user_wallet --access_seed 9C857368AC42A94B4DC4A4D384CE1904B099499B0DD9A1A629AF3DE207C19327 --service_name archethic-wallet-BOB

# Check if last command is ok
if [ $? -ne 0 ]; then
  echo "Error: Command 'node dex create_user_wallet' failed."
  exit 1
fi

# Execute node dex init_keychain
echo -e "\nExecuting: node dex init_keychain"
echo "---------------------------------"
node dex init_keychain

# Check if last command is ok
if [ $? -ne 0 ]; then
  echo "Error: Command 'node dex init_keychain' failed."
  exit 1
fi

# Execute node dex deploy_factory
echo -e "\nExecuting: node dex deploy_factory"
echo "----------------------------------"
node dex deploy_factory

# Check if last command is ok
if [ $? -ne 0 ]; then
  echo "Error: Command 'node dex deploy_factory' failed."
  exit 1
fi

# Execute node dex deploy_router
echo -e "\nExecuting: node dex deploy_router"
echo "---------------------------------"
node dex deploy_router

# Check if last command is ok
if [ $? -ne 0 ]; then
  echo "Error: Command 'node dex deploy_router' failed."
  exit 1
fi

# Execute node dex create_tokens
echo -e "\nExecuting: node dex create_tokens"
echo "---------------------------------"
node dex create_tokens --number 1 --user_address_target 000079F989087E923C9CF084757E6F0F69A45C7680F29ABF7E8CF81116102EC924E3 

# Check if last command is ok
if [ $? -ne 0 ]; then
  echo "Error: Command 'node dex create_tokens' failed."
  exit 1
fi

# Execute node dex deploy_pool
echo -e "\nExecuting: node dex deploy_pool"
echo "-------------------------------"
node dex deploy_pool --token1 UCO --token2 token0 --token1_amount 500000 --token2_amount 2 --pool_seed pool_seed

# Check if last command is ok
if [ $? -ne 0 ]; then
  echo "Error: Command 'node dex deploy_pool' failed."
  exit 1
fi

# Execute node dex deploy_farm
echo -e "\nExecuting: node dex deploy_farm (lock)"
echo "-------------------------------"
node dex deploy_farm --lp_token 00003DEAF4054179128208CA953B3B8171B739ACF0C549789AAE79041287C79D7DC6  --reward_token UCO --reward_token_amount 87500000 --end_date 1782972129 --farm_type 2 --farm_seed farm_lock_seed

# Check if last command is ok
if [ $? -ne 0 ]; then
  echo "Error: Command 'node dex deploy_farm' failed."
  exit 1
fi

# Execute node dex deploy_farm
echo -e "\nExecuting: node dex deploy_farm (legacy)"
node dex deploy_farm --lp_token 00003DEAF4054179128208CA953B3B8171B739ACF0C549789AAE79041287C79D7DC6  --reward_token UCO --reward_token_amount 2500000 --end_date 1782972129 --farm_type 1 --farm_seed farm_legacy_seed

# Check if last command is ok
if [ $? -ne 0 ]; then
  echo "Error: Command 'node dex deploy_farm' failed."
  exit 1
fi

echo "Commands executed successfully."
