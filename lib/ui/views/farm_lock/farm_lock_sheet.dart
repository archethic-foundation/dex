import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/application/farm/dex_farm_lock.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_block_header.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_block_list_header.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_block_list_single_line_legacy.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_block_list_single_line_lock.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_list.dart';
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
  ConsumerState<FarmLockSheet> createState() => _FarmLockSheetState();
}

class _FarmLockSheetState extends ConsumerState<FarmLockSheet> {
  DexPool? pool;
  DexFarm? farm;
  DexFarmLock? farmLock;
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

  Future<void> loadInfo({bool forceLoadFromBC = false}) async {
    if (mounted) {
      await ref.read(SessionProviders.session.notifier).updateCtxInfo(context);
    }

    pool = await ref.read(
      DexPoolProviders.getPool(
        '0000c94189acdf76cd8d24eab10ef6494800e2f1a16022046b8ecb6ed39bb3c2fa42',
      ).future,
    );

    // TODO(reddwarf03): Remove hardcode
    const farmAddress =
        '000051EDE227815793D9FCB6863BBB645664E174189853057862B9F094698C4C4D7A';
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

    const farmLockAddress =
        '0000a75f253fed4aa1b0b2d9c9e829ba13bbf5a1619610bccf93e97d395b0684fff2';
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

    await ref
        .read(FarmLockFormProvider.farmLockForm.notifier)
        .setFarmLock(farmLock!);
    await ref.read(FarmLockFormProvider.farmLockForm.notifier).initBalances();

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
}

Widget _body(BuildContext context, WidgetRef ref, DexPool? pool) {
  final farmLockForm = ref.watch(FarmLockFormProvider.farmLockForm);

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
          const FarmLockBlockListHeader(),
          const SizedBox(
            height: 6,
          ),
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
                if (farmLockForm.farmLock != null &&
                    farmLockForm.farmLock!.userInfos.isNotEmpty)
                  ...farmLockForm.farmLock!.userInfos.entries.map((entry) {
                    return FarmLockBlockListSingleLineLock(
                      farmLock: farmLockForm.farmLock!,
                      farmLockUserInfos: entry.value,
                    );
                  }).toList(),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // TODO
                          SelectableText(
                            r'1 aeETH = $3600.34 / 1 UCO = $0.02 (6/11/2024 13:59)',
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .fontSize,
                            ),
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
