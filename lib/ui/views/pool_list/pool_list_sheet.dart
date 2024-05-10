import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_list.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/components/pool_list_item.dart';
import 'package:aedex/ui/views/pool_list/components/pool_list_sheet_header.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolListSheet extends ConsumerStatefulWidget {
  const PoolListSheet({
    this.tab = PoolsListTab.verified,
    super.key,
  });

  static const routerPage = '/poolList';

  final PoolsListTab tab;

  @override
  ConsumerState<PoolListSheet> createState() => _PoolListSheetState();
}

class _PoolListSheetState extends ConsumerState<PoolListSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.pool;

      await ref
          .read(PoolListFormProvider.poolListForm.notifier)
          .setPoolsToDisplay(
            tabIndexSelected: widget.tab,
            cancelToken: UniqueKey().toString(),
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenList(
      body: _body(context, ref, widget.tab),
    );
  }
}

Widget _body(BuildContext context, WidgetRef ref, PoolsListTab tab) {
  final selectedTab =
      ref.watch(PoolListFormProvider.poolListForm).tabIndexSelected;
  final asyncPools =
      ref.watch(PoolListFormProvider.poolListForm).poolsToDisplay;
  final poolListForm = ref.watch(PoolListFormProvider.poolListForm);
  final session = ref.watch(SessionProviders.session);
  return Stack(
    children: [
      Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: aedappfm.Responsive.isDesktop(context) ||
                    aedappfm.Responsive.isTablet(context)
                ? 140
                : 90,
            bottom: aedappfm.Responsive.isDesktop(context) ||
                    aedappfm.Responsive.isTablet(context)
                ? 40
                : 0,
          ),
          child: asyncPools.when(
            loading: () {
              return Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (selectedTab == PoolsListTab.searchPool)
                        SelectableText(
                          AppLocalizations.of(context)!.poolListSearching,
                          style: AppTextStyles.bodyLarge(context),
                        )
                      else
                        SelectableText(
                          AppLocalizations.of(context)!.poolListLoading,
                          style: AppTextStyles.bodyLarge(context),
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 0.5,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            error: (error, stackTrace) => aedappfm.ErrorMessage(
              failure: aedappfm.Failure.fromError(error),
              failureMessage: FailureMessage(
                context: context,
                failure: aedappfm.Failure.fromError(error),
              ).getMessage(),
            ),
            data: (pools) {
              if (session.isConnected == false &&
                  poolListForm.tabIndexSelected == PoolsListTab.myPools) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!
                          .poolListConnectWalletMyPools,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ],
                );
              }
              if (pools.isEmpty &&
                  poolListForm.tabIndexSelected == PoolsListTab.searchPool) {
                if (poolListForm.searchText.isEmpty) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableText(
                        AppLocalizations.of(context)!
                            .poolListEnterSearchCriteria,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableText(
                        AppLocalizations.of(context)!.poolListNoResult,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                    ],
                  );
                }
              }
              if (pools.isEmpty &&
                  poolListForm.tabIndexSelected == PoolsListTab.favoritePools) {
                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!.poolListAddFavoriteText1,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 2,
                        right: 5,
                      ),
                      child: Icon(
                        aedappfm.Iconsax.star,
                        size: 14,
                      ),
                    ),
                    SelectableText(
                      AppLocalizations.of(context)!.poolListAddFavoriteText2,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ],
                );
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width >= 1500
                      ? 3
                      : aedappfm.Responsive.isDesktop(context) ||
                              aedappfm.Responsive.isTablet(context)
                          ? 2
                          : 1,
                  mainAxisExtent: 550,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 10,
                ),
                padding: EdgeInsets.only(
                  left: aedappfm.Responsive.isDesktop(context) ||
                          aedappfm.Responsive.isTablet(context)
                      ? 50
                      : 5,
                  right: aedappfm.Responsive.isDesktop(context) ||
                          aedappfm.Responsive.isTablet(context)
                      ? 50
                      : 5,
                ),
                itemCount: pools.length,
                itemBuilder: (context, index) {
                  final pool = pools[index];
                  final asyncPoolDetail =
                      ref.watch(DexPoolProviders.getPool(pool.poolAddress));
                  return asyncPoolDetail.when(
                    data: (poolDetail) {
                      if (poolDetail == null) {
                        return const SizedBox.shrink();
                      }
                      return PoolListItem(
                        key: ValueKey(pool.poolAddress),
                        pool: pool,
                        tab: tab,
                      );
                    },
                    loading: () {
                      return const SizedBox.shrink();
                    },
                    error: (error, stackTrace) {
                      return const SizedBox.shrink();
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: aedappfm.Responsive.isMobile(context) ? 0 : 60,
        ),
        child: const PoolListSheetHeader(),
      ),
    ],
  );
}
