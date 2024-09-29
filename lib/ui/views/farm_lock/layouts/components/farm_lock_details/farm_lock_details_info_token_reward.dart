import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDetailsInfoTokenReward extends ConsumerWidget {
  const FarmLockDetailsInfoTokenReward({
    super.key,
    required this.farmLock,
  });

  final DexFarmLock farmLock;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Row(
      children: [
        SelectableText(
          '${AppLocalizations.of(context)!.farmDetailsInfoTokenRewardEarn} ${farmLock.rewardToken!.symbol}',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                  context,
                  Theme.of(context).textTheme.headlineSmall!,
                ),
              ),
        ),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: DexTokenIcon(
            tokenAddress: farmLock.rewardToken!.address,
            iconSize: 22,
          ),
        ),
      ],
    );
  }
}
