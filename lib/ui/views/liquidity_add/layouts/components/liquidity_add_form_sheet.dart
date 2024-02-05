import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_icon_settings.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_infos.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_textfield_token_1_amount.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_textfield_token_2_amount.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_btn_close.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_error_message.dart';
import 'package:aedex/ui/views/util/components/dex_token_infos.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/components/pool_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddFormSheet extends ConsumerWidget {
  const LiquidityAddFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SelectionArea(
                    child: SelectableText(
                      AppLocalizations.of(context)!.liquidityAddFormTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50,
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: DexThemeBase.gradient,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (liquidityAdd.token1 != null)
                        PoolInfoCard(
                          poolGenesisAddress: liquidityAdd.pool!.poolAddress,
                          tokenAddressRatioPrimary:
                              liquidityAdd.token1!.address == null
                                  ? 'UCO'
                                  : liquidityAdd.token1!.address!,
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SelectableText(
                            '${AppLocalizations.of(context)!.slippage_tolerance} ${liquidityAdd.slippageTolerance}%',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: LiquidityAddTokenIconSettings(),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          const LiquidityAddToken1Amount(),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (liquidityAdd.token1 != null &&
                                    liquidityAdd.token1Amount > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: FutureBuilder<String>(
                                      future: FiatValue().display(
                                        ref,
                                        liquidityAdd.token1!,
                                        liquidityAdd.token1Amount,
                                      ),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return SelectableText(
                                            snapshot.data!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      },
                                    ),
                                  ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 9),
                                  child: DexTokenInfos(
                                    token: liquidityAdd.token1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          const LiquidityAddToken2Amount(),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (liquidityAdd.token2 != null &&
                                    liquidityAdd.token2Amount > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: FutureBuilder<String>(
                                      future: FiatValue().display(
                                        ref,
                                        liquidityAdd.token2!,
                                        liquidityAdd.token2Amount,
                                      ),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return SelectableText(
                                            snapshot.data!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      },
                                    ),
                                  ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 9),
                                  child: DexTokenInfos(
                                    token: liquidityAdd.token2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const LiquidityAddInfos(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DexErrorMessage(failure: liquidityAdd.failure),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DexButtonValidate(
                              controlOk: liquidityAdd.isControlsOk,
                              labelBtn: AppLocalizations.of(context)!
                                  .btn_liquidity_add,
                              onPressed: () => ref
                                  .read(
                                    LiquidityAddFormProvider
                                        .liquidityAddForm.notifier,
                                  )
                                  .validateForm(context),
                            ),
                          ),
                          Expanded(
                            child: DexButtonClose(
                              onPressed: () {
                                ref
                                    .read(
                                      MainScreenWidgetDisplayedProviders
                                          .mainScreenWidgetDisplayedProvider
                                          .notifier,
                                    )
                                    .setWidget(
                                      const PoolListSheet(),
                                      ref,
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
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
