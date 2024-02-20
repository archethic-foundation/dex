part of 'farm_details_user_info.dart';

class _BalanceDetails extends ConsumerWidget {
  const _BalanceDetails({
    required this.farm,
  });

  final DexFarm farm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(SessionProviders.session);
    return FutureBuilder<double>(
      future: ref.watch(
        FarmListProvider.balance(farm.lpToken!.address).future,
      ),
      builder: (context, balanceSnapshot) {
        final balance = balanceSnapshot.data;
        return Column(
          children: [
            if (session.isConnected)
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectableText(
                        'Your available LP Tokens',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge,
                      ),
                      if (balance == null)
                        const Column(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 0.5,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                              width: 20,
                            ),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SelectableText(
                              '${balance.formatNumber()} ${balance > 1 ? 'LP Tokens' : 'LP Token'}',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge,
                            ),
                            SelectableText(
                              DEXLPTokenFiatValue().display(
                                ref,
                                farm.lpTokenPair!.token1,
                                farm.lpTokenPair!.token2,
                                balance,
                                farm.poolAddress,
                              ),
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              )
            else
              SizedBox(
                height: session.isConnected ? 240 : 190,
              ),
            Column(
              children: [
                aedappfm.ButtonValidate(
                  background: aedappfm.ArchethicThemeBase.purple500,
                  controlOk: balance != null && balance > 0,
                  labelBtn: 'Deposit LP Tokens',
                  onPressed: () {
                    final farmJson = jsonEncode(farm.toJson());
                    final farmEncoded = Uri.encodeComponent(farmJson);
                    context.go(
                      Uri(
                        path: FarmDepositSheet.routerPage,
                        queryParameters: {
                          'farm': farmEncoded,
                        },
                      ).toString(),
                    );
                  },
                  displayWalletConnect: true,
                  isConnected: session.isConnected,
                  displayWalletConnectOnPressed: () async {
                    final sessionNotifier =
                        ref.read(SessionProviders.session.notifier);
                    await sessionNotifier.connectToWallet();

                    final session = ref.read(SessionProviders.session);
                    if (session.error.isNotEmpty) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                              Theme.of(context).snackBarTheme.backgroundColor,
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
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: aedappfm.ButtonValidate(
                        background: aedappfm.ArchethicThemeBase.purple500,
                        controlOk: farm.lpTokenDeposited > 0,
                        labelBtn: 'Withdraw',
                        onPressed: () {
                          final farmJson = jsonEncode(farm.toJson());
                          final farmEncoded = Uri.encodeComponent(farmJson);
                          context.go(
                            Uri(
                              path: FarmWithdrawSheet.routerPage,
                              queryParameters: {
                                'farm': farmEncoded,
                              },
                            ).toString(),
                          );
                        },
                        isConnected: session.isConnected,
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
                            context.go(
                              '/',
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: aedappfm.ButtonValidate(
                        background: aedappfm.ArchethicThemeBase.purple500,
                        controlOk: farm.remainingReward > 0,
                        labelBtn: 'Claim',
                        onPressed: () async {
                          if (context.mounted) {
                            final farmJson = jsonEncode(farm.toJson());
                            final farmEncoded = Uri.encodeComponent(farmJson);
                            context.go(
                              Uri(
                                path: FarmClaimSheet.routerPage,
                                queryParameters: {
                                  'farm': farmEncoded,
                                },
                              ).toString(),
                            );
                          }
                        },
                        isConnected: session.isConnected,
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
                            context.go(
                              '/',
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
