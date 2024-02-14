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
                DexButtonValidate(
                  background: aedappfm.ArchethicThemeBase.purple500,
                  controlOk: balance != null && balance > 0,
                  labelBtn: 'Deposit LP Tokens',
                  onPressed: () {
                    context
                        .go(FarmDepositSheet.routerPage, extra: {'farm': farm});
                  },
                  displayWalletConnect: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DexButtonValidate(
                        background: aedappfm.ArchethicThemeBase.purple500,
                        controlOk: farm.lpTokenDeposited > 0,
                        labelBtn: 'Withdraw',
                        onPressed: () {
                          context.go(
                            FarmWithdrawSheet.routerPage,
                            extra: {
                              'farm': farm,
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: DexButtonValidate(
                        background: aedappfm.ArchethicThemeBase.purple500,
                        controlOk: true,
                        labelBtn: 'Claim',
                        onPressed: () async {
                          final farmUserInfo = await ref
                              .read(FarmListProvider.userInfos(farm).future);
                          if (context.mounted) {
                            context.go(
                              FarmClaimSheet.routerPage,
                              extra: {
                                'farmUserInfo': farmUserInfo,
                                'farm': farm,
                              },
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
