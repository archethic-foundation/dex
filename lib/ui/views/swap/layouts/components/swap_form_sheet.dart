import 'dart:convert';

import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_infos.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_textfield_token_swapped_amount.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_textfield_token_to_swap_amount.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/util/components/btn_validate_mobile.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SwapFormSheet extends ConsumerStatefulWidget {
  const SwapFormSheet({
    this.tokenToSwap,
    this.tokenSwapped,
    this.from,
    this.to,
    this.value,
    super.key,
  });

  final DexToken? tokenToSwap;
  final DexToken? tokenSwapped;
  final String? from;
  final String? to;
  final double? value;

  @override
  ConsumerState<SwapFormSheet> createState() => _SwapFormSheetState();
}

class _SwapFormSheetState extends ConsumerState<SwapFormSheet> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      try {
        if (widget.value != null) {
          ref.read(swapFormNotifierProvider.notifier)
            ..setTokenFormSelected(1)
            ..setTokenToSwapAmountWithoutCalculation(widget.value!);
        }

        if (widget.from != null) {
          DexToken? _tokenToSwap;
          if (widget.from != 'UCO') {
            _tokenToSwap = await ref.read(
              DexTokensProviders.getTokenFromAddress(widget.from).future,
            );
          } else {
            _tokenToSwap = ucoToken;
          }
          if (_tokenToSwap != null) {
            await ref
                .read(swapFormNotifierProvider.notifier)
                .setTokenToSwap(_tokenToSwap);
          }
        } else {
          if (widget.tokenToSwap != null) {
            await ref
                .read(swapFormNotifierProvider.notifier)
                .setTokenToSwap(widget.tokenToSwap!);
          }
        }

        if (widget.to != null) {
          DexToken? _tokenSwapped;
          if (widget.to != 'UCO') {
            _tokenSwapped = await ref.read(
              DexTokensProviders.getTokenFromAddress(widget.to).future,
            );
          } else {
            _tokenSwapped = ucoToken;
          }
          if (_tokenSwapped != null) {
            await ref
                .read(swapFormNotifierProvider.notifier)
                .setTokenSwapped(_tokenSwapped);
          }
        } else {
          if (widget.tokenSwapped != null) {
            await ref
                .read(swapFormNotifierProvider.notifier)
                .setTokenSwapped(widget.tokenSwapped!);
          }
        }

        if (widget.value != null) {
          ref.read(swapFormNotifierProvider.notifier).setTokenFormSelected(2);
        }
      } catch (e) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              e.toString(),
              level: aedappfm.LogLevel.error,
              name: 'SwapFormSheet - initState',
            );
        if (mounted) {
          context.go(SwapSheet.routerPage);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext contextf) {
    final swap = ref.watch(swapFormNotifierProvider);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwapTokenToSwapAmount(),
                SwapTokenSwappedAmount(),
                SwapInfos(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (swap.messageMaxHalfUCO)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      child: aedappfm.InfoBanner(
                        AppLocalizations.of(context)!
                            .swapMessageMaxHalfUCO
                            .replaceFirst(
                              '%1',
                              swap.feesEstimatedUCO.formatNumber(precision: 8),
                            ),
                        aedappfm.InfoBannerType.request,
                      ),
                    ),
                  ),
                aedappfm.ErrorMessage(
                  failure: swap.failure,
                  failureMessage: FailureMessage(
                    context: context,
                    failure: swap.failure,
                  ).getMessage(),
                ),
                if (swap.failure is aedappfm.PoolNotExists &&
                    swap.tokenToSwap != null &&
                    swap.tokenSwapped != null &&
                    swap.tokenToSwap!.address != swap.tokenSwapped!.address)
                  TextButton.icon(
                    label: Text(AppLocalizations.of(context)!.swapCreatePool),
                    onPressed: () {
                      final token1Json = jsonEncode(swap.tokenToSwap!.toJson());
                      final token2Json =
                          jsonEncode(swap.tokenSwapped!.toJson());
                      final token1Encoded = Uri.encodeComponent(token1Json);
                      final token2Encoded = Uri.encodeComponent(token2Json);
                      context.go(
                        Uri(
                          path: PoolAddSheet.routerPage,
                          queryParameters: {
                            'token1': token1Encoded,
                            'token2': token2Encoded,
                          },
                        ).toString(),
                      );
                    },
                    icon: const Icon(Icons.add),
                  ),
                ButtonValidateMobile(
                  controlOk: swap.isControlsOk,
                  labelBtn: AppLocalizations.of(context)!.btn_swap,
                  onPressed: () => ref
                      .read(swapFormNotifierProvider.notifier)
                      .validateForm(context),
                  displayWalletConnect: true,
                  isConnected: ref.watch(sessionNotifierProvider).isConnected,
                  displayWalletConnectOnPressed: () async {
                    final session = ref.read(sessionNotifierProvider);
                    if (session.error.isNotEmpty) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                              Theme.of(context).snackBarTheme.backgroundColor,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
