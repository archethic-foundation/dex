/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddToken2Amount extends ConsumerStatefulWidget {
  const PoolAddToken2Amount({
    super.key,
  });

  @override
  ConsumerState<PoolAddToken2Amount> createState() =>
      _PoolAddToken2AmountState();
}

class _PoolAddToken2AmountState extends ConsumerState<PoolAddToken2Amount> {
  late TextEditingController tokenAmountController;
  late FocusNode tokenAmountFocusNode;

  @override
  void initState() {
    super.initState();
    final poolAdd = ref.read(PoolAddFormProvider.poolAddForm);
    tokenAmountFocusNode = FocusNode();
    tokenAmountController =
        TextEditingController(text: poolAdd.token1Amount.toString());
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
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    final poolAddNotifier = ref.watch(PoolAddFormProvider.poolAddForm.notifier);

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
                        style: textTheme.titleLarge,
                        autocorrect: false,
                        controller: tokenAmountController,
                        onChanged: (text) async {
                          poolAddNotifier.setToken2Amount(
                            double.tryParse(text) ?? 0,
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
