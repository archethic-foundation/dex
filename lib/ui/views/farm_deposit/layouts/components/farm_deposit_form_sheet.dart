import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_deposit/layouts/components/farm_deposit_textfield_amount.dart';
import 'package:aedex/ui/views/farm_list/layouts/farm_list_sheet.dart';
import 'package:aedex/ui/views/util/components/btn_validate_mobile.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmDepositFormSheet extends ConsumerWidget {
  const FarmDepositFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmDeposit = ref.watch(FarmDepositFormProvider.farmDepositForm);
    if (farmDeposit.dexFarmInfo == null) {
      return const Padding(
        padding: EdgeInsets.only(top: 80, bottom: 80),
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 0.5),
        ),
      );
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
                      AppLocalizations.of(context)!.aeswap_farmDepositFormTitle,
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FarmDepositAmount(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      aedappfm.ErrorMessage(
                        failure: farmDeposit.failure,
                        failureMessage: FailureMessage(
                          context: context,
                          failure: farmDeposit.failure,
                        ).getMessage(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ButtonValidateMobile(
                              controlOk: farmDeposit.isControlsOk,
                              labelBtn: AppLocalizations.of(context)!
                                  .aeswap_btn_farm_deposit,
                              onPressed: () => ref
                                  .read(
                                    FarmDepositFormProvider
                                        .farmDepositForm.notifier,
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
