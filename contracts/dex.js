#!/usr/bin/env node

import yargs from 'yargs'
import { hideBin } from 'yargs/helpers'

import create_tokens from './commands/test/create_tokens.js'
import deploy_pool from './commands/test/deploy_pool.js'
import add_liquidity from './commands/test/add_liquidity.js'
import remove_liquidity from './commands/test/remove_liquidity.js'
import swap from './commands/test/swap.js'

const y = yargs(hideBin(process.argv))

y.command(create_tokens).help()
y.command(deploy_pool).help()
y.command(add_liquidity).help()
y.command(remove_liquidity).help()
y.command(swap).help()

y.parse()
