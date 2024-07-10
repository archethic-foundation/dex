import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/farm/dex_farm_lock.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_farm_lock_user_infos.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_block_header.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_block_list_header.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_block_list_single_line_legacy.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_block_list_single_line_lock.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_list.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_uco_aeeth.dart';
import 'package:aedex/ui/views/util/components/pool_farm_available.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockSheet extends ConsumerStatefulWidget {
  const FarmLockSheet({
    super.key,
  });

  static const routerPage = '/farmLock';

  @override
  ConsumerState<FarmLockSheet> createState() => FarmLockSheetState();
}

class FarmLockSheetState extends ConsumerState<FarmLockSheet> {
  DexPool? pool;
  DexFarm? farm;
  DexFarmLock? farmLock;
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

      if (mounted) {
        await loadInfo();
      }
    });
    super.initState();
  }

  void sortData(String sortBy, bool invertSort) {
    setState(() {
      currentSortedColumn = sortBy;
      if (invertSort) {
        sortAscending[sortBy] = !sortAscending[sortBy]!;
      }
      final ascending = sortAscending[sortBy]!;
      sortedUserInfos.sort((a, b) {
        int compare;
        switch (sortBy) {
          case 'amount':
            compare = a.amount.compareTo(b.amount);
            break;
          case 'rewards':
            compare = a.rewardAmount.compareTo(b.rewardAmount);
            break;
          case 'unlocks_in':
            if (a.end == null && b.end == null) {
              compare = 0;
            } else if (a.end == null) {
              compare = 1;
            } else if (b.end == null) {
              compare = -1;
            } else {
              compare = a.end!.compareTo(b.end!);
            }
            break;
          case 'level':
            compare = a.level.compareTo(b.level);
            break;
          case 'apr':
            compare = a.apr.compareTo(b.apr);
            break;
          default:
            compare = 0;
        }
        return ascending ? compare : -compare;
      });
    });
  }

  Future<void> loadInfo({
    bool forceLoadFromBC = false,
    String sortCriteria = 'level',
    bool invertSort = false,
  }) async {
    currentSortedColumn = sortCriteria;
    if (mounted) {
      await ref.read(SessionProviders.session.notifier).updateCtxInfo(context);
      ref
          .read(FarmLockFormProvider.farmLockForm.notifier)
          .setMainInfoloadingInProgress(true);
    }

    final contextAddresses = PoolFarmAvailableState().getContextAddresses(ref);

    pool = await ref.read(
      DexPoolProviders.getPool(
        contextAddresses.aeETHUCOPoolAddress,
      ).future,
    );

    final farmAddress = contextAddresses.aeETHUCOFarmLegacyAddress;
    farm = await ref.read(
      DexFarmProviders.getFarmInfos(
        farmAddress,
        pool!.poolAddress,
        dexFarmInput: DexFarm(
          poolAddress: pool!.poolAddress,
          farmAddress: farmAddress,
        ),
      ).future,
    );

    final farmLockAddress = contextAddresses.aeETHUCOFarmLockAddress;
    if (farmLockAddress.isNotEmpty) {
      farmLock = await ref.read(
        DexFarmLockProviders.getFarmLockInfos(
          farmLockAddress,
          pool!.poolAddress,
          dexFarmLockInput: DexFarmLock(
            poolAddress: pool!.poolAddress,
            farmAddress: farmLockAddress,
          ),
        ).future,
      );
    }

    ref.read(FarmLockFormProvider.farmLockForm.notifier)
      ..setPool(pool!)
      ..setFarm(farm!);

    if (farmLock != null) {
      await ref
          .read(FarmLockFormProvider.farmLockForm.notifier)
          .setFarmLock(farmLock!);
    }

    await ref.read(FarmLockFormProvider.farmLockForm.notifier).initBalances();
    await ref
        .read(FarmLockFormProvider.farmLockForm.notifier)
        .calculateSummary();

    if (farmLock != null) {
      sortedUserInfos =
          farmLock!.userInfos.entries.map((entry) => entry.value).toList();
      sortData(currentSortedColumn, invertSort);
    }

    ref
        .read(FarmLockFormProvider.farmLockForm.notifier)
        .setMainInfoloadingInProgress(false);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenList(
      body: _body(context, ref, pool),
      bodyVerticalAlignment: Alignment.topCenter,
    );
  }

  Widget _body(BuildContext context, WidgetRef ref, DexPool? pool) {
    final farmLockForm = ref.watch(FarmLockFormProvider.farmLockForm);
    final session = ref.watch(SessionProviders.session);
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
              pool: pool,
              farmLock: farmLockForm.farmLock,
              sortCriteria: currentSortedColumn,
            ),
            const SizedBox(
              height: 5,
            ),
            if (session.isConnected)
              FarmLockBlockListHeader(
                onSort: sortData,
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
                    if (farmLockForm.farm != null)
                      FarmLockBlockListSingleLineLegacy(
                        farm: farmLockForm.farm!,
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
                          farmLock: farmLock!,
                          farmLockUserInfos: userInfo,
                          currentSortedColumn: currentSortedColumn,
                        );
                      }).toList(),
                    const SizedBox(
                      height: 6,
                    ),
                    if (farmLockForm.pool != null)
                      Padding(
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
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
