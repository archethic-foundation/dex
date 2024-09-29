import 'dart:convert';

import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/error/layouts/error_screen.dart';
import 'package:aedex/ui/views/farm_claim/layouts/farm_claim_sheet.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/farm_deposit_sheet.dart';
import 'package:aedex/ui/views/farm_list/layouts/farm_list_sheet.dart';
import 'package:aedex/ui/views/farm_lock/layouts/farm_lock_sheet.dart';
import 'package:aedex/ui/views/farm_lock_claim/layouts/farm_lock_claim_sheet.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/farm_lock_deposit_sheet.dart';
import 'package:aedex/ui/views/farm_lock_level_up/layouts/farm_lock_level_up_sheet.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/layouts/farm_lock_withdraw_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/farm_withdraw_sheet.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/notifications/layouts/tasks_notification_widget.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/layouts/pool_list_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
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
                final tokenToSwap =
                    state.uri.queryParameters.getDecodedParameter(
                  'tokenToSwap',
                  (json) => DexToken.fromJson(jsonDecode(json)),
                );
                final tokenSwapped =
                    state.uri.queryParameters.getDecodedParameter(
                  'tokenSwapped',
                  (json) => DexToken.fromJson(jsonDecode(json)),
                );

                final from = state.uri.queryParameters['from'];
                final to = state.uri.queryParameters['to'];
                final value = state.uri.queryParameters['value'] != null &&
                        state.uri.queryParameters['value']!.isValidNumber()
                    ? double.tryParse(
                        state.uri.queryParameters['value']!,
                      )
                    : null;

                return NoTransitionPage(
                  child: SwapSheet(
                    tokenToSwap: tokenToSwap,
                    tokenSwapped: tokenSwapped,
                    from: from,
                    to: to,
                    value: value,
                  ),
                );
              },
            ),
            GoRoute(
              path: '/',
              redirect: (context, state) => null,
            ),
            GoRoute(
              path: PoolListSheet.routerPage,
              pageBuilder: (context, state) {
                var tab = PoolsListTab.verified;
                final tabParam = state.uri.queryParameters['tab'];
                if (tabParam != null) {
                  switch (tabParam) {
                    case 'favoritePools':
                      tab = PoolsListTab.favoritePools;
                      break;
                    case 'myPools':
                      tab = PoolsListTab.myPools;
                      break;
                    case 'searchPool':
                      tab = PoolsListTab.searchPool;
                      break;
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
              path: FarmLockSheet.routerPage2,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: FarmLockSheet(),
                );
              },
            ),
            GoRoute(
              path: FarmLockSheet.routerPage,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: FarmLockSheet(),
                );
              },
            ),
            GoRoute(
              path: PoolAddSheet.routerPage,
              pageBuilder: (context, state) {
                final token1 = state.uri.queryParameters.getDecodedParameter(
                  'token1',
                  (json) => DexToken.fromJson(jsonDecode(json)),
                );
                final token2 = state.uri.queryParameters.getDecodedParameter(
                  'token2',
                  (json) => DexToken.fromJson(jsonDecode(json)),
                );
                final poolsListTab =
                    state.uri.queryParameters.getDecodedParameter(
                  'tab',
                  (json) => poolsListTabFromJson(Uri.decodeComponent(json)),
                );

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
                final pool = state.uri.queryParameters.getDecodedParameter(
                  'pool',
                  (json) => DexPool.fromJson(jsonDecode(json)),
                );
                final poolsListTab =
                    state.uri.queryParameters.getDecodedParameter(
                  'tab',
                  (json) => poolsListTabFromJson(Uri.decodeComponent(json)),
                );

                if (pool == null) {
                  return const NoTransitionPage(
                    child: PoolListSheet(),
                  );
                }

                return NoTransitionPage(
                  child: LiquidityAddSheet(
                    pool: pool,
                    poolsListTab: poolsListTab ?? PoolsListTab.verified,
                  ),
                );
              },
            ),
            GoRoute(
              path: LiquidityRemoveSheet.routerPage,
              pageBuilder: (context, state) {
                final pool = state.uri.queryParameters.getDecodedParameter(
                  'pool',
                  (json) => DexPool.fromJson(jsonDecode(json)),
                );
                final pair = state.uri.queryParameters.getDecodedParameter(
                  'pair',
                  (json) => DexPair.fromJson(jsonDecode(json)),
                );
                final lpToken = state.uri.queryParameters.getDecodedParameter(
                  'lpToken',
                  (json) => DexToken.fromJson(jsonDecode(json)),
                );
                final poolsListTab =
                    state.uri.queryParameters.getDecodedParameter(
                  'tab',
                  (json) => poolsListTabFromJson(Uri.decodeComponent(json)),
                );

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
              path: FarmLockDepositSheet.routerPage,
              pageBuilder: (context, state) {
                final pool = state.uri.queryParameters.getDecodedParameter(
                  'pool',
                  (json) => DexPool.fromJson(jsonDecode(json)),
                );
                final farmLock = state.uri.queryParameters.getDecodedParameter(
                  'farmLock',
                  (json) => DexFarmLock.fromJson(jsonDecode(json)),
                );

                if (pool == null || farmLock == null) {
                  return const NoTransitionPage(
                    child: PoolListSheet(),
                  );
                }

                return NoTransitionPage(
                  child: FarmLockDepositSheet(
                    pool: pool,
                    farmLock: farmLock,
                  ),
                );
              },
            ),
            GoRoute(
              path: FarmLockLevelUpSheet.routerPage,
              pageBuilder: (context, state) {
                final pool = state.uri.queryParameters.getDecodedParameter(
                  'pool',
                  (json) => DexPool.fromJson(jsonDecode(json)),
                );
                final farmLock = state.uri.queryParameters.getDecodedParameter(
                  'farmLock',
                  (json) => DexFarmLock.fromJson(jsonDecode(json)),
                );
                final depositId = state.uri.queryParameters.getDecodedParameter(
                  'depositId',
                  jsonDecode,
                );
                final currentLevel =
                    state.uri.queryParameters.getDecodedParameter(
                  'currentLevel',
                  jsonDecode,
                );
                final lpAmount = state.uri.queryParameters.getDecodedParameter(
                  'lpAmount',
                  jsonDecode,
                );
                final rewardAmount =
                    state.uri.queryParameters.getDecodedParameter(
                  'rewardAmount',
                  jsonDecode,
                );

                if (pool == null ||
                    farmLock == null ||
                    depositId == null ||
                    currentLevel == null ||
                    lpAmount == null ||
                    rewardAmount == null) {
                  return const NoTransitionPage(
                    child: PoolListSheet(),
                  );
                }

                return NoTransitionPage(
                  child: FarmLockLevelUpSheet(
                    pool: pool,
                    farmLock: farmLock,
                    depositId: depositId,
                    currentLevel: currentLevel,
                    lpAmount: lpAmount,
                    rewardAmount: rewardAmount,
                  ),
                );
              },
            ),
            GoRoute(
              path: FarmDepositSheet.routerPage,
              pageBuilder: (context, state) {
                final farmAddress =
                    state.uri.queryParameters.getDecodedParameter(
                  'farmAddress',
                  jsonDecode,
                );
                final poolAddress =
                    state.uri.queryParameters.getDecodedParameter(
                  'poolAddress',
                  jsonDecode,
                );

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
                final farmAddress =
                    state.uri.queryParameters.getDecodedParameter(
                  'farmAddress',
                  jsonDecode,
                );
                final poolAddress =
                    state.uri.queryParameters.getDecodedParameter(
                  'poolAddress',
                  jsonDecode,
                );
                final rewardToken =
                    state.uri.queryParameters.getDecodedParameter(
                  'rewardToken',
                  (json) => DexToken.fromJson(jsonDecode(json)),
                );
                final lpTokenAddress =
                    state.uri.queryParameters.getDecodedParameter(
                  'lpTokenAddress',
                  jsonDecode,
                );
                final rewardAmount =
                    state.uri.queryParameters.getDecodedParameter(
                  'rewardAmount',
                  jsonDecode,
                );

                if (farmAddress == null ||
                    poolAddress == null ||
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
                    poolAddress: poolAddress,
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
                final farmAddress =
                    state.uri.queryParameters.getDecodedParameter(
                  'farmAddress',
                  jsonDecode,
                );
                final rewardToken =
                    state.uri.queryParameters.getDecodedParameter(
                  'rewardToken',
                  (json) => DexToken.fromJson(jsonDecode(json)),
                );
                final lpTokenAddress =
                    state.uri.queryParameters.getDecodedParameter(
                  'lpTokenAddress',
                  jsonDecode,
                );
                final poolAddress =
                    state.uri.queryParameters.getDecodedParameter(
                  'poolAddress',
                  jsonDecode,
                );

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
            GoRoute(
              path: FarmLockClaimSheet.routerPage,
              pageBuilder: (context, state) {
                final farmAddress = state.uri.queryParameters
                    .getDecodedParameter('farmAddress', jsonDecode);
                final poolAddress = state.uri.queryParameters
                    .getDecodedParameter('poolAddress', jsonDecode);

                final rewardToken =
                    state.uri.queryParameters.getDecodedParameter(
                  'rewardToken',
                  (json) => DexToken.fromJson(jsonDecode(json)),
                );
                final lpTokenAddress = state.uri.queryParameters
                    .getDecodedParameter('lpTokenAddress', jsonDecode);
                final rewardAmount = state.uri.queryParameters
                    .getDecodedParameter('rewardAmount', jsonDecode);
                final depositId = state.uri.queryParameters
                    .getDecodedParameter('depositId', jsonDecode);

                if (farmAddress == null ||
                    poolAddress == null ||
                    rewardToken == null ||
                    lpTokenAddress == null ||
                    rewardAmount == null ||
                    depositId == null) {
                  return const NoTransitionPage(
                    child: FarmLockSheet(),
                  );
                }

                return NoTransitionPage(
                  child: FarmLockClaimSheet(
                    farmAddress: farmAddress,
                    poolAddress: poolAddress,
                    rewardToken: rewardToken,
                    lpTokenAddress: lpTokenAddress,
                    rewardAmount: rewardAmount,
                    depositId: depositId,
                  ),
                );
              },
            ),
            GoRoute(
              path: FarmLockWithdrawSheet.routerPage,
              pageBuilder: (context, state) {
                final farmAddress = state.uri.queryParameters
                    .getDecodedParameter('farmAddress', jsonDecode);
                final poolAddress = state.uri.queryParameters
                    .getDecodedParameter('poolAddress', jsonDecode);
                final rewardToken =
                    state.uri.queryParameters.getDecodedParameter(
                  'rewardToken',
                  (json) => DexToken.fromJson(jsonDecode(json)),
                );
                final lpToken = state.uri.queryParameters.getDecodedParameter(
                  'lpToken',
                  (json) => DexToken.fromJson(jsonDecode(json)),
                );
                final lpTokenPair =
                    state.uri.queryParameters.getDecodedParameter(
                  'lpTokenPair',
                  (json) => DexPair.fromJson(jsonDecode(json)),
                );
                final rewardAmount = state.uri.queryParameters
                    .getDecodedParameter('rewardAmount', jsonDecode);
                final depositedAmount = state.uri.queryParameters
                    .getDecodedParameter('depositedAmount', jsonDecode);
                final depositId = state.uri.queryParameters
                    .getDecodedParameter('depositId', jsonDecode);
                final endDate = state.uri.queryParameters
                    .getDecodedParameter('endDate', jsonDecode);
                if (farmAddress == null ||
                    poolAddress == null ||
                    rewardToken == null ||
                    lpToken == null ||
                    lpTokenPair == null ||
                    rewardAmount == null ||
                    depositedAmount == null ||
                    depositId == null ||
                    endDate == null) {
                  return const NoTransitionPage(
                    child: FarmLockSheet(),
                  );
                }

                return NoTransitionPage(
                  child: FarmLockWithdrawSheet(
                    farmAddress: farmAddress,
                    poolAddress: poolAddress,
                    rewardToken: rewardToken,
                    lpToken: lpToken,
                    lpTokenPair: lpTokenPair,
                    endDate: DateTime.fromMillisecondsSinceEpoch(
                      endDate * 1000,
                    ),
                    rewardAmount: rewardAmount,
                    depositId: depositId,
                    depositedAmount: depositedAmount,
                  ),
                );
              },
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const ErrorScreen(),
    );
  },
);

extension RouterParamExtension on Object? {
  String? encodeParam() {
    if (this == null) return null;
    final paramJson = jsonEncode(this);
    return Uri.encodeComponent(paramJson);
  }
}

extension UriExtensions on Map<String, String> {
  T? getDecodedParameter<T>(String key, T Function(String) fromJson) {
    final encoded = this[key];
    if (encoded != null) {
      final json = Uri.decodeComponent(encoded);
      return fromJson(json);
    }
    return null;
  }
}

extension ContextRouteExtension on BuildContext {
  void popOrGo(String routerPage) {
    if (canPop()) {
      pop();
    } else {
      go(routerPage);
    }
  }
}
