/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/info_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddErrorMessage extends ConsumerWidget {
  const PoolAddErrorMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);
    if (poolAdd.failure == null) {
      return const SizedBox(height: 40);
    }

    return SizedBox(
      height: 40,
      child: InfoBanner(
        FailureMessage(
          context: context,
          failure: poolAdd.failure,
        ).getMessage(),
        InfoBannerType.error,
      ),
    );
  }
}
