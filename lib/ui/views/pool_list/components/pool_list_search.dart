import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolListSearch extends ConsumerWidget {
  const PoolListSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolListForm = ref.watch(PoolListFormProvider.poolListForm);

    final thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Only pools with liquidity positions'),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 3),
                child: Icon(
                  Iconsax.star,
                  color: ArchethicThemeBase.systemWarning500,
                  size: 14,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 20,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    thumbIcon: thumbIcon,
                    value: poolListForm.onlyPoolsWithLiquidityPositions,
                    onChanged: (value) {
                      ref
                          .read(
                            PoolListFormProvider.poolListForm.notifier,
                          )
                          .setOnlyPoolsWithLiquidityPositions(value);
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Only verified pools'),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 3),
                child: Icon(
                  Iconsax.verify,
                  color: ArchethicThemeBase.systemPositive500,
                  size: 14,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 20,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    thumbIcon: thumbIcon,
                    value: poolListForm.onlyVerifiedPools,
                    onChanged: (value) {
                      ref
                          .read(
                            PoolListFormProvider.poolListForm.notifier,
                          )
                          .setOnlyVerifiedPools(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
