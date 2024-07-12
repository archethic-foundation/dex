import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/router/router.dart';
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
    this.tab,
  });

  final DexPool pool;
  final PoolsListTab? tab;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    if (aedappfm.Responsive.isDesktop(context) ||
        aedappfm.Responsive.isTablet(context)) {
      if (tab == null) {
        return Column(
          children: [
            _closeButton(context),
          ],
        );
      }

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
      if (tab == null) {
        return Column(
          children: [
            _closeButton(context),
          ],
        );
      }
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
      backgroundGradient: LinearGradient(
        colors: [
          aedappfm.ArchethicThemeBase.blue400,
          aedappfm.ArchethicThemeBase.blue600,
        ],
      ),
      labelBtn: AppLocalizations.of(context)!.poolDetailsInfoButtonSwap,
      onPressed: () async {
        await context.push(
          Uri(
            path: SwapSheet.routerPage,
            queryParameters: {
              'tokenToSwap': pool.pair.token1.toJson().encodeParam(),
              'tokenSwapped': pool.pair.token2.toJson().encodeParam(),
            },
          ).toString(),
        );
      },
    );
  }

  Widget _closeButton(BuildContext context) {
    return aedappfm.AppButton(
      backgroundGradient: LinearGradient(
        colors: [
          aedappfm.ArchethicThemeBase.blue400,
          aedappfm.ArchethicThemeBase.blue600,
        ],
      ),
      labelBtn: AppLocalizations.of(context)!.btn_close,
      onPressed: () async {
        context.pop();
      },
    );
  }

  Widget _addLiquidityButton(
    BuildContext context,
    WidgetRef ref,
    DexPool pool,
  ) {
    return aedappfm.ButtonValidate(
      controlOk: true,
      labelBtn: AppLocalizations.of(context)!.poolDetailsInfoButtonAddLiquidity,
      onPressed: () async {
        final poolsListTabEncoded = Uri.encodeComponent(tab!.name);
        await context.push(
          Uri(
            path: LiquidityAddSheet.routerPage,
            queryParameters: {
              'pool': pool.toJson().encodeParam(),
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
      controlOk: pool.lpTokenInUserBalance,
      labelBtn:
          AppLocalizations.of(context)!.poolDetailsInfoButtonRemoveLiquidity,
      onPressed: () async {
        final poolsListTabEncoded = Uri.encodeComponent(tab!.name);
        await context.push(
          Uri(
            path: LiquidityRemoveSheet.routerPage,
            queryParameters: {
              'pool': pool.toJson().encodeParam(),
              'pair': pool.pair.toJson().encodeParam(),
              'lpToken': pool.lpToken.toJson().encodeParam(),
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
