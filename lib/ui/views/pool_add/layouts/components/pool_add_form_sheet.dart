import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_textfield_token_1_amount.dart';
import 'package:aedex/ui/views/pool_add/layouts/components/pool_add_textfield_token_2_amount.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PoolAddFormSheet extends ConsumerWidget {
  const PoolAddFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);

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
                      AppLocalizations.of(context)!.poolAddFormTitle,
                      style: AppTextStyles.bodyLarge(context),
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
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PoolAddToken1Amount(),
                      const SizedBox(
                        height: 10,
                      ),
                      const PoolAddToken2Amount(),
                      if (poolAdd.messageMaxHalfUCO)
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
                      aedappfm.ErrorMessage(
                        failure: poolAdd.failure,
                        failureMessage: FailureMessage(
                          context: context,
                          failure: poolAdd.failure,
                        ).getMessage(),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      aedappfm.ButtonValidate(
                        controlOk: poolAdd.isControlsOk,
                        labelBtn: AppLocalizations.of(context)!.btn_pool_add,
                        onPressed: () => ref
                            .read(PoolAddFormProvider.poolAddForm.notifier)
                            .validateForm(context),
                        isConnected:
                            ref.watch(SessionProviders.session).isConnected,
                        displayWalletConnectOnPressed: () async {
                          final sessionNotifier =
                              ref.read(SessionProviders.session.notifier);
                          await sessionNotifier.connectToWallet();

                          final session = ref.read(SessionProviders.session);
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
                            context.pop();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      aedappfm.ButtonClose(
                        onPressed: () {
                          context.pop();
                        },
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
