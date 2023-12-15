[![Platform](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)](https://flutter.dev) [![CodeFactor](https://www.codefactor.io/repository/github/archethic-foundation/dex/badge?s=1cec48d77d18b2abdaffe9a4073be925ec527ba6)](https://www.codefactor.io/repository/github/archethic-foundation/dex)

# AESwap

## Contracts

### Pool

Pool is the main contract of the AMM model. It hold the liquidity of a pair of token and expose all functionnality to add / remove liquidity and swap.

#### Public functions:

```elixir
get_pool_infos()
```
Returns infos of the pool as:

```json
{
  "token1": {
    "address": "00001234...",
    "reserve": 1021.45
  },
  "token2": {
    "address": "00005678...",
    "reserve": 894.565
  },
  "lp_token": {
    "address": "0000ABCD...",
    "supply": 950.45645
  },
  "fee": 0.25
}
```
In next function, token1 and token2 represent the one returned by this function

```elixir
get_equivalent_amount(token_address, amount)
```
Returns the equivalent amount of the other token of the pool. This should be used in the process of adding liquidity
- `token_address` is the token you want to provide (result amount will be the other token)
- `amount` is the amount of token_address you want to provide

```elixir
get_ratio(token_address)
```
Returns the pool ratio
- `token_address` is the token you want to provide (result amount will be the other token)

```elixir
get_lp_token_to_mint(token1_amount, token2_amount)
```
Returns the amount of LP token that will be minted if the amount of tokens are provided
- `token1_amount` Amount of token1 to provide
- `token2_amount` Amount of token2 to provide

```elixir
get_swap_infos(token_address, amount)
```
Returns the info about a swap: expected output_amount, fee and price impact
- `token_address` One of the 2 tokens of the pool
- `amount` Amount of of this token you want to swap

```json
{ "fee": 0.006, "output_amount": 1.48073705, "price_impact": 0.997 }
```

```elixir
get_remove_amounts(lp_token_amount)
```
Returns amounts of token to get back when removing liquidity
- `lp_token_amount` Number of lp token to remove

```json
{ "token1": 11.662465, "token2": 8.54834787 }
```

#### Actions triggered by transaction:

```elixir
add_liquidity(token1_min_amount, token2_min_amount)
```
This action allow user to add liquidity to the pool. User must send tokens to the pool's genesis address. The amounts sent should be equivalent to the pool ratio. User can specify a slippage tolerance by providing the minimum amount by token that the pool can use. If there is more fund sent by the user than the needed liquidity, the excedent is returned to the user. In exchange of the liquidity, the user will receive some LP token.
- `token1_min_amount` is the minimum amount of token1 to add in liquidity
- `token2_min_amount` is the minimum amount of token2 to add in liquidity

```elixir
remove_liquidity()
```
This action allow user to remove the liquidity he previously provided. User must send the lp token he wants to remove to the burn address ("000...000") (don't forget to add the pool in recipient otherwise lp token will only be burned). The pool will calculate the share of the user and return the corresponding amount of both pool tokens.

```elixir
swap(min_to_receive)
```
This action allow user to swap a token of the pool against the other token. User must send the input token to the pool's genesis address. The pool will calculate the output amount and send it to the user. User can specify a slippage tolerance by providing the minimum amount of the output token to receive.
- `min_to_receive` is the minimum amount of the output token to receive

```elixir
update_code()
```
This action can be triggered only by the Router contract of the dex. It allow the Router to request the pool to update it's code. The pool will request the new code using the function `get_pool_code` of the Router (see bellow).

### Router

Router is a helper contract for user to easily retrieve existing pools and create new pools.

#### Public functions:

```elixir
get_pool_code(token1_address, token2_address, pool_address, lp_token_address, state_address)
```
Return the code to create a pool for a pair of tokens.
- `token1_address` is the first token address of the pair
- `token2_address` is the second token address of the pair
- `pool_address` is the genesis address of the pool chain
- `lp_token_address` is the address of the lp token (it should be the creation address of the pool)
- `state_address` is the address holding the state of a pool (will be soon removed)

```elixir
get_lp_token_definition(token1_symbol, token2_symbol)
```
Return a the lp token definition to use when creating a pool. Returns a JSON stringified
- `token1_symbol` is the symbol of the first token
- `token2_symbol` is the symbol of the second token

```elixir
get_pool_addresses(token1_address, token2_address)
```
Returns the info of the pool for the 2 tokens address. Pool infos is a map with `address` as the genesis address of the pool, `lp_token_address` as the lp token address of the pool. (`{"address": "00001234...", "lp_token_address": "00005678..."}`)
- `token1_address` is the address of the first token
- `token2_address` is the address of the second token

```elixir
get_pool_list()
```
Return the infos of all the pools. Pool infos is a map with `address` as the genesis address of the pool, `lp_token_address` as the lp token address of the pool, `tokens` as the address of both token concatenated and separated by a slash. `[{"address": "00001234...", "lp_token_address": "00005678...", "tokens": "0000456.../000789..."}]`
#### Actions triggered by transaction:

```elixir
add_pool(token1_address, token2_address, pool_creation_address)
```
This actions allow users to add a new pool in the router. The transaction triggering this action should also add the first liquidity to a previously created pool. The transaction that created the pool should be a token transaction with the token definition returned by the function `get_lp_token_definition`. It should also have the code returned by the function `get_pool_code`.

```elixir
update_code(new_code)
```
This action can be triggered only by the Master chain of the dex. It's allowing to update the code of the Router.

```elixir
update_pools_code()
```
This action can be triggered only by the Master chain of the dex. It's allowing to update all the pools code. The Router will call the action `update_code()` of all the known pool.

### Helper scripts

In the directory contracts you can find a script dex.js. This script provide the main functionnality to deploy the dex and test it.

```bash
node dex --help

dex [command]

Commands:
  dex init_keychain     Initialize the dex keychain with the primary services
  dex deploy_router     Deploy the router
  dex update_router     Update the router
  dex update_pools      Update all pool code
  dex create_tokens     Create tokens and send them to user address
  dex deploy_pool       Deploy a pool for the token specified
  dex add_liquidity     Add liquidity to a pool
  dex remove_liquidity  Remove liquidity from a pool
  dex swap              Swap exact token for token
```

For each command you can get the help:
```bash
node dex swap --help

dex swap

Swap exact token for token

Options:
  --token1         First token name (token to send)          [string] [required]
  --token2         Second token name (token to receive)      [string] [required]
  --token1_amount  Amount of token to send                            [required]
  --slippage       Slippage in percentage (2 = 2%) to apply. Default 2
```

To deploy the main dex contract you have to init the keychain and deploy the router:
```bash
node dex init_keychain
node dex deploy_router
```
NB: Don't forget to faucet the Master genesis address before executing `node dex deploy_router`

To test the dex you first have to create some tokens, it will create tokens with 1 million supply
```bash
node dex create_tokens --number 6
```
This will create multiple tokens with the name token0, token1, token2 ...

Then you can deploy a pool:
```bash
node dex deploy_pool --token1 token3 --token2 token4 --token1_amount 100 --token2_amount 200
```

Then you can use script to add / remove liquidity or swap:
```bash
node dex add_liquidity --token1 token2 --token1_amount 750 --token2 token3
node dex swap --token1 token2 --token1_amount 50 --token2 token3
node dex remove_liquidity --token1 token2 --token2 token3 --lp_token_amount 72
```

### Security
- Security access with your Archethic Wallet

## Application Initial Screen

### Pre-requisites

- Flutter 3.10+
- Dart 3+

### Note

*** This Application is currently in active development so it might fail to build. Please refer to issues or create new issues if you find any. Contributions are welcomed.






