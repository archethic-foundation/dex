import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
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

    return Row(
      children: [
        const Text('Only verified pools'),
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
    );
  }
}
