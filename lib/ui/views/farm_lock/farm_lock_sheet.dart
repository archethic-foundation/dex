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

  ({
    String aeETHUCOPoolAddress,
    String aeETHUCOFarmLegacyAddress,
    String aeETHUCOFarmLockAddress
  }) _getContextAddresses(WidgetRef ref) {
    final env = ref.read(SessionProviders.session).envSelected;

    switch (env) {
      case 'testnet':
        return (
          aeETHUCOPoolAddress:
              '0000818EF23676779DAE1C97072BB99A3E0DD1C31BAD3787422798DBE3F777F74A43',
          aeETHUCOFarmLegacyAddress:
              '0000208A670B5590939174D65F88140C05DDDBA63C0C920582E12162B22F3985E510',
          aeETHUCOFarmLockAddress: ''
        );
      case 'devnet':
        return (
          aeETHUCOPoolAddress:
              '0000c94189acdf76cd8d24eab10ef6494800e2f1a16022046b8ecb6ed39bb3c2fa42',
          aeETHUCOFarmLegacyAddress:
              '00003385E6A8443C3B1F64A5C4D383FE31F36AB4C0A348AC6960038A5A2965B380F4',
          aeETHUCOFarmLockAddress:
              '00003fa1487d9b78bdcb2c1fe7012ea9304cfff470dc8d305da7e64895557f69873a'
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
