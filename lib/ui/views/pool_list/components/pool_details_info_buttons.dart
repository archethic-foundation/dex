import 'dart:convert';

import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PoolDetailsInfoButtons extends ConsumerWidget {
  const PoolDetailsInfoButtons({
    super.key,
    required this.pool,
    required this.tab,
  });

  final DexPool pool;
  final PoolsListTab tab;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    if (aedappfm.Responsive.isDesktop(context) ||
        aedappfm.Responsive.isTablet(context)) {
      return Column(
        children: [
          _swapButton(context, pool),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: _addLiquidityButton(context, ref, pool),
              ),
              Expanded(
                child: _removeLiquidityButton(context, ref, pool),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _swapButton(context, pool),
          const SizedBox(
            height: 10,
          ),
          _addLiquidityButton(context, ref, pool),
          const SizedBox(
            height: 10,
          ),
          _removeLiquidityButton(context, ref, pool),
        ],
      );
    }
  }

  Widget _swapButton(BuildContext context, DexPool pool) {
    return aedappfm.AppButton(
      background: aedappfm.ArchethicThemeBase.purple500,
      labelBtn: AppLocalizations.of(context)!.poolDetailsInfoButtonSwap,
      onPressed: () {
        final tokenToSwapJson = jsonEncode(pool.pair.token1.toJson());
        final tokenSwappedJson = jsonEncode(pool.pair.token2.toJson());
        final tokenToSwapEncoded = Uri.encodeComponent(tokenToSwapJson);
        final tokenSwappedEncoded = Uri.encodeComponent(tokenSwappedJson);

        context.go(
          Uri(
            path: SwapSheet.routerPage,
            queryParameters: {
              'tokenToSwap': tokenToSwapEncoded,
              'tokenSwapped': tokenSwappedEncoded,
            },
          ).toString(),
        );
      },
    );
  }

  Widget _addLiquidityButton(
    BuildContext context,
    WidgetRef ref,
    DexPool pool,
  ) {
    return aedappfm.ButtonValidate(
      background: aedappfm.ArchethicThemeBase.purple500,
      controlOk: true,
      labelBtn: AppLocalizations.of(context)!.poolDetailsInfoButtonAddLiquidity,
      onPressed: () {
        final poolJson = jsonEncode(pool.toJson());
        final pairJson = jsonEncode(pool.pair.toJson());
        final poolEncoded = Uri.encodeComponent(poolJson);
        final pairEncoded = Uri.encodeComponent(pairJson);
        final poolsListTabEncoded = Uri.encodeComponent(tab.name);
        context.go(
          Uri(
            path: LiquidityAddSheet.routerPage,
            queryParameters: {
              'pool': poolEncoded,
              'pair': pairEncoded,
              'tab': poolsListTabEncoded,
            },
          ).toString(),
        );
      },
      isConnected: ref.watch(SessionProviders.session).isConnected,
      displayWalletConnectOnPressed: () async {
        final sessionNotifier = ref.read(SessionProviders.session.notifier);
        await sessionNotifier.connectToWallet();

        final session = ref.read(SessionProviders.session);
        if (session.error.isNotEmpty) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
              content: SelectableText(
                session.error,
                style: Theme.of(context).snackBarTheme.contentTextStyle,
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          if (!context.mounted) return;
          context.go(
            '/',
          );
        }
      },
    );
  }

  Widget _removeLiquidityButton(
    BuildContext context,
    WidgetRef ref,
    DexPool pool,
  ) {
    return aedappfm.ButtonValidate(
      background: aedappfm.ArchethicThemeBase.purple500,
      controlOk: pool.lpTokenInUserBalance,
      labelBtn:
          AppLocalizations.of(context)!.poolDetailsInfoButtonRemoveLiquidity,
      onPressed: () {
        final poolJson = jsonEncode(pool.toJson());
        final pairJson = jsonEncode(pool.pair.toJson());
        final lpTokenJson = jsonEncode(pool.lpToken.toJson());
        final poolEncoded = Uri.encodeComponent(poolJson);
        final pairEncoded = Uri.encodeComponent(pairJson);
        final lpTokenEncoded = Uri.encodeComponent(lpTokenJson);
        final poolsListTabEncoded = Uri.encodeComponent(tab.name);
        context.go(
          Uri(
            path: LiquidityRemoveSheet.routerPage,
            queryParameters: {
              'pool': poolEncoded,
              'pair': pairEncoded,
              'lpToken': lpTokenEncoded,
              'tab': poolsListTabEncoded,
            },
          ).toString(),
        );
      },
      isConnected: ref.watch(SessionProviders.session).isConnected,
      displayWalletConnectOnPressed: () async {
        final sessionNotifier = ref.read(SessionProviders.session.notifier);
        await sessionNotifier.connectToWallet();

        final session = ref.read(SessionProviders.session);
        if (session.error.isNotEmpty) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
              content: SelectableText(
                session.error,
                style: Theme.of(context).snackBarTheme.contentTextStyle,
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          if (!context.mounted) return;
          context.go(
            '/',
          );
        }
      },
    );
  }
}
