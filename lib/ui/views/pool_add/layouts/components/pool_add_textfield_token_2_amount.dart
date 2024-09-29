/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_token_2_selection.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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

  @override
  void initState() {
    super.initState();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final poolAdd = ref.read(poolAddFormNotifierProvider);
    tokenAmountController = TextEditingController();
    tokenAmountController.value = aedappfm.AmountTextInputFormatter(
      precision: 8,
      thousandsSeparator: ',',
      useUnifyDecimalSeparator: false,
    ).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: poolAdd.token2Amount == 0
            ? ''
            : poolAdd.token2Amount
                .formatNumber(precision: 8)
                .replaceAll(',', ''),
      ),
    );
  }

  @override
  void dispose() {
    tokenAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final poolAddNotifier = ref.watch(poolAddFormNotifierProvider.notifier);

    final poolAdd = ref.watch(poolAddFormNotifierProvider);

    return Column(
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            SizedBox(
              width: aedappfm.AppThemeBase.sizeBoxComponentWidth,
              child: Row(
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withOpacity(1),
                                    Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withOpacity(0.3),
                                  ],
                                  stops: const [0, 1],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 160,
                                  right: 70,
                                ),
                                child: TextField(
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontSize: aedappfm.Responsive
                                            .fontSizeFromTextStyle(
                                          context,
                                          Theme.of(context)
                                              .textTheme
                                              .titleMedium!,
                                        ),
                                      ),
                                  autocorrect: false,
                                  controller: tokenAmountController,
                                  onChanged: (text) {
                                    ref
                                        .read(
                                          poolAddFormNotifierProvider.notifier,
                                        )
                                        .setTokenFormSelected(2);
                                    poolAddNotifier.setToken2Amount(
                                      AppLocalizations.of(context)!,
                                      double.tryParse(
                                            text.replaceAll(',', ''),
                                          ) ??
                                          0,
                                    );
                                  },
                                  onTap: () {
                                    ref
                                        .read(
                                          poolAddFormNotifierProvider.notifier,
                                        )
                                        .setTokenFormSelected(2);
                                  },
                                  textAlign: TextAlign.left,
                                  textInputAction: TextInputAction.done,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    aedappfm.AmountTextInputFormatter(
                                      precision: 8,
                                      thousandsSeparator: ',',
                                      useUnifyDecimalSeparator: false,
                                    ),
                                  ],
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 10),
                                  ),
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
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: PoolAddToken2Selection(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DexTokenBalance(
              tokenBalance: poolAdd.token2Balance,
              token: poolAdd.token2,
            ),
            if (poolAdd.token2Balance > 0)
              Row(
                children: [
                  aedappfm.ButtonHalf(
                    balanceAmount: poolAdd.token2Balance,
                    onTap: () {
                      ref
                          .read(
                            poolAddFormNotifierProvider.notifier,
                          )
                          .setTokenFormSelected(2);
                      ref
                          .read(poolAddFormNotifierProvider.notifier)
                          .setToken2AmountHalf(AppLocalizations.of(context)!);
                      _updateAmountTextController();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  aedappfm.ButtonMax(
                    balanceAmount: poolAdd.token2Balance,
                    onTap: () {
                      ref
                          .read(
                            poolAddFormNotifierProvider.notifier,
                          )
                          .setTokenFormSelected(2);
                      ref
                          .read(poolAddFormNotifierProvider.notifier)
                          .setToken2AmountMax(AppLocalizations.of(context)!);
                      _updateAmountTextController();
                    },
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
