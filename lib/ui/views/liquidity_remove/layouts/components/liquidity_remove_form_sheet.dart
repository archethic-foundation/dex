import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_lp_tokens_get_back.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/components/liquidity_remove_textfield_lp_token_amount.dart';
import 'package:aedex/ui/views/util/components/btn_validate_mobile.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/pool_info_card.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LiquidityRemoveFormSheet extends ConsumerWidget {
  const LiquidityRemoveFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove = ref.watch(liquidityRemoveFormNotifierProvider);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SelectionArea(
                    child: SelectableText(
                      AppLocalizations.of(context)!.liquidityRemoveFormTitle,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.titleMedium!,
                            ),
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50,
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: aedappfm.AppThemeBase.gradient,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (liquidityRemove.token1 != null)
                          PoolInfoCard(
                            poolGenesisAddress:
                                liquidityRemove.pool!.poolAddress,
                            tokenAddressRatioPrimary:
                                liquidityRemove.token1!.address == null
                                    ? 'UCO'
                                    : liquidityRemove.token1!.address!,
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        const LiquidityRemoveLPTokenAmount(),
                        const SizedBox(
                          height: 10,
                        ),
                        const LiquidityRemoveTokensGetBack(),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        aedappfm.ErrorMessage(
                          failure: liquidityRemove.failure,
                          failureMessage: FailureMessage(
                            context: context,
                            failure: liquidityRemove.failure,
                          ).getMessage(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ButtonValidateMobile(
                                controlOk: liquidityRemove.isControlsOk,
                                labelBtn: AppLocalizations.of(context)!
                                    .btn_liquidity_remove,
                                onPressed: () => ref
                                    .read(
                                      liquidityRemoveFormNotifierProvider
                                          .notifier,
                                    )
                                    .validateForm(context),
                                isConnected: ref
                                    .watch(sessionNotifierProvider)
                                    .isConnected,
                                displayWalletConnectOnPressed: () async {
                                  final session =
                                      ref.read(sessionNotifierProvider);
                                  if (session.error.isNotEmpty) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Theme.of(context)
                                            .snackBarTheme
                                            .backgroundColor,
                                        content: SelectableText(
                                          session.error,
                                          style: Theme.of(context)
                                              .snackBarTheme
                                              .contentTextStyle,
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
                              ),
                            ),
                            Expanded(
                              child: aedappfm.ButtonClose(
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
