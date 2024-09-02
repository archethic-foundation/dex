import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoVolume extends ConsumerWidget {
  const PoolDetailsInfoVolume({
    super.key,
    required this.volumeAllTime,
    required this.volume24h,
    required this.volume7d,
  });

  final double? volumeAllTime;
  final double? volume24h;
  final double? volume7d;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Opacity(
      opacity: AppTextStyles.kOpacityText,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SelectableText(
                      AppLocalizations.of(context)!.aeswap_time24h,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: SelectableText(
                      AppLocalizations.of(context)!
                          .aeswap_poolDetailsInfoVolume,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              SelectableText(
                volume24h == null
                    ? ''
                    : '\$${volume24h!.formatNumber(precision: volume24h! > 1 ? 2 : 8)}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SelectableText(
                      AppLocalizations.of(context)!.aeswap_timeAll,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: SelectableText(
                      AppLocalizations.of(context)!
                          .aeswap_poolDetailsInfoVolume,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              SelectableText(
                volumeAllTime == null
                    ? ''
                    : '\$${volumeAllTime!.formatNumber(precision: volumeAllTime! > 1 ? 2 : 8)}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(
            width: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SelectableText(
                      AppLocalizations.of(context)!.aeswap_time7d,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: SelectableText(
                      AppLocalizations.of(context)!
                          .aeswap_poolDetailsInfoVolume,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              SelectableText(
                volume7d == null
                    ? ''
                    : '\$${volume7d!.formatNumber(precision: volume7d! > 1 ? 2 : 8)}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
