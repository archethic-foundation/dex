/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/token_selection/token_selection_popup.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddToken2Selection extends ConsumerWidget {
  const PoolAddToken2Selection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);

    return Container(
      width: 150,
      height: 30,
      decoration: BoxDecoration(
        color: aedappfm.AppThemeBase.sheetBackgroundTertiary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () async {
          ref
              .read(PoolAddFormProvider.poolAddForm.notifier)
              .setTokenFormSelected(2);
          final token = await TokenSelectionPopup.getDialog(
            context,
          );
          if (token == null) return;
          if (context.mounted) {
            await ref
                .read(PoolAddFormProvider.poolAddForm.notifier)
                .setToken2(token, context);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                if (poolAdd.token2 == null)
                  Text(
                    AppLocalizations.of(context)!.btn_selectToken,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          DexTokenIcon(
                            tokenAddress: poolAdd.token2!.address == null
                                ? 'UCO'
                                : poolAdd.token2!.address!,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              poolAdd.token2!.symbol,
                              style: Theme.of(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const Icon(
              aedappfm.Iconsax.search_normal,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
