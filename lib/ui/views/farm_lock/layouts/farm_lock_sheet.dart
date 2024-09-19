import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm_lock_user_infos.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock/bloc/state.dart';
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
  List<DexFarmLockUserInfos> sortedUserInfos = [];
  Map<String, bool> sortAscending = {
    'amount': true,
    'rewards': true,
    'unlocks_in': true,
    'level': false,
    'apr': true,
  };

  String currentSortedColumn = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.earn;
    });
    currentSortedColumn = 'level';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final farmLockForm = ref.watch(farmLockFormNotifierProvider).value ??
        const FarmLockFormState();
    if (farmLockForm.farmLock != null) {
      sortedUserInfos = farmLockForm.farmLock!.userInfos.entries
          .map((entry) => entry.value)
          .toList();

      sortedUserInfos = ref
          .watch(farmLockFormNotifierProvider.notifier)
          .sortData(currentSortedColumn, false, sortedUserInfos);
    }

    return MainScreenList(
      body: _body(context, ref, farmLockForm.pool),
      bodyVerticalAlignment: Alignment.topCenter,
    );
  }

  Widget _body(BuildContext context, WidgetRef ref, DexPool? pool) {
    final farmLockForm = ref.watch(farmLockFormNotifierProvider).value ??
        const FarmLockFormState();
    final session = ref.watch(sessionNotifierProvider);

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
            FarmLockBlockHeader(
              sortCriteria: currentSortedColumn,
            ),
            const SizedBox(
              height: 5,
            ),
            if (session.isConnected)
              FarmLockBlockListHeader(
                onSort:
                    ref.read(farmLockFormNotifierProvider.notifier).sortData,
                sortAscending: sortAscending,
                currentSortedColumn: currentSortedColumn,
                sortedUserInfos: sortedUserInfos,
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
                    if (farmLockForm.farm != null)
                      FarmLockBlockListSingleLineLegacy(
                        currentSortedColumn: currentSortedColumn,
                      ),
                    const SizedBox(
                      height: 6,
                    ),
                    if (session.isConnected &&
                        farmLockForm.farmLock != null &&
                        sortedUserInfos.isNotEmpty)
                      ...sortedUserInfos.map((userInfo) {
                        return FarmLockBlockListSingleLineLock(
                          farmLockUserInfos: userInfo,
                          currentSortedColumn: currentSortedColumn,
                        );
                      }).toList(),
                    const SizedBox(
                      height: 6,
                    ),
                    if (farmLockForm.pool != null)
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
                                    token1: farmLockForm.pool!.pair.token1,
                                    token2: farmLockForm.pool!.pair.token2,
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
