import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider_item.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolRefreshIcon extends ConsumerWidget {
  const PoolRefreshIcon({
    required this.poolAddress,
    super.key,
  });

  final String poolAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRefreshSuccess =
        ref.watch(PoolItemProvider.poolItem(poolAddress)).refreshInProgress;
    return InkWell(
      onTap: () async {
        if (isRefreshSuccess) return;
        ref
            .read(PoolItemProvider.poolItem(poolAddress).notifier)
            .setRefreshInProgress(true);

        ref.invalidate(DexPoolProviders.getPool(poolAddress));
        final poolListForm = ref.read(
          PoolListFormProvider.poolListForm,
        );
        await ref
            .read(PoolListFormProvider.poolListForm.notifier)
            .setPoolsToDisplay(
              tabIndexSelected: poolListForm.tabIndexSelected,
              cancelToken: UniqueKey().toString(),
            );

        await Future.delayed(const Duration(seconds: 3));
        ref
            .read(PoolItemProvider.poolItem(poolAddress).notifier)
            .setRefreshInProgress(false);
      },
      child: Tooltip(
        message: AppLocalizations.of(context)!.poolRefreshIconTooltip,
        child: SizedBox(
          height: 40,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: aedappfm.ArchethicThemeBase.brightPurpleHoverBorder
                    .withOpacity(1),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            color: isRefreshSuccess
                ? aedappfm.ArchethicThemeBase.systemPositive600
                : aedappfm.ArchethicThemeBase.brightPurpleHoverBackground
                    .withOpacity(1),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              child: Icon(
                isRefreshSuccess ? Icons.check : aedappfm.Iconsax.refresh,
                size: 16,
                color: isRefreshSuccess ? Colors.white : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
