import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/block_info.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockBlockFarmedTokensSummary extends ConsumerStatefulWidget {
  const FarmLockBlockFarmedTokensSummary({
    required this.width,
    required this.height,
    super.key,
  });

  final double width;
  final double height;

  @override
  FarmLockBlockFarmedTokensSummaryState createState() =>
      FarmLockBlockFarmedTokensSummaryState();
}

class FarmLockBlockFarmedTokensSummaryState
    extends ConsumerState<FarmLockBlockFarmedTokensSummary> {
  @override
  void initState() {
    ref.read(FarmLockFormProvider.farmLockForm.notifier).calculateSummary();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final farmLockForm = ref.watch(FarmLockFormProvider.farmLockForm);

    return BlockInfo(
      info: Column(
        children: [
          Row(
            children: [
              SelectableText(
                AppLocalizations.of(context)!
                    .farmLockBlockFarmedTokensSummaryHeader,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: aedappfm.AppThemeBase.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              SelectableText(
                '\$${farmLockForm.farmedTokensInFiat.formatNumber(precision: 2)}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SelectableText(
                    '${AppLocalizations.of(context)!.farmLockBlockFarmedTokensSummaryCapitalInvestedLbl}: ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SelectableText(
                    '\$${farmLockForm.farmedTokensCapitalInFiat.formatNumber(precision: 2)}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: aedappfm.AppThemeBase.secondaryColor,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SelectableText(
                    '${AppLocalizations.of(context)!.farmLockBlockFarmedTokensSummaryCapitalRewardsEarnedLbl}: ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SelectableText(
                    '\$${farmLockForm.farmedTokensRewardsInFiat.formatNumber(precision: 2)}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: aedappfm.AppThemeBase.secondaryColor,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
      width: widget.width,
      height: widget.height,
      backgroundWidget: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/coin-img.png',
            ),
            fit: BoxFit.fitHeight,
            alignment: Alignment.centerRight,
            opacity: 0.2,
          ),
        ),
      ),
    );
  }
}
