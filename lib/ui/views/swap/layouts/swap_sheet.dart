/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/bloc/state.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_form_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapSheet extends ConsumerWidget {
  const SwapSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        SwapFormProvider.initialSwapForm.overrideWithValue(
          const SwapFormState(),
        ),
      ],
      child: const SwapSheetBody(),
    );
  }
}

class SwapSheetBody extends ConsumerWidget {
  const SwapSheetBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SwapFormState>(
      SwapFormProvider.swapForm,
      (_, addWebsite) {
        if (addWebsite.isControlsOk) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
            content: Text(
              addWebsite.errorText,
              style: Theme.of(context).snackBarTheme.contentTextStyle,
            ),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: AppLocalizations.of(context)!.ok,
              onPressed: () {},
            ),
          ),
        );

        ref.read(SwapFormProvider.swapForm.notifier).setError(
              '',
            );
      },
    );

    return const SwapFormSheet();
  }
}
