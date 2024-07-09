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
    if (farmLockForm.farmLock == null) {
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
            Text(
              '${farmLockForm.farmLock!.apr3years.formatNumber(precision: 2)}%',
              style: styleBannerText,
            ),
          ],
        ),
      ),
      width: width,
      height: height,
    );
  }
}
