import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/dex_btn_close.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:aedex/ui/views/util/components/dex_error_message.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmClaimFormSheet extends ConsumerWidget {
  const FarmClaimFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmClaim = ref.watch(FarmClaimFormProvider.farmClaimForm);
    if (farmClaim.dexFarmUserInfo == null) {
      return const SizedBox.shrink();
    }

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
                      AppLocalizations.of(context)!.farmClaimFormTitle,
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
                      FutureBuilder<String>(
                        future: FiatValue().display(
                          ref,
                          farmClaim.dexFarm!.rewardToken!,
                          farmClaim.dexFarmUserInfo!.rewardAmount,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: farmClaim
                                        .dexFarmUserInfo!.rewardAmount
                                        .formatNumber(precision: 8),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: aedappfm
                                              .AppThemeBase.secondaryColor,
                                        ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' ${farmClaim.dexFarm!.rewardToken!.symbol}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  TextSpan(
                                    text: ' ${snapshot.data} ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  TextSpan(
                                    text: 'are available for claiming.',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DexErrorMessage(failure: farmClaim.failure),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DexButtonValidate(
                              controlOk: farmClaim.isControlsOk,
                              labelBtn:
                                  AppLocalizations.of(context)!.btn_farm_claim,
                              onPressed: () => ref
                                  .read(
                                    FarmClaimFormProvider
                                        .farmClaimForm.notifier,
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
                                    .state = 2;
                                context.go(FarmListSheet.routerPage);
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
