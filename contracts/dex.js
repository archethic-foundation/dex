#!/usr/bin/env node

import yargs from 'yargs'
import { hideBin } from 'yargs/helpers'

import init_keychain from './commands/contract_management/init_keychain.js'
import deploy_factory from './commands/contract_management/deploy_factory.js'
import deploy_router from './commands/contract_management/deploy_router.js'
import update_router from './commands/contract_management/update_router.js'
import update_pools from './commands/contract_management/update_pools.js'
import update_farms from './commands/contract_management/update_farms.js'
import update_protocol_fee from './commands/contract_management/update_protocol_fee.js'
import update_farm_dates from './commands/contract_management/update_farm_dates.js'

import create_user_wallet from './commands/test/create_user_wallet.js'
import create_tokens from './commands/test/create_tokens.js'
import deploy_pool from './commands/test/deploy_pool.js'
import add_liquidity from './commands/test/add_liquidity.js'
import remove_liquidity from './commands/test/remove_liquidity.js'
import swap from './commands/test/swap.js'

import deploy_farm from './commands/test/deploy_farm.js'
import deposit from './commands/test/deposit.js'
import claim from './commands/test/claim.js'
import withdraw from './commands/test/withdraw.js'

const y = yargs(hideBin(process.argv))

y.command(init_keychain).help()
y.command(deploy_factory).help()
y.command(deploy_router).help()
y.command(update_router).help()
y.command(update_pools).help()
y.command(update_farms).help()
y.command(update_protocol_fee).help()
y.command(update_farm_dates).help()

y.command(create_user_wallet).help()

y.command(create_tokens).help()
y.command(deploy_pool).help()
y.command(add_liquidity).help()
y.command(remove_liquidity).help()
y.command(swap).help()

y.command(deploy_farm).help()
y.command(deposit).help()
y.command(claim).help()
y.command(withdraw).help()

y.parse()
