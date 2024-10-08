import 'package:aedex/application/pool/dex_pool.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PoolFavoriteIcon extends ConsumerWidget {
  const PoolFavoriteIcon({
    super.key,
    required this.poolAddress,
  });

  final String poolAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite =
        ref.watch(DexPoolProviders.poolFavorite(poolAddress)).value ?? false;
    if (isFavorite) {
      return PoolRemoveFavoriteIcon(
        poolAddress: poolAddress,
      );
    }

    return PoolAddFavoriteIcon(poolAddress: poolAddress);
  }
}

class PoolAddFavoriteIcon extends ConsumerWidget {
  const PoolAddFavoriteIcon({
    required this.poolAddress,
    super.key,
  });

  final String poolAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: ref
          .read(
            DexPoolProviders.poolFavorite(
              poolAddress,
            ).notifier,
          )
          .addToFavorite,
      child: Tooltip(
        message: AppLocalizations.of(context)!.poolAddFavoriteIconTooltip,
        child: SizedBox(
          height: 40,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: aedappfm.ArchethicThemeBase.brightPurpleHoverBorder
                    .withOpacity(1),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            color: aedappfm.ArchethicThemeBase.brightPurpleHoverBackground
                .withOpacity(1),
            child: const Padding(
              padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              child: Icon(
                aedappfm.Iconsax.star,
                size: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PoolRemoveFavoriteIcon extends ConsumerWidget {
  const PoolRemoveFavoriteIcon({
    required this.poolAddress,
    super.key,
  });

  final String poolAddress;

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
                    builder: (buildContext, ref, _) {
                      return Scaffold(
                        backgroundColor: Colors.transparent,
                        body: AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          buttonPadding: EdgeInsets.zero,
                          backgroundColor:
                              aedappfm.AppThemeBase.backgroundPopupColor,
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                          ),
                          content: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .confirmationPopupTitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontSize: aedappfm.Responsive
                                              .fontSizeFromTextStyle(
                                            context,
                                            Theme.of(context)
                                                .textTheme
                                                .titleMedium!,
                                          ),
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .poolRemoveFavoriteIconConfirmation,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: aedappfm.Responsive
                                              .fontSizeFromTextStyle(
                                            context,
                                            Theme.of(context)
                                                .textTheme
                                                .bodyMedium!,
                                          ),
                                        ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 100,
                                  ),
                                  width: MediaQuery.of(context).size.width / 2,
                                  padding: const EdgeInsets.only(
                                    bottom: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: aedappfm.AppButton(
                                          labelBtn: AppLocalizations.of(
                                            context,
                                          )!
                                              .no,
                                          onPressed: () {
                                            context.pop();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: aedappfm.AppButton(
                                          labelBtn: AppLocalizations.of(
                                            context,
                                          )!
                                              .yes,
                                          onPressed: () async {
                                            await ref
                                                .read(
                                                  DexPoolProviders.poolFavorite(
                                                    poolAddress,
                                                  ).notifier,
                                                )
                                                .removeFromFavorite();

                                            context.pop();
                                          },
                                        ),
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
        message: AppLocalizations.of(context)!.poolRemoveFavoriteIconTooltip,
        child: SizedBox(
          height: 40,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: aedappfm.ArchethicThemeBase.brightPurpleHoverBorder
                    .withOpacity(1),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            color: aedappfm.ArchethicThemeBase.brightPurpleHoverBackground
                .withOpacity(1),
            child: const Padding(
              padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              child: Icon(
                aedappfm.Iconsax.star_slash,
                size: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
