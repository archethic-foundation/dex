/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DexErrorMessage extends ConsumerWidget {
  const DexErrorMessage({
    this.failure,
    super.key,
  });

  final aedappfm.Failure? failure;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (failure == null) {
      return const SizedBox(
        height: 10,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 40,
        child: aedappfm.InfoBanner(
          FailureMessage(
            context: context,
            failure: failure,
          ).getMessage(),
          aedappfm.InfoBannerType.error,
        ),
      ),
    );
  }
}
