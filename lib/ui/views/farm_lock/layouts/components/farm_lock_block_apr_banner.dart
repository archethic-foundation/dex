import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/block_info.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockBlockAprBanner extends ConsumerWidget {
  const FarmLockBlockAprBanner({
    required this.width,
    required this.height,
    super.key,
  });

  final double width;
  final double height;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLock = ref.watch(farmLockFormFarmLockProvider).value;
    if (farmLock == null || farmLock.isOpen == false) {
      return const SizedBox.shrink();
    }

    final styleBannerText = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: aedappfm.AppThemeBase.secondaryColor,
          fontWeight: FontWeight.w800,
        );

    return BlockInfo(
      blockInfoColor: BlockInfoColor.black,
      info: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${AppLocalizations.of(context)!.farmLockBlockAprLbl}: ',
              style: styleBannerText,
            ),
            if (farmLock.apr3years > 0)
              Text(
                '${(farmLock.apr3years * 100).formatNumber(precision: 2)}%',
                style: styleBannerText,
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Icon(
                  Icons.all_inclusive,
                  size: 16,
                  color: aedappfm.AppThemeBase.secondaryColor,
                ),
              ),
          ],
        ),
      ),
      width: width,
      height: height,
    );
  }
}
