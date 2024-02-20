import 'dart:async';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
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
    extends ConsumerState<FarmWithdrawFinalAmount>
    with aedappfm.TransactionMixin {
  double? finalAmountReward;
  double? finalAmountWithdraw;
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
        final farmWithdraw =
            ref.read(FarmWithdrawFormProvider.farmWithdrawForm);
        final results = await Future.wait([
          getAmountFromTxInput(
            widget.address,
            farmWithdraw.dexFarmInfo!.rewardToken!.address,
          ),
          getAmountFromTxInput(
            widget.address,
            farmWithdraw.dexFarmInfo!.lpToken!.address,
          ),
        ]);

        final amountReward = results[0];
        final amountWithdraw = results[1];

        if (amountReward > 0 && amountWithdraw > 0) {
          setState(() {
            finalAmountReward = amountReward;
            finalAmountWithdraw = amountWithdraw;
          });

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
    final farmWithdraw = ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);

    if (farmWithdraw.farmWithdrawOk == false) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (finalAmountWithdraw != null)
          SelectableText(
            'Amount withdrawed: ${finalAmountWithdraw!.formatNumber(precision: 8)} ${finalAmountWithdraw! > 1 ? 'LP Tokens' : 'LP Token'}',
          )
        else if (timeout == false)
          const Row(
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
          )
        else
          const SelectableText(
            'Amount withdrawed: The amount could not be recovered',
          ),
        if (finalAmountReward != null)
          SelectableText(
            'Amount rewarded: ${finalAmountReward!.formatNumber(precision: 8)} ${farmWithdraw.dexFarmInfo!.rewardToken!.symbol}',
          )
        else if (timeout == false)
          const Row(
            children: [
              SelectableText(
                'Amount rewarded: ',
              ),
              SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ],
          )
        else
          const SelectableText(
            'Amount rewarded: The amount could not be recovered',
          ),
      ],
    );
  }
}
