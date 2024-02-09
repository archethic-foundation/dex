import 'dart:async';

import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:aedex/util/transaction_dex_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmWithdrawFinalAmount extends ConsumerStatefulWidget {
  const FarmWithdrawFinalAmount({super.key, required this.address});

  final String address;

  @override
  ConsumerState<FarmWithdrawFinalAmount> createState() =>
      _FarmWithdrawFinalAmountState();
}

class _FarmWithdrawFinalAmountState
    extends ConsumerState<FarmWithdrawFinalAmount> with TransactionDexMixin {
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
        final amount = await getAmountFromTxInput(widget.address);
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
    final farmWithdraw = ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);

    if (farmWithdraw.farmWithdrawOk == false) return const SizedBox.shrink();

    return finalAmount != null
        ? SelectableText(
            'Amount withdrawed: ${finalAmount!.formatNumber(precision: 8)} ${finalAmount! > 1 ? 'LP Tokens' : 'LP Token'}',
          )
        : const Row(
            children: [
              SelectableText(
                'Amount withdrawed: ',
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
