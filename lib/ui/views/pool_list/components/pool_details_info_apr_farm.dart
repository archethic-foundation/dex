import 'package:aedex/application/farm/dex_farm_lock.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/pool_farm_available.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoAPRFarm extends ConsumerStatefulWidget {
  const PoolDetailsInfoAPRFarm({
    required this.poolAddress,
    super.key,
  });

  final String poolAddress;

  @override
  ConsumerState<PoolDetailsInfoAPRFarm> createState() =>
      PoolDetailsInfoAPRFarmState();
}

class PoolDetailsInfoAPRFarmState
    extends ConsumerState<PoolDetailsInfoAPRFarm> {
  double apr3years = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final env = ref.read(SessionProviders.session).envSelected;
      final contextAddresses =
          PoolFarmAvailableState().getContextAddresses(env);

      final farmLockAddress = contextAddresses.aeETHUCOFarmLockAddress;
      if (farmLockAddress.isNotEmpty) {
        final farmLock = await ref.read(
          DexFarmLockProviders.getFarmLockInfos(
            farmLockAddress,
            widget.poolAddress,
            dexFarmLockInput: DexFarmLock(
              poolAddress: widget.poolAddress,
              farmAddress: farmLockAddress,
            ),
          ).future,
        );
        setState(() {
          apr3years = farmLock!.stats['7']?.aprEstimation ?? 0;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            SelectableText(
              AppLocalizations.of(context)!.poolDetailsInfoAPRFarm3Years,
              style: AppTextStyles.bodyLarge(context),
            ),
          ],
        ),
        if (apr3years == 0)
          Text(
            '__,__%',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                    context,
                    Theme.of(context).textTheme.headlineMedium!,
                  ),
                  color: aedappfm.AppThemeBase.secondaryColor,
                ),
          )
        else
          Text(
            '${(apr3years * 100).formatNumber(precision: 2)}%',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                    context,
                    Theme.of(context).textTheme.headlineMedium!,
                  ),
                  color: aedappfm.AppThemeBase.secondaryColor,
                ),
          ),
      ],
    );
  }
}
