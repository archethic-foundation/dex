/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/components/app_button.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddRemoveCacheIcon extends ConsumerWidget {
  const PoolAddRemoveCacheIcon({
    required this.poolAddress,
    this.iconSize = 14,
    this.withLabel = false,
    super.key,
  });

  final String poolAddress;
  final double iconSize;
  final bool withLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    return InkWell(
      onTap: () async {
        return showDialog(
          context: context,
          builder: (context) {
            return ScaffoldMessenger(
              key: scaffoldMessengerKey,
              child: Builder(
                builder: (context) {
                  return Consumer(
                    builder: (context, ref, _) {
                      return Scaffold(
                        backgroundColor: Colors.transparent,
                        body: AlertDialog(
                          backgroundColor: DexThemeBase.backgroundPopupColor,
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                          ),
                          content: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .confirmationPopupTitle,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'Remove the pool from favorite tab?',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                    bottom: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppButton(
                                        labelBtn: AppLocalizations.of(
                                          context,
                                        )!
                                            .no,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      AppButton(
                                        labelBtn: AppLocalizations.of(
                                          context,
                                        )!
                                            .yes,
                                        onPressed: () async {
                                          ref.read(
                                            DexPoolProviders
                                                .removePoolFromFavorite(
                                              poolAddress,
                                            ),
                                          );

                                          if (!context.mounted) {
                                            return;
                                          }
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
      child: Tooltip(
        message: 'Remove this pool from my favorites tab',
        child: SizedBox(
          height: 40,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color:
                    ArchethicThemeBase.brightPurpleHoverBorder.withOpacity(1),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            color:
                ArchethicThemeBase.brightPurpleHoverBackground.withOpacity(1),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              child: Icon(
                Iconsax.star_slash,
                size: 16,
                color: ArchethicThemeBase.raspberry200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
