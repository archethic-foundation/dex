/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/icon_button_animated.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquiditySettingsSlippageTolerance extends ConsumerStatefulWidget {
  const LiquiditySettingsSlippageTolerance({
    super.key,
  });

  @override
  LiquiditySettingsSlippageToleranceState createState() =>
      LiquiditySettingsSlippageToleranceState();
}

class LiquiditySettingsSlippageToleranceState
    extends ConsumerState<LiquiditySettingsSlippageTolerance> {
  late TextEditingController slippageToleranceController;
  late FocusNode slippageToleranceFocusNode;

  @override
  void initState() {
    super.initState();
    final liquidityAdd = ref.read(LiquidityAddFormProvider.liquidityAddForm);
    slippageToleranceFocusNode = FocusNode();
    slippageToleranceController =
        TextEditingController(text: liquidityAdd.slippageTolerance.toString());
  }

  @override
  void dispose() {
    slippageToleranceFocusNode.dispose();
    slippageToleranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final liquidityAddNotifier =
        ref.read(LiquidityAddFormProvider.liquidityAddForm.notifier);

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
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: IconButtonAnimated(
                        icon: Icon(
                          Icons.help,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {},
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
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
                  textAlign: TextAlign.right,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(right: 5, top: -3),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text('%'),
            ),
          ],
        ),
        DexButtonValidate(
          controlOk:
              double.tryParse(slippageToleranceController.text) != null &&
                  (double.tryParse(slippageToleranceController.text)! >= 0 &&
                      double.tryParse(slippageToleranceController.text)! < 100),
          icon: Iconsax.setting_3,
          labelBtn: AppLocalizations.of(context)!.btn_save,
          onPressed: () {
            liquidityAddNotifier.setSlippageTolerance(
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