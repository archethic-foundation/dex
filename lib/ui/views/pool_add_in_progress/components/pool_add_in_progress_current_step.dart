/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/usecases/add_pool.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddInProgressCurrentStep extends ConsumerWidget {
  const PoolAddInProgressCurrentStep({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);
    if (poolAdd.token1 == null) {
      return const SizedBox(
        height: 30,
      );
    }

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        AddPoolCase().getAEStepLabel(context, poolAdd.currentStep),
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}
