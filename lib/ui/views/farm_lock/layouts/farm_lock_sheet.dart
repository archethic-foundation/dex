import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_block_header.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_block_list_header.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_block_list_single_line_legacy.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_block_list_single_line_lock.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_list.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco_aeeth.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockSheet extends ConsumerStatefulWidget {
  const FarmLockSheet({
    super.key,
  });

  static const routerPage = '/farmLock';
  static const routerPage2 = '/earn';

  @override
  ConsumerState<FarmLockSheet> createState() => FarmLockSheetState();
}

class FarmLockSheetState extends ConsumerState<FarmLockSheet> {
  Map<String, bool> sortAscending = {
    'amount': true,
    'rewards': true,
    'unlocks_in': true,
    'level': false,
    'apr': true,
  };

  String currentSortedColumn = 'level';

  @override
  void initState() {
    Future(() async {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.earn;
    });
    super.initState();
  }

  void _onSort(String column, bool ascending) {
    setState(() {
      if (currentSortedColumn != column) {
        sortAscending[column] = true;
      } else {
        sortAscending[column] = !sortAscending[column]!;
      }
      currentSortedColumn = column;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenList(
      body: _body(context, ref),
      bodyVerticalAlignment: Alignment.topCenter,
    );
  }

  Widget _body(BuildContext context, WidgetRef ref) {
    final farmLock = ref.watch(farmLockFormFarmLockProvider).value;
    final pool = ref.watch(farmLockFormPoolProvider).value;
    final farm = ref.watch(farmLockFormFarmProvider).value;

    final session = ref.watch(sessionNotifierProvider);
    final sortedUserInfos = ref
            .watch(
              farmLockFormSortedUserFarmLocksProvider(
                currentSortedColumn,
                sortAscending[currentSortedColumn],
              ),
            )
            .value ??
        [];
    return Padding(
      padding: EdgeInsets.only(
        top: aedappfm.Responsive.isDesktop(context) ||
                aedappfm.Responsive.isTablet(context)
            ? 75
            : 0,
        bottom: aedappfm.Responsive.isDesktop(context) ||
                aedappfm.Responsive.isTablet(context)
            ? 40
            : 100,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const FarmLockBlockHeader(),
            const SizedBox(
              height: 5,
            ),
            if (session.isConnected)
              FarmLockBlockListHeader(
                onSort: _onSort,
                sortAscending: sortAscending,
                currentSortedColumn: currentSortedColumn,
              ),
            if (session.isConnected)
              const SizedBox(
                height: 6,
              ),
            if (session.isConnected)
              aedappfm.ArchethicScrollbar(
                thumbVisibility: false,
                child: Column(
                  children: [
                    if (farm != null) const FarmLockBlockListSingleLineLegacy(),
                    const SizedBox(
                      height: 6,
                    ),
                    if (session.isConnected &&
                        farmLock != null &&
                        sortedUserInfos.isNotEmpty)
                      ...sortedUserInfos.map((userInfo) {
                        return FarmLockBlockListSingleLineLock(
                          farmLockUserInfos: userInfo,
                        );
                      }).toList(),
                    const SizedBox(
                      height: 6,
                    ),
                    if (pool != null)
                      Opacity(
                        opacity: AppTextStyles.kOpacityText,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ArchethicOraclePair(
                                    token1: pool.pair.token1,
                                    token2: pool.pair.token2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
