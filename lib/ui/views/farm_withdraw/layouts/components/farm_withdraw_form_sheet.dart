import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_textfield_amount.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/btn_validate_mobile.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/fiat_value.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmWithdrawFormSheet extends ConsumerWidget {
  const FarmWithdrawFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final farmWithdraw = ref.watch(farmWithdrawFormNotifierProvider);
    if (farmWithdraw.dexFarmInfo == null ||
        farmWithdraw.rewardToken == null ||
        farmWithdraw.depositedAmount == null) {
      return const Padding(
        padding: EdgeInsets.only(top: 120, bottom: 120),
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 0.5),
        ),
      );
    }
    final session = ref.watch(sessionNotifierProvider);
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
                      AppLocalizations.of(context)!.farmWithdrawFormTitle,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.titleMedium!,
                            ),
                          ),
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
                      SelectableText(
                        AppLocalizations.of(context)!.farmWithdrawFormText,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                      if (farmWithdraw.rewardAmount == 0)
                        SelectableText(
                          AppLocalizations.of(context)!
                              .farmWithdrawFormTextNoRewardText1,
                          style: AppTextStyles.bodyLarge(context),
                        )
                      else
                        FutureBuilder<String>(
                          future: FiatValue().display(
                            ref,
                            farmWithdraw.dexFarmInfo!.rewardToken!,
                            farmWithdraw.rewardAmount!,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                children: [
                                  SelectableText(
                                    farmWithdraw.rewardAmount!.formatNumber(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: aedappfm
                                              .AppThemeBase.secondaryColor,
                                          fontSize: aedappfm.Responsive
                                              .fontSizeFromTextStyle(
                                            context,
                                            Theme.of(context)
                                                .textTheme
                                                .bodyLarge!,
                                          ),
                                        ),
                                  ),
                                  SelectableText(
                                    ' ${farmWithdraw.dexFarmInfo!.rewardToken!.symbol} ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: aedappfm.Responsive
                                              .fontSizeFromTextStyle(
                                            context,
                                            Theme.of(context)
                                                .textTheme
                                                .bodyLarge!,
                                          ),
                                        ),
                                  ),
                                  SelectableText(
                                    '${snapshot.data}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: aedappfm.Responsive
                                              .fontSizeFromTextStyle(
                                            context,
                                            Theme.of(context)
                                                .textTheme
                                                .bodyLarge!,
                                          ),
                                        ),
                                  ),
                                  SelectableText(
                                    AppLocalizations.of(context)!
                                        .farmWithdrawFormTextNoRewardText2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: aedappfm.Responsive
                                              .fontSizeFromTextStyle(
                                            context,
                                            Theme.of(context)
                                                .textTheme
                                                .bodyLarge!,
                                          ),
                                        ),
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      const FarmWithdrawAmount(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      aedappfm.ErrorMessage(
                        failure: farmWithdraw.failure,
                        failureMessage: FailureMessage(
                          context: context,
                          failure: farmWithdraw.failure,
                        ).getMessage(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ButtonValidateMobile(
                              controlOk: farmWithdraw.isControlsOk,
                              labelBtn: AppLocalizations.of(context)!
                                  .btn_farm_withdraw,
                              onPressed: () => ref
                                  .read(
                                    farmWithdrawFormNotifierProvider.notifier,
                                  )
                                  .validateForm(localizations),
                              isConnected: session.isConnected,
                              displayWalletConnectOnPressed: () async {
                                if (session.error.isNotEmpty) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Theme.of(context)
                                          .snackBarTheme
                                          .backgroundColor,
                                      content: SelectableText(
                                        session.error,
                                        style: Theme.of(context)
                                            .snackBarTheme
                                            .contentTextStyle,
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  if (!context.mounted) return;
                                  context.go(
                                    '/',
                                  );
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: aedappfm.ButtonClose(
                              onPressed: () {
                                context.pop();
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
