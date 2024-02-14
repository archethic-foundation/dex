import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_icon_settings.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_infos.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_textfield_token_1_amount.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/components/liquidity_add_textfield_token_2_amount.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/pool_list_sheet.dart';
import 'package:aedex/ui/views/util/components/dex_btn_close.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_error_message.dart';
import 'package:aedex/ui/views/util/components/dex_token_infos.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:aedex/ui/views/util/components/pool_info_card.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
                      gradient: aedappfm.AppThemeBase.gradient,
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
                      if (liquidityAdd.messageMaxHalfUCO)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            height: 40,
                            child: aedappfm.InfoBanner(
                              r'This process requires a maximum of $0.5 in transaction fees to be completed.',
                              aedappfm.InfoBannerType.request,
                            ),
                          ),
                        ),
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
                                      navigationIndexMainScreenProvider
                                          .notifier,
                                    )
                                    .state = 1;
                                context.go(PoolListSheet.routerPage);
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
