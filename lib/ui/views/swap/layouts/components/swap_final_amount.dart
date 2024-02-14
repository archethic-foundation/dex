import 'dart:async';

import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapFinalAmount extends ConsumerStatefulWidget {
  const SwapFinalAmount({super.key, required this.address});

  final String address;

  @override
  ConsumerState<SwapFinalAmount> createState() => _SwapFinalAmountState();
}

class _SwapFinalAmountState extends ConsumerState<SwapFinalAmount>
    with TransactionDexMixin {
  double? finalAmount;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) async {
      try {
        final swap = ref.read(SwapFormProvider.swapForm);
        final amount = await getAmountFromTxInput(
          widget.address,
          swap.tokenSwapped!.address,
        );
        if (amount > 0) {
          setState(() {
            finalAmount = amount;
          });
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
    final swap = ref.watch(SwapFormProvider.swapForm);
    if (swap.swapOk == false) return const SizedBox.shrink();

    return finalAmount != null
        ? SelectableText(
            'Final amount swapped: ${finalAmount!.formatNumber(precision: 8)} ${swap.tokenSwapped!.symbol}',
          )
        : const Row(
            children: [
              SelectableText(
                'Final amount swapped: ',
              ),
              SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ],
          );
  }
}
