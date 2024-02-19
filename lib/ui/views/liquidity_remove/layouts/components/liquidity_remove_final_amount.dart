import 'dart:async';

import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveFinalAmount extends ConsumerStatefulWidget {
  const LiquidityRemoveFinalAmount({super.key, required this.address});

  final String address;

  @override
  ConsumerState<LiquidityRemoveFinalAmount> createState() =>
      _LiquidityRemoveFinalAmountState();
}

class _LiquidityRemoveFinalAmountState
    extends ConsumerState<LiquidityRemoveFinalAmount>
    with aedappfm.TransactionMixin {
  double? finalAmountToken1;
  double? finalAmountToken2;
  double? finalAmountLPToken;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) async {
      try {
        final liquidityRemove =
            ref.read(LiquidityRemoveFormProvider.liquidityRemoveForm);
        final results = await Future.wait([
          getAmountFromTxInput(
            widget.address,
            liquidityRemove.token1!.address,
          ),
          getAmountFromTxInput(
            widget.address,
            liquidityRemove.token2!.address,
          ),
          getAmountFromTx(
            widget.address,
            false,
            '00000000000000000000000000000000000000000000000000000000000000000000',
          ),
        ]);

        final amountToken1 = results[0];
        final amountToken2 = results[1];
        final amountLPToken = results[2];

        if (amountToken1 > 0 && amountToken2 > 0 && amountLPToken > 0) {
          setState(() {
            finalAmountToken1 = amountToken1;
            finalAmountToken2 = amountToken2;
            finalAmountLPToken = amountLPToken;
          });

          final liquidityRemove =
              ref.read(LiquidityRemoveFormProvider.liquidityRemoveForm);

          ref.read(DexPoolProviders.updatePoolInCache(liquidityRemove.pool!));

          unawaited(refreshCurrentAccountInfoWallet());
          timer?.cancel();
        }
        // ignore: empty_catches
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);

    if (liquidityRemove.liquidityRemoveOk == false) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (finalAmountToken1 != null)
          SelectableText(
            'Token obtained: ${finalAmountToken1!.formatNumber(precision: 8)} ${liquidityRemove.token1!.symbol}',
          )
        else
          const Row(
            children: [
              SelectableText(
                'Token obtained: ',
              ),
              SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ],
          ),
        if (finalAmountToken2 != null)
          SelectableText(
            'Token obtained: ${finalAmountToken2!.formatNumber(precision: 8)} ${liquidityRemove.token2!.symbol}',
          )
        else
          const Row(
            children: [
              SelectableText(
                'Token obtained: ',
              ),
              SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ],
          ),
        if (finalAmountLPToken != null)
          SelectableText(
            'LP Token burned: ${finalAmountLPToken!.formatNumber(precision: 8)}',
          )
        else
          const Row(
            children: [
              SelectableText(
                'LP Token burned: ',
              ),
              SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ],
          ),
      ],
    );
  }
}
