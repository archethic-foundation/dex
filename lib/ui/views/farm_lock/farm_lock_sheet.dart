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

  ({
    String aeETHUCOPoolAddress,
    String aeETHUCOFarmLegacyAddress,
    String aeETHUCOFarmLockAddress
  }) _getContextAddresses(WidgetRef ref) {
    final env = ref.read(SessionProviders.session).envSelected;

    switch (env) {
      case 'devnet':
        return (
          aeETHUCOPoolAddress:
              '0000c94189acdf76cd8d24eab10ef6494800e2f1a16022046b8ecb6ed39bb3c2fa42',
          aeETHUCOFarmLegacyAddress:
              '00008e063dffde69214737c4e9e65b6d9d5776c5369729410ba25dab0950fbcf921e',
          aeETHUCOFarmLockAddress:
              '00007338a899446b8d211bb82b653dfd134cc351dd4060bb926d7d9c7028cf0273bf'
        );
      case 'testnet':
        return (
          aeETHUCOPoolAddress:
              '0000818EF23676779DAE1C97072BB99A3E0DD1C31BAD3787422798DBE3F777F74A43',
          aeETHUCOFarmLegacyAddress:
              '000041e393250ddc2178453b673ffdaf69642f35c2cb6339fd0bfa861a281407bed6',
          aeETHUCOFarmLockAddress: ''
        );
      case 'mainnet':
      default:
        return (
          aeETHUCOPoolAddress:
              '000090C5AFCC97C2357E964E3DDF5BE9948477F7C1DE2C633CDFC95B202970AEA036',
          aeETHUCOFarmLegacyAddress:
              '0000474A5B5D261A86D1EB2B054C8E7D9347767C3977F5FC20BB8A05D6F6AFB53DCC',
          aeETHUCOFarmLockAddress: ''
        );
    }
  }

  void sortData(String sortBy) {
    setState(() {
      currentSortedColumn = sortBy;
      sortAscending[sortBy] = !sortAscending[sortBy]!;
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

  Future<void> loadInfo({bool forceLoadFromBC = false}) async {
    if (mounted) {
      await ref.read(SessionProviders.session.notifier).updateCtxInfo(context);
    }

    final contextAddresses = _getContextAddresses(ref);

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
      sortData('level');
    }

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
