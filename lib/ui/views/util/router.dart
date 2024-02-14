import 'dart:convert';

import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_user_infos.dart';
import 'package:aedex/domain/models/dex_pair.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/main.dart';
import 'package:aedex/ui/views/farm_claim/layouts/farm_claim_sheet.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/farm_deposit_sheet.dart';
import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/farm_withdraw_sheet.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoutesPath {
  RoutesPath(
    this.rootNavigatorKey,
  );

  final GlobalKey<NavigatorState> rootNavigatorKey;

  GoRouter createRouter() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: true,
      extraCodec: const JsonCodec(),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(
              child: Splash(),
            );
          },
        ),
        GoRoute(
          path: SwapSheet.routerPage,
          pageBuilder: (context, state) {
            var args = <String, dynamic>{};
            if (state.extra != null) {
              args = state.extra! as Map<String, dynamic>;
            }
            return NoTransitionPage(
              child: SwapSheet(
                tokenToSwap: args['tokenToSwap'] == null
                    ? null
                    : args['tokenToSwap']! as DexToken,
                tokenSwapped: args['tokenSwapped'] == null
                    ? null
                    : args['tokenSwapped']! as DexToken,
              ),
            );
          },
        ),
        GoRoute(
          path: PoolListSheet.routerPage,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: PoolListSheet(),
            );
          },
        ),
        GoRoute(
          path: PoolAddSheet.routerPage,
          pageBuilder: (context, state) {
            var args = <String, dynamic>{};
            if (state.extra != null) {
              args = state.extra! as Map<String, dynamic>;
            }
            return NoTransitionPage(
              child: PoolAddSheet(
                token1:
                    args['token1'] == null ? null : args['token1']! as DexToken,
                token2:
                    args['token2'] == null ? null : args['token2']! as DexToken,
              ),
            );
          },
        ),
        GoRoute(
          path: LiquidityAddSheet.routerPage,
          pageBuilder: (context, state) {
            var args = <String, dynamic>{};
            if (state.extra != null) {
              args = state.extra! as Map<String, dynamic>;
            }
            return NoTransitionPage(
              child: LiquidityAddSheet(
                pool: args['pool']! as DexPool,
                pair: args['pair']! as DexPair,
              ),
            );
          },
        ),
        GoRoute(
          path: LiquidityRemoveSheet.routerPage,
          pageBuilder: (context, state) {
            var args = <String, dynamic>{};
            if (state.extra != null) {
              args = state.extra! as Map<String, dynamic>;
            }
            return NoTransitionPage(
              child: LiquidityRemoveSheet(
                pool: args['pool']! as DexPool,
                pair: args['pair']! as DexPair,
                lpToken: args['lpToken']! as DexToken,
              ),
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
          path: FarmDepositSheet.routerPage,
          pageBuilder: (context, state) {
            var args = <String, dynamic>{};
            if (state.extra != null) {
              args = state.extra! as Map<String, dynamic>;
            }
            return NoTransitionPage(
              child: FarmDepositSheet(
                farm: args['farm']! as DexFarm,
              ),
            );
          },
        ),
        GoRoute(
          path: FarmClaimSheet.routerPage,
          pageBuilder: (context, state) {
            var args = <String, dynamic>{};
            if (state.extra != null) {
              args = state.extra! as Map<String, dynamic>;
            }
            return NoTransitionPage(
              child: FarmClaimSheet(
                farmUserInfo: args['farmUserInfo']! as DexFarmUserInfos,
                farm: args['farm']! as DexFarm,
              ),
            );
          },
        ),
        GoRoute(
          path: FarmWithdrawSheet.routerPage,
          pageBuilder: (context, state) {
            var args = <String, dynamic>{};
            if (state.extra != null) {
              args = state.extra! as Map<String, dynamic>;
            }
            return NoTransitionPage(
              child: FarmWithdrawSheet(
                farm: args['farm']! as DexFarm,
              ),
            );
          },
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
      errorBuilder: (context, state) => const Splash(),
    );
  }
}
