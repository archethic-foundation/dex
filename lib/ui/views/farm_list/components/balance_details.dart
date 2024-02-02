part of 'farm_details_front.dart';

class _BalanceDetails extends ConsumerWidget {
  const _BalanceDetails({
    required this.farm,
  });

  final DexFarm farm;

  @override
  Widget build(BuildContext context, WidgetRef ref) => FutureBuilder<double>(
        future: ref.watch(
          FarmListProvider.balance(farm).future,
        ),
        builder: (context, balanceSnapshot) {
          final balance = balanceSnapshot.data;
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your available LP Tokens',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge,
                  ),
                  if (balance == null)
                    const LoadingFieldIndicator()
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${balance.formatNumber()} ${balance > 1 ? 'LP Tokens' : 'LP Token'}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge,
                        ),
                        Text(
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
              Column(
                children: [
                  DexButtonValidate(
                    background: ArchethicThemeBase.purple500,
                    controlOk: balance != null && balance > 0,
                    labelBtn: 'Deposit LP Tokens',
                    onPressed: () {
                      ref
                          .read(
                            MainScreenWidgetDisplayedProviders
                                .mainScreenWidgetDisplayedProvider.notifier,
                          )
                          .setWidget(
                            FarmDepositSheet(
                              farm: farm,
                            ),
                            ref,
                          );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DexButtonValidate(
                          background: ArchethicThemeBase.purple500,
                          controlOk: farm.lpTokenDeposited > 0,
                          labelBtn: 'Withdraw',
                          onPressed: () {
                            ref
                                .read(
                                  MainScreenWidgetDisplayedProviders
                                      .mainScreenWidgetDisplayedProvider
                                      .notifier,
                                )
                                .setWidget(
                                  FarmWithdrawSheet(
                                    farm: farm,
                                  ),
                                  ref,
                                );
                          },
                        ),
                      ),
                      Expanded(
                        child: DexButtonValidate(
                          background: ArchethicThemeBase.purple500,
                          controlOk: true,
                          labelBtn: 'Claim',
                          onPressed: () async {
                            final farmUserInfos = await ref
                                .read(FarmListProvider.userInfos(farm).future);

                            ref
                                .read(
                                  MainScreenWidgetDisplayedProviders
                                      .mainScreenWidgetDisplayedProvider
                                      .notifier,
                                )
                                .setWidget(
                                  FarmClaimSheet(
                                    farmUserInfo: farmUserInfos,
                                    farm: farm,
                                  ),
                                  ref,
                                );
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
