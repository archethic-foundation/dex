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
                        ).textTheme.bodyLarge!.copyWith(
                              fontSize:
                                  aedappfm.Responsive.fontSizeFromTextStyle(
                                context,
                                Theme.of(context).textTheme.bodyLarge!,
                              ),
                            ),
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
                              ).textTheme.bodyLarge!.copyWith(
                                    fontSize: aedappfm.Responsive
                                        .fontSizeFromTextStyle(
                                      context,
                                      Theme.of(context).textTheme.bodyLarge!,
                                    ),
                                  ),
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
                              ).textTheme.bodyMedium!.copyWith(
                                    fontSize: aedappfm.Responsive
                                        .fontSizeFromTextStyle(
                                      context,
                                      Theme.of(context).textTheme.bodyMedium!,
                                    ),
                                  ),
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
                if (farm.endDate != null &&
                    farm.endDate!.isBefore(DateTime.now()))
                  aedappfm.ButtonValidate(
                    background: aedappfm.ArchethicThemeBase.purple500,
                    fontSize: aedappfm.Responsive.fontSizeFromValue(
                      context,
                      desktopValue: 16,
                    ),
                    labelBtn: 'Deposit LP Tokens (Farm closed)',
                    onPressed: () {},
                    controlOk: false,
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
                  )
                else
                  aedappfm.ButtonValidate(
                    background: aedappfm.ArchethicThemeBase.purple500,
                    fontSize: aedappfm.Responsive.fontSizeFromValue(
                      context,
                      desktopValue: 16,
                    ),
                    controlOk: balance != null && balance > 0,
                    labelBtn: 'Deposit LP Tokens',
                    onPressed: () {
                      final farmAddressJson = jsonEncode(farm.farmAddress);
                      final farmAddressEncoded =
                          Uri.encodeComponent(farmAddressJson);

                      final lpTokenAddressJson =
                          jsonEncode(farm.lpToken!.address);
                      final lpTokenAddressEncoded =
                          Uri.encodeComponent(lpTokenAddressJson);

                      final poolAddressJson = jsonEncode(farm.poolAddress);
                      final poolAddressEncoded =
                          Uri.encodeComponent(poolAddressJson);

                      context.go(
                        Uri(
                          path: FarmDepositSheet.routerPage,
                          queryParameters: {
                            'farmAddress': farmAddressEncoded,
                            'lpTokenAddress': lpTokenAddressEncoded,
                            'poolAddress': poolAddressEncoded,
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
                        fontSize: aedappfm.Responsive.fontSizeFromValue(
                          context,
                          desktopValue: 16,
                        ),
                        labelBtn: 'Withdraw',
                        onPressed: () {
                          final farmAddressJson = jsonEncode(farm.farmAddress);
                          final farmAddressEncoded =
                              Uri.encodeComponent(farmAddressJson);

                          final rewardTokenJson = jsonEncode(farm.rewardToken);
                          final rewardTokenEncoded =
                              Uri.encodeComponent(rewardTokenJson);

                          final lpTokenAddressJson =
                              jsonEncode(farm.lpToken!.address);
                          final lpTokenAddressEncoded =
                              Uri.encodeComponent(lpTokenAddressJson);

                          final poolAddressJson = jsonEncode(farm.poolAddress);
                          final poolAddressEncoded =
                              Uri.encodeComponent(poolAddressJson);

                          context.go(
                            Uri(
                              path: FarmWithdrawSheet.routerPage,
                              queryParameters: {
                                'farmAddress': farmAddressEncoded,
                                'rewardToken': rewardTokenEncoded,
                                'lpTokenAddress': lpTokenAddressEncoded,
                                'poolAddress': poolAddressEncoded,
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
                        fontSize: aedappfm.Responsive.fontSizeFromValue(
                          context,
                          desktopValue: 16,
                        ),
                        labelBtn: 'Claim',
                        onPressed: () async {
                          if (context.mounted) {
                            final farmAddressJson =
                                jsonEncode(farm.farmAddress);
                            final farmAddressEncoded =
                                Uri.encodeComponent(farmAddressJson);

                            final rewardTokenJson =
                                jsonEncode(farm.rewardToken);
                            final rewardTokenEncoded =
                                Uri.encodeComponent(rewardTokenJson);

                            final lpTokenAddressJson =
                                jsonEncode(farm.lpToken!.address);
                            final lpTokenAddressEncoded =
                                Uri.encodeComponent(lpTokenAddressJson);

                            context.go(
                              Uri(
                                path: FarmClaimSheet.routerPage,
                                queryParameters: {
                                  'farmAddress': farmAddressEncoded,
                                  'rewardToken': rewardTokenEncoded,
                                  'lpTokenAddress': lpTokenAddressEncoded,
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
