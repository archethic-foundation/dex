/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddToken1Address extends ConsumerStatefulWidget {
  const PoolAddToken1Address({
    super.key,
  });

  @override
  ConsumerState<PoolAddToken1Address> createState() =>
      _PoolAddToken1AddressState();
}

class _PoolAddToken1AddressState extends ConsumerState<PoolAddToken1Address> {
  late TextEditingController addressController;
  late FocusNode addressFocusNode;

  @override
  void initState() {
    super.initState();
    addressFocusNode = FocusNode();
    _updateTextController();
  }

  @override
  void dispose() {
    addressFocusNode.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _updateTextController() {
    final poolAdd = ref.read(PoolAddFormProvider.poolAddForm);
    addressController = TextEditingController(text: poolAdd.);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);

    if (poolAdd.htlcAddress != addressController.text) {
      _updateTextController();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.refund_contract_address_lbl,
          ),
        ),
        SizedBox(
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              width: 0.5,
                            ),
                            gradient:
                                DexThemeBase.gradientInputFormBackground,
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontFamily: DexThemeBase.addressFont,
                              fontSize: 14,
                            ),
                            autocorrect: false,
                            controller: addressController,
                            onChanged: (text) async {
                              await ref
                                  .read(PoolAddFormProvider.poolAddForm.notifier)
                                  .setContractAddress(
                                    text,
                                  );
                            },
                            focusNode: addressFocusNode,
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              UpperCaseTextFormatter(),
                              LengthLimitingTextInputFormatter(68),
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
        ),
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}
