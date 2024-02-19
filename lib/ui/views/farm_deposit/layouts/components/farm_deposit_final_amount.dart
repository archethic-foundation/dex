import 'dart:async';

import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmDepositFinalAmount extends ConsumerStatefulWidget {
  const FarmDepositFinalAmount({
    super.key,
    required this.address,
    required this.isUCO,
    required this.to,
  });

  final String address;
  final bool isUCO;
  final String to;

  @override
  ConsumerState<FarmDepositFinalAmount> createState() =>
      _FarmDepositFinalAmountState();
}

class _FarmDepositFinalAmountState extends ConsumerState<FarmDepositFinalAmount>
    with aedappfm.TransactionMixin {
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
        final amount = await getAmountFromTx(
          widget.address,
          widget.isUCO,
          widget.to,
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
    final farmDeposit = ref.watch(FarmDepositFormProvider.farmDepositForm);

    if (farmDeposit.farmDepositOk == false) return const SizedBox.shrink();

    return finalAmount != null
        ? SelectableText(
            'Amount deposited: ${finalAmount!.formatNumber(precision: 8)} ${finalAmount! > 1 ? 'LP Tokens' : 'LP Token'}',
          )
        : const Row(
            children: [
              SelectableText(
                'Amount deposited: ',
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
