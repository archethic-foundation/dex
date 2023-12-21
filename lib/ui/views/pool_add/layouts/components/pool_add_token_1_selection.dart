/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/token_selection/token_selection_popup.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class PoolAddToken1Selection extends ConsumerWidget {
  const PoolAddToken1Selection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);

    return Container(
      width: 150,
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ArchethicThemeBase.purple500,
            ArchethicThemeBase.purple500.withOpacity(0.4),
          ],
          stops: const [0, 1],
        ),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              ArchethicThemeBase.plum300,
              ArchethicThemeBase.plum300.withOpacity(0.4),
            ],
            stops: const [0, 1],
          ),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () async {
          ref
              .read(PoolAddFormProvider.poolAddForm.notifier)
              .setTokenFormSelected(1);
          final token = await TokenSelectionPopup.getDialog(
            context,
          );
          if (token == null) return;
          await ref
              .read(PoolAddFormProvider.poolAddForm.notifier)
              .setToken1(token);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                if (poolAdd.token1 == null)
                  Text(
                    AppLocalizations.of(context)!.btn_selectToken,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Row(
                      children: [
                        DexTokenIcon(
                          tokenAddress: poolAdd.token1!.address == null
                              ? 'UCO'
                              : poolAdd.token1!.address!,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, left: 10),
                          child: Text(
                            poolAdd.token1!.symbol,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const Icon(
              Iconsax.search_normal,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
