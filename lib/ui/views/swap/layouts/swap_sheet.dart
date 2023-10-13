/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/swap/bloc/state.dart';
import 'package:aedex/ui/views/swap/layouts/components/swap_form_sheet.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';

class SwapSheet extends ConsumerWidget {
  const SwapSheet({
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

    return Align(
      child: Container(
        decoration: BoxDecoration(
          gradient: DexThemeBase.gradientSheetBackground,
          border: GradientBoxBorder(
            gradient: DexThemeBase.gradientSheetBorder,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: const BoxConstraints(minHeight: 450, maxHeight: 500),
        width: 500,
        child: LayoutBuilder(
          builder: (context, constraint) {
            return ArchethicScrollbar(
              child: Container(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: const IntrinsicHeight(
                  child: Column(
                    children: [
                      Expanded(child: SwapFormSheet()),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
