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
    final farmLockForm = ref.watch(FarmLockFormProvider.farmLockForm);
    if (farmLockForm.farmLock == null ||
        farmLockForm.farmLock!.isOpen == false) {
      return const SizedBox.shrink();
    }

    final styleBannerText = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: aedappfm.ArchethicThemeBase.systemPositive100,
        );

    return BlockInfo(
      blockInfoColor: BlockInfoColor.green,
      info: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${AppLocalizations.of(context)!.farmLockBlockAprLbl}: ',
              style: styleBannerText,
            ),
            if (farmLockForm.farmLock!.apr3years > 0)
              Text(
                '${farmLockForm.farmLock!.apr3years.formatNumber(precision: 2)}%',
                style: styleBannerText,
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Icon(
                  Icons.all_inclusive,
                  size: 16,
                  color: aedappfm.ArchethicThemeBase.systemPositive100,
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
