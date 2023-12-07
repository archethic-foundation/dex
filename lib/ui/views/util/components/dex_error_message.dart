/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/info_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DexErrorMessage extends ConsumerWidget {
  const DexErrorMessage({
    this.failure,
    super.key,
  });

  final Failure? failure;

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
        child: InfoBanner(
          FailureMessage(
            context: context,
            failure: failure,
          ).getMessage(),
          InfoBannerType.error,
        ),
      ),
    );
  }
}
