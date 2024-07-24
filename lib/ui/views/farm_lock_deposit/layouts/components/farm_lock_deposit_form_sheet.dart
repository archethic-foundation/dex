import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/farm_lock_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/components/farm_lock_deposit_lock_duration_btn.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/components/farm_lock_deposit_textfield_amount.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_details_info_header.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/farm_lock_duration_type.dart';
import 'package:aedex/util/config/config.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class FarmLockDepositFormSheet extends ConsumerStatefulWidget {
  const FarmLockDepositFormSheet({
    super.key,
  });

  @override
  ConsumerState<FarmLockDepositFormSheet> createState() =>
      FarmLockDepositFormSheetState();
}

class FarmLockDepositFormSheetState
    extends ConsumerState<FarmLockDepositFormSheet> {
  Map<String, int> filterAvailableLevels = <String, int>{};

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      filterAvailableLevels = ref
          .read(FarmLockDepositFormProvider.farmLockDepositForm.notifier)
          .filterAvailableLevels();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final farmLockDeposit =
        ref.watch(FarmLockDepositFormProvider.farmLockDepositForm);

    if (farmLockDeposit.pool == null) {
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
                      AppLocalizations.of(context)!.farmLockDepositFormTitle,
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
          PoolDetailsInfoHeader(
            pool: farmLockDeposit.pool,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectableText(
                        AppLocalizations.of(context)!
                            .farmLockDepositFormAmountLbl,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                      if (farmLockDeposit.aprEstimation != null)
                        SelectableText(
                          '${AppLocalizations.of(context)!.farmLockDepositAPREstimationLbl} ${farmLockDeposit.aprEstimation!.formatNumber(precision: 2)}%',
                          style: AppTextStyles.bodyLarge(context),
                        )
                      else
                        const SizedBox.shrink(),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FarmLockDepositAmount(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SelectableText(
                        AppLocalizations.of(context)!
                            .farmLockDepositFormLockDurationLbl,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      ...filterAvailableLevels.entries.map((entry) {
                        return FarmLockDepositDurationButton(
                          farmLockDepositDuration:
                              getFarmLockDepositDurationTypeFromLevel(
                            entry.key,
                          ),
                          level: entry.key,
                          aprEstimation: (farmLockDeposit.farmLock!
                                      .stats[entry.key]?.aprEstimation ??
                                  0) *
                              100,
                        );
                      }).toList(),
                    ],
                  ),
                  if (farmLockDeposit.farmLockDepositDuration !=
                      FarmLockDepositDurationType.flexible)
                    Row(
                      children: [
                        SelectableText(
                          AppLocalizations.of(context)!
                              .farmLockDepositUnlockDateLbl,
                          style: AppTextStyles.bodyLarge(context),
                        ),
                        SelectableText(
                          DateFormat(
                            Config.kSecondsInDay == 86400
                                ? 'yyyy-MM-dd'
                                : 'yyyy-MM-dd HH:mm:ss',
                          ).format(
                            getFarmLockDepositDuration(
                              farmLockDeposit.farmLockDepositDuration,
                              farmLockEndDate:
                                  farmLockDeposit.farmLock!.endDate,
                            )!,
                          ),
                          style: AppTextStyles.bodyLargeSecondaryColor(context),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        SelectableText(
                          ' ',
                          style: AppTextStyles.bodyLarge(context),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      aedappfm.ErrorMessage(
                        failure: farmLockDeposit.failure,
                        failureMessage: FailureMessage(
                          context: context,
                          failure: farmLockDeposit.failure,
                        ).getMessage(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: aedappfm.ButtonValidate(
                              controlOk: farmLockDeposit.isControlsOk &&
                                  ref
                                      .watch(SessionProviders.session)
                                      .isConnected,
                              labelBtn: AppLocalizations.of(context)!
                                  .btn_farmLockDeposit,
                              onPressed: () => ref
                                  .read(
                                    FarmLockDepositFormProvider
                                        .farmLockDepositForm.notifier,
                                  )
                                  .validateForm(context),
                              isConnected: true,
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
