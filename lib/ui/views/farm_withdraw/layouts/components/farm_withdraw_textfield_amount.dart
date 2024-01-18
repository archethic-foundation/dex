import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmWithdrawAmount extends ConsumerStatefulWidget {
  const FarmWithdrawAmount({
    super.key,
  });

  @override
  ConsumerState<FarmWithdrawAmount> createState() =>
      _FarmWithdrawToken1AmountState();
}

class _FarmWithdrawToken1AmountState extends ConsumerState<FarmWithdrawAmount> {
  late TextEditingController tokenAmountController;
  late FocusNode tokenAmountFocusNode;

  @override
  void initState() {
    super.initState();
    tokenAmountFocusNode = FocusNode();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final farmWithdraw = ref.read(FarmWithdrawFormProvider.farmWithdrawForm);
    tokenAmountController = TextEditingController();
    tokenAmountController.value =
        AmountTextInputFormatter(precision: 8).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: farmWithdraw.amount == 0 ? '' : farmWithdraw.amount.toString(),
      ),
    );
  }

  @override
  void dispose() {
    tokenAmountFocusNode.dispose();
    tokenAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final farmWithdrawNotifier =
        ref.watch(FarmWithdrawFormProvider.farmWithdrawForm.notifier);

    final farmWithdraw = ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);
    final textNum = double.tryParse(tokenAmountController.text);
    if (textNum == null && farmWithdraw.amount != 0.0) {
      _updateAmountTextController();
    } else {
      if (textNum != null && farmWithdraw.amount != textNum) {
        _updateAmountTextController();
      }
    }

    return SizedBox(
      width: DexThemeBase.sizeBoxComponentWidth,
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          width: 0.5,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(1),
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.3),
                          ],
                          stops: const [0, 1],
                        ),
                      ),
                      child: TextField(
                        style: Theme.of(context).textTheme.titleMedium,
                        autocorrect: false,
                        controller: tokenAmountController,
                        onChanged: (text) async {
                          farmWithdrawNotifier.setAmount(
                            double.tryParse(text.replaceAll(' ', '')) ?? 0,
                          );
                        },
                        focusNode: tokenAmountFocusNode,
                        textAlign: TextAlign.left,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        inputFormatters: <TextInputFormatter>[
                          AmountTextInputFormatter(precision: 8),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
