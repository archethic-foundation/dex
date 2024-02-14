/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapSettingsSlippageTolerance extends ConsumerStatefulWidget {
  const SwapSettingsSlippageTolerance({
    super.key,
  });

  @override
  SwapSettingsSlippageToleranceState createState() =>
      SwapSettingsSlippageToleranceState();
}

class SwapSettingsSlippageToleranceState
    extends ConsumerState<SwapSettingsSlippageTolerance> {
  late TextEditingController slippageToleranceController;
  late FocusNode slippageToleranceFocusNode;

  @override
  void initState() {
    super.initState();
    final swap = ref.read(SwapFormProvider.swapForm);
    slippageToleranceFocusNode = FocusNode();
    slippageToleranceController =
        TextEditingController(text: swap.slippageTolerance.toString());
    Future.delayed(Duration.zero, () {
      ref.read(SwapFormProvider.swapForm.notifier).setTokenFormSelected(0);
    });
  }

  @override
  void dispose() {
    slippageToleranceFocusNode.dispose();
    slippageToleranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final swapNotifier = ref.watch(SwapFormProvider.swapForm.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.slippage_tolerance,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 75),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    width: 0.5,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.background.withOpacity(1),
                      Theme.of(context).colorScheme.background.withOpacity(0.3),
                    ],
                    stops: const [0, 1],
                  ),
                ),
                child: TextField(
                  autocorrect: false,
                  controller: slippageToleranceController,
                  focusNode: slippageToleranceFocusNode,
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.none,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    aedappfm.AmountTextInputFormatter(),
                    LengthLimitingTextInputFormatter(5),
                  ],
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: -3),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: SelectableText(
                '%',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        DexButtonValidate(
          controlOk:
              double.tryParse(slippageToleranceController.text) != null &&
                  (double.tryParse(slippageToleranceController.text)! >= 0 &&
                      double.tryParse(slippageToleranceController.text)! < 100),
          labelBtn: AppLocalizations.of(context)!.btn_save,
          onPressed: () {
            swapNotifier.setSlippageTolerance(
              double.tryParse(slippageToleranceController.text) ?? 0,
            );

            if (!context.mounted) return;
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
