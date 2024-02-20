import 'dart:async';

import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddFinalAmount extends ConsumerStatefulWidget {
  const LiquidityAddFinalAmount({
    super.key,
    required this.address,
    required this.to,
  });

  final String address;
  final String to;

  @override
  ConsumerState<LiquidityAddFinalAmount> createState() =>
      _LiquidityAddFinalAmountState();
}

class _LiquidityAddFinalAmountState
    extends ConsumerState<LiquidityAddFinalAmount>
    with aedappfm.TransactionMixin {
  double? finalAmount;
  Timer? timer;
  Timer? timeoutTimer;
  bool? timeout;

  @override
  void initState() {
    timeout = false;
    super.initState();
    startTimer();
    startTimeoutTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) async {
      try {
        final amount = await getAmountFromTxInput(
          widget.address,
          widget.to,
        );
        if (amount > 0) {
          setState(() {
            finalAmount = amount;
          });

          final liquidityAdd =
              ref.read(LiquidityAddFormProvider.liquidityAddForm);

          ref.read(DexPoolProviders.updatePoolInCache(liquidityAdd.pool!));

          unawaited(refreshCurrentAccountInfoWallet());
          timer?.cancel();
        }
        // ignore: empty_catches
      } catch (e) {}
    });
  }

  void startTimeoutTimer() {
    timeoutTimer = Timer(const Duration(minutes: 1), () {
      timeout = true;
      timer?.cancel();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    timeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);

    if (liquidityAdd.liquidityAddOk == false) return const SizedBox.shrink();

    return finalAmount != null
        ? SelectableText(
            'LP Tokens obtained: ${finalAmount!.formatNumber(precision: 8)} ${finalAmount! > 1 ? 'LP Tokens' : 'LP Token'}',
          )
        : timeout == false
            ? const Row(
                children: [
                  SelectableText(
                    'LP Tokens obtained: ',
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(strokeWidth: 1),
                  ),
                ],
              )
            : const SelectableText(
                'LP Tokens obtained: The amount could not be recovered',
              );
  }
}
