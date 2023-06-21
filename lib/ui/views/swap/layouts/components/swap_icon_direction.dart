/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenIconDirection extends ConsumerWidget {
  const SwapTokenIconDirection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Iconsax.arrange_circle),
    );
  }
}
