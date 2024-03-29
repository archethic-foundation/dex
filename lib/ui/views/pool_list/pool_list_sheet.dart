import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_list.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/components/pool_list_item.dart';
import 'package:aedex/ui/views/pool_list/components/pool_list_sheet_header.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
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
          .setPoolsToDisplay(widget.tab);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenList(
      body: _body(context, ref),
    );
  }
}

Widget _body(BuildContext context, WidgetRef ref) {
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
            top: aedappfm.Responsive.isDesktop(context) ? 140 : 200,
            bottom: aedappfm.Responsive.isDesktop(context) ? 40 : 80,
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
                          'Searching in progress. Please wait',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontSize:
                                    aedappfm.Responsive.fontSizeFromTextStyle(
                                  context,
                                  Theme.of(context).textTheme.bodyLarge!,
                                ),
                              ),
                        )
                      else
                        SelectableText(
                          'Loading in progress. Please wait',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontSize:
                                    aedappfm.Responsive.fontSizeFromTextStyle(
                                  context,
                                  Theme.of(context).textTheme.bodyLarge!,
                                ),
                              ),
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
                      'Please, connect your wallet to list your pools with position.',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodyLarge!,
                            ),
                          ),
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
                        'Please enter your search criteria.',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize:
                                  aedappfm.Responsive.fontSizeFromTextStyle(
                                context,
                                Theme.of(context).textTheme.bodyLarge!,
                              ),
                            ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableText(
                        'No results found.',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize:
                                  aedappfm.Responsive.fontSizeFromTextStyle(
                                context,
                                Theme.of(context).textTheme.bodyLarge!,
                              ),
                            ),
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
                      'To add your favorite pools to this tab, please click on the',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodyLarge!,
                            ),
                          ),
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
                      'icon in the pool cards header.',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodyLarge!,
                            ),
                          ),
                    ),
                  ],
                );
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width >= 1500
                      ? 3
                      : aedappfm.Responsive.isDesktop(context)
                          ? 2
                          : 1,
                  mainAxisExtent: 550,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 10,
                ),
                padding: EdgeInsets.only(
                  left: aedappfm.Responsive.isDesktop(context) ? 50 : 5,
                  right: aedappfm.Responsive.isDesktop(context) ? 50 : 5,
                ),
                itemCount: pools.length,
                itemBuilder: (context, index) {
                  final pool = pools[index];
                  return PoolListItem(
                    key: ValueKey(pool.poolAddress),
                    poolAddress: pool.poolAddress,
                  );
                },
              );
            },
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(
          top: 60,
        ),
        child: PoolListSheetHeader(),
      ),
    ],
  );
}
