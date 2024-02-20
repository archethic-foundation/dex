import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/farm_list/farm_list_sheet.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/layouts/components/farm_withdraw_textfield_amount.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';

import 'package:aedex/ui/views/util/components/fiat_value.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
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
    final farmWithdraw = ref.watch(FarmWithdrawFormProvider.farmWithdrawForm);
    if (farmWithdraw.dexFarmInfo == null) {
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
                      AppLocalizations.of(context)!.farmWithdrawFormTitle,
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
                      SelectableText(
                        'You can withdraw all or part of your deposited LP tokens. At the same time, this will claim your rewards.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      FutureBuilder<String>(
                        future: FiatValue().display(
                          ref,
                          farmWithdraw.dexFarmInfo!.rewardToken!,
                          farmWithdraw.dexFarmUserInfo!.rewardAmount,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: [
                                SelectableText(
                                  '${farmWithdraw.dexFarmUserInfo!.rewardAmount.formatNumber()} ${farmWithdraw.dexFarmInfo!.rewardToken!.symbol} ',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SelectableText(
                                  '${snapshot.data}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                SelectableText(
                                  ' are available for claiming.',
                                  style: Theme.of(context).textTheme.bodyLarge,
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
                            child: aedappfm.ButtonValidate(
                              controlOk: farmWithdraw.isControlsOk,
                              labelBtn: AppLocalizations.of(context)!
                                  .btn_farm_withdraw,
                              onPressed: () => ref
                                  .read(
                                    FarmWithdrawFormProvider
                                        .farmWithdrawForm.notifier,
                                  )
                                  .validateForm(context),
                              isConnected: ref
                                  .watch(SessionProviders.session)
                                  .isConnected,
                              displayWalletConnectOnPressed: () async {
                                final sessionNotifier =
                                    ref.read(SessionProviders.session.notifier);
                                await sessionNotifier.connectToWallet();

                                final session =
                                    ref.read(SessionProviders.session);
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
