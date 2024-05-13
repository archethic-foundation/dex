import 'dart:convert';

import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/infrastructure/hive/preferences.hive.dart';
import 'package:aedex/ui/views/farm_claim/layouts/farm_claim_sheet.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/farm_deposit_sheet.dart';
import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/farm_withdraw_sheet.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/notifications/layouts/tasks_notification_widget.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: SwapSheet.routerPage,
      debugLogDiagnostics: true,
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return TasksNotificationWidget(child: child);
          },
          routes: [
            GoRoute(
              path: SwapSheet.routerPage,
              pageBuilder: (context, state) {
                DexToken? tokenToSwap;
                DexToken? tokenSwapped;
                final tokenToSwapEncoded =
                    state.uri.queryParameters['tokenToSwap'];
                final tokenSwappedEncoded =
                    state.uri.queryParameters['tokenSwapped'];
                if (tokenToSwapEncoded != null) {
                  final tokenToSwapJson =
                      Uri.decodeComponent(tokenToSwapEncoded);
                  tokenToSwap = DexToken.fromJson(jsonDecode(tokenToSwapJson));
                }
                if (tokenSwappedEncoded != null) {
                  final tokenSwappedJson =
                      Uri.decodeComponent(tokenSwappedEncoded);
                  tokenSwapped =
                      DexToken.fromJson(jsonDecode(tokenSwappedJson));
                }
                return NoTransitionPage(
                  child: SwapSheet(
                    tokenToSwap: tokenToSwap,
                    tokenSwapped: tokenSwapped,
                  ),
                );
              },
            ),
            GoRoute(
              path: '/',
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: SwapSheet(),
                );
              },
            ),
            GoRoute(
              path: PoolListSheet.routerPage,
              pageBuilder: (context, state) {
                var tab = PoolsListTab.verified;
                if (state.uri.queryParameters['tab'] != null) {
                  if (state.uri.queryParameters['tab'] ==
                      PoolsListTab.favoritePools.name) {
                    tab = PoolsListTab.favoritePools;
                  } else {
                    if (state.uri.queryParameters['tab'] ==
                        PoolsListTab.myPools.name) {
                      tab = PoolsListTab.myPools;
                    } else {
                      if (state.uri.queryParameters['tab'] ==
                          PoolsListTab.searchPool.name) {
                        tab = PoolsListTab.searchPool;
                      }
                    }
                  }
                }

                return NoTransitionPage(
                  child: PoolListSheet(tab: tab),
                );
              },
            ),
            GoRoute(
              path: FarmListSheet.routerPage,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: FarmListSheet(),
                );
              },
            ),
            GoRoute(
              path: PoolAddSheet.routerPage,
              pageBuilder: (context, state) {
                DexToken? token1;
                DexToken? token2;
                PoolsListTab? poolsListTab;
                final token1Encoded = state.uri.queryParameters['token1'];
                final token2Encoded = state.uri.queryParameters['token2'];
                final poolsListTabEncoded = state.uri.queryParameters['tab'];
                if (token1Encoded != null) {
                  final token1Json = Uri.decodeComponent(token1Encoded);
                  token1 = DexToken.fromJson(jsonDecode(token1Json));
                }
                if (token2Encoded != null) {
                  final token2Json = Uri.decodeComponent(token2Encoded);
                  token2 = DexToken.fromJson(jsonDecode(token2Json));
                }
                if (poolsListTabEncoded != null) {
                  poolsListTab = poolsListTabFromJson(
                    Uri.decodeComponent(poolsListTabEncoded),
                  );
                }
                return NoTransitionPage(
                  child: PoolAddSheet(
                    token1: token1,
                    token2: token2,
                    poolsListTab: poolsListTab ?? PoolsListTab.verified,
                  ),
                );
              },
            ),
            GoRoute(
              path: LiquidityAddSheet.routerPage,
              pageBuilder: (context, state) {
                DexPool? pool;
                DexPair? pair;
                PoolsListTab? poolsListTab;
                final poolEncoded = state.uri.queryParameters['pool'];
                final pairEncoded = state.uri.queryParameters['pair'];
                final poolsListTabEncoded = state.uri.queryParameters['tab'];
                if (poolEncoded != null) {
                  final poolJson = Uri.decodeComponent(poolEncoded);
                  pool = DexPool.fromJson(jsonDecode(poolJson));
                }
                if (pairEncoded != null) {
                  final pairJson = Uri.decodeComponent(pairEncoded);
                  pair = DexPair.fromJson(jsonDecode(pairJson));
                }
                if (poolsListTabEncoded != null) {
                  poolsListTab = poolsListTabFromJson(
                    Uri.decodeComponent(poolsListTabEncoded),
                  );
                }

                if (pool == null || pair == null) {
                  return const NoTransitionPage(
                    child: PoolListSheet(),
                  );
                }

                return NoTransitionPage(
                  child: LiquidityAddSheet(
                    pool: pool,
                    pair: pair,
                    poolsListTab: poolsListTab ?? PoolsListTab.verified,
                  ),
                );
              },
            ),
            GoRoute(
              path: LiquidityRemoveSheet.routerPage,
              pageBuilder: (context, state) {
                DexPool? pool;
                DexPair? pair;
                DexToken? lpToken;
                PoolsListTab? poolsListTab;
                final poolEncoded = state.uri.queryParameters['pool'];
                final pairEncoded = state.uri.queryParameters['pair'];
                final lpTokenEncoded = state.uri.queryParameters['lpToken'];
                final poolsListTabEncoded = state.uri.queryParameters['tab'];
                if (poolEncoded != null) {
                  final poolJson = Uri.decodeComponent(poolEncoded);
                  pool = DexPool.fromJson(jsonDecode(poolJson));
                }
                if (pairEncoded != null) {
                  final pairJson = Uri.decodeComponent(pairEncoded);
                  pair = DexPair.fromJson(jsonDecode(pairJson));
                }
                if (lpTokenEncoded != null) {
                  final lpTokenJson = Uri.decodeComponent(lpTokenEncoded);
                  lpToken = DexToken.fromJson(jsonDecode(lpTokenJson));
                }
                if (poolsListTabEncoded != null) {
                  poolsListTab = poolsListTabFromJson(
                    Uri.decodeComponent(poolsListTabEncoded),
                  );
                }

                if (pool == null || pair == null || lpToken == null) {
                  return const NoTransitionPage(
                    child: PoolListSheet(),
                  );
                }

                return NoTransitionPage(
                  child: LiquidityRemoveSheet(
                    pool: pool,
                    pair: pair,
                    lpToken: lpToken,
                    poolsListTab: poolsListTab ?? PoolsListTab.verified,
                  ),
                );
              },
            ),
            GoRoute(
              path: FarmDepositSheet.routerPage,
              pageBuilder: (context, state) {
                String? farmAddress;
                String? poolAddress;
                final farmAddressEncoded =
                    state.uri.queryParameters['farmAddress'];
                if (farmAddressEncoded != null) {
                  final farmAddressJson =
                      Uri.decodeComponent(farmAddressEncoded);
                  farmAddress = jsonDecode(farmAddressJson);
                }

                final poolAddressEncoded =
                    state.uri.queryParameters['poolAddress'];
                if (poolAddressEncoded != null) {
                  final poolAddressJson =
                      Uri.decodeComponent(poolAddressEncoded);
                  poolAddress = jsonDecode(poolAddressJson);
                }

                if (farmAddress == null || poolAddress == null) {
                  return const NoTransitionPage(
                    child: FarmListSheet(),
                  );
                }
                return NoTransitionPage(
                  child: FarmDepositSheet(
                    farmAddress: farmAddress,
                    poolAddress: poolAddress,
                  ),
                );
              },
            ),
            GoRoute(
              path: FarmClaimSheet.routerPage,
              pageBuilder: (context, state) {
                String? farmAddress;
                DexToken? rewardToken;
                String? lpTokenAddress;
                double? rewardAmount;

                final farmAddressEncoded =
                    state.uri.queryParameters['farmAddress'];
                if (farmAddressEncoded != null) {
                  final farmAddressJson =
                      Uri.decodeComponent(farmAddressEncoded);
                  farmAddress = jsonDecode(farmAddressJson);
                }

                final rewardTokenEncoded =
                    state.uri.queryParameters['rewardToken'];
                if (rewardTokenEncoded != null) {
                  final rewardTokenJson =
                      Uri.decodeComponent(rewardTokenEncoded);
                  rewardToken = DexToken.fromJson(jsonDecode(rewardTokenJson));
                }

                final lpTokenAddressEncoded =
                    state.uri.queryParameters['lpTokenAddress'];
                if (lpTokenAddressEncoded != null) {
                  final lpTokenAddressJson =
                      Uri.decodeComponent(lpTokenAddressEncoded);
                  lpTokenAddress = jsonDecode(lpTokenAddressJson);
                }

                final rewardAmountEncoded =
                    state.uri.queryParameters['rewardAmount'];
                if (rewardAmountEncoded != null) {
                  final rewardAmountJson =
                      Uri.decodeComponent(rewardAmountEncoded);
                  rewardAmount = jsonDecode(rewardAmountJson);
                }

                if (farmAddress == null ||
                    rewardToken == null ||
                    lpTokenAddress == null ||
                    rewardAmount == null) {
                  return const NoTransitionPage(
                    child: FarmListSheet(),
                  );
                }

                return NoTransitionPage(
                  child: FarmClaimSheet(
                    farmAddress: farmAddress,
                    rewardToken: rewardToken,
                    lpTokenAddress: lpTokenAddress,
                    rewardAmount: rewardAmount,
                  ),
                );
              },
            ),
            GoRoute(
              path: FarmWithdrawSheet.routerPage,
              pageBuilder: (context, state) {
                String? farmAddress;
                DexToken? rewardToken;
                String? lpTokenAddress;
                String? poolAddress;
                final farmAddressEncoded =
                    state.uri.queryParameters['farmAddress'];
                if (farmAddressEncoded != null) {
                  final farmAddressJson =
                      Uri.decodeComponent(farmAddressEncoded);
                  farmAddress = jsonDecode(farmAddressJson);
                }

                final rewardTokenEncoded =
                    state.uri.queryParameters['rewardToken'];
                if (rewardTokenEncoded != null) {
                  final rewardTokenJson =
                      Uri.decodeComponent(rewardTokenEncoded);
                  rewardToken = DexToken.fromJson(jsonDecode(rewardTokenJson));
                }

                final lpTokenAddressEncoded =
                    state.uri.queryParameters['lpTokenAddress'];
                if (lpTokenAddressEncoded != null) {
                  final lpTokenAddressJson =
                      Uri.decodeComponent(lpTokenAddressEncoded);
                  lpTokenAddress = jsonDecode(lpTokenAddressJson);
                }

                final poolAddressEncoded =
                    state.uri.queryParameters['poolAddress'];
                if (poolAddressEncoded != null) {
                  final poolAddressJson =
                      Uri.decodeComponent(poolAddressEncoded);
                  poolAddress = jsonDecode(poolAddressJson);
                }

                if (farmAddress == null ||
                    rewardToken == null ||
                    lpTokenAddress == null ||
                    poolAddress == null) {
                  return const NoTransitionPage(
                    child: FarmListSheet(),
                  );
                }

                return NoTransitionPage(
                  child: FarmWithdrawSheet(
                    farmAddress: farmAddress,
                    rewardToken: rewardToken,
                    lpTokenAddress: lpTokenAddress,
                    poolAddress: poolAddress,
                  ),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: WelcomeScreen.routerPage,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(
              child: WelcomeScreen(),
            );
          },
        ),
      ],
      // ignore: body_might_complete_normally_nullable
      redirect: (context, state) async {
        final preferences = await HivePreferencesDatasource.getInstance();
        if (preferences.isFirstConnection()) {
          await preferences.setFirstConnection(false);
          if (context.mounted) return WelcomeScreen.routerPage;
        }

        return null;
      },
      errorBuilder: (context, state) => const WelcomeScreen(),
    );
  },
);
