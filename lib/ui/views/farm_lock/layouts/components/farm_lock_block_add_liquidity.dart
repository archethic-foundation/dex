import 'dart:convert';

import 'package:aedex/application/app_embedded.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_btn.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/mobile_info/layouts/mobile_info.dart';
import 'package:aedex/ui/views/pool_list/layouts/components/pool_list_item.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/block_info.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmLockBlockAddLiquidity extends ConsumerWidget {
  const FarmLockBlockAddLiquidity({
    required this.width,
    required this.height,
    super.key,
  });

  final double width;
  final double height;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(sessionNotifierProvider);

    final pool = ref.watch(farmLockFormPoolProvider).value;

    return BlockInfo(
      info: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      '${AppLocalizations.of(context)!.farmLockBlockAddLiquidityHeader} ',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: aedappfm.AppThemeBase.secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Row(
                    children: [
                      Tooltip(
                        message: pool?.pair.token1.symbol ?? '--',
                        child: SelectableText(
                          pool?.pair.token1.symbol.reduceSymbol(lengthMax: 6) ??
                              '--',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      SelectableText(
                        '/',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Tooltip(
                        message: pool?.pair.token2.symbol ?? '--',
                        child: SelectableText(
                          pool?.pair.token2.symbol.reduceSymbol(lengthMax: 6) ??
                              '--',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (pool != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: DexPairIcons(
                    token1Address: pool.pair.token1.address,
                    token2Address: pool.pair.token2.address,
                    iconSize: 26,
                  ),
                ),
            ],
          ),
          Opacity(
            opacity: AppTextStyles.kOpacityText,
            child: Text(
              AppLocalizations.of(context)!.farmLockBlockAddLiquidityDesc,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          InkWell(
            onTap: () async {
              final uri = Uri.parse(kURIFarmLockPoolTuto);
              if (!await canLaunchUrl(uri)) return;
              await launchUrl(uri);
            },
            child: Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  size: 12,
                  color: aedappfm.AppThemeBase.secondaryColor,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  AppLocalizations.of(context)!
                      .farmLockBlockAddLiquidityViewGuideArticle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        color: aedappfm.AppThemeBase.secondaryColor,
                      ),
                ),
              ],
            ),
          ),
          const Spacer(),
          if (session.isConnected)
            _btnConnected(context, ref)
          else
            _btnNotConnected(context, ref),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      width: width,
      height: height,
    );
  }

  Widget _btnConnected(BuildContext context, WidgetRef ref) {
    final farm = ref.watch(farmLockFormFarmProvider).value;
    final pool = ref.watch(farmLockFormPoolProvider).value;
    final isLoading = farm == null || pool == null;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.30,
              child: FarmLockHeaderButton(
                text: AppLocalizations.of(context)!
                    .farmLockBlockAddLiquidityBtnInfos,
                icon: const Icon(
                  aedappfm.Iconsax.search_status,
                  size: 18,
                ),
                size: FarmLockHeaderButton.sizeSmall,
                onTap: isLoading
                    ? null
                    : () async {
                        return showDialog<void>(
                          context: context,
                          builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: Scaffold(
                                extendBodyBehindAppBar: true,
                                extendBody: true,
                                backgroundColor:
                                    Colors.transparent.withAlpha(120),
                                body: Align(
                                  child: SizedBox(
                                    width: 550,
                                    height: 500,
                                    child: PoolListItem(
                                      key: ValueKey(
                                        pool.poolAddress,
                                      ),
                                      pool: pool,
                                      heightCard: 440,
                                    )
                                        .animate()
                                        .fade(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                        )
                                        .scale(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.40,
              child: FarmLockHeaderButton(
                icon: const Icon(
                  aedappfm.Iconsax.import4,
                  size: 25,
                ),
                size: FarmLockHeaderButton.sizeBig,
                text: AppLocalizations.of(context)!
                    .farmLockBlockAddLiquidityBtnAdd,
                onTap: isLoading
                    ? null
                    : () async {
                        final poolJson = jsonEncode(pool.toJson());
                        final poolEncoded = Uri.encodeComponent(poolJson);
                        await context.push(
                          Uri(
                            path: LiquidityAddSheet.routerPage,
                            queryParameters: {
                              'pool': poolEncoded,
                            },
                          ).toString(),
                        );
                      },
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.30,
              child: FarmLockHeaderButton(
                icon: const Icon(
                  aedappfm.Iconsax.export4,
                  size: 18,
                ),
                size: FarmLockHeaderButton.sizeSmall,
                text: AppLocalizations.of(context)!
                    .farmLockBlockAddLiquidityBtnWithdraw,
                onTap: isLoading
                    ? null
                    : () async {
                        final poolJson = jsonEncode(pool.toJson());
                        final pairJson = jsonEncode(pool.pair.toJson());
                        final lpTokenJson = jsonEncode(pool.lpToken.toJson());
                        final poolEncoded = Uri.encodeComponent(poolJson);
                        final pairEncoded = Uri.encodeComponent(pairJson);
                        final lpTokenEncoded = Uri.encodeComponent(lpTokenJson);
                        await context.push(
                          Uri(
                            path: LiquidityRemoveSheet.routerPage,
                            queryParameters: {
                              'pool': poolEncoded,
                              'pair': pairEncoded,
                              'lpToken': lpTokenEncoded,
                            },
                          ).toString(),
                        );
                      },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _btnNotConnected(BuildContext context, WidgetRef ref) {
    final isAppEmbedded = ref.watch(isAppEmbeddedProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            InkWell(
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: aedappfm.AppThemeBase.gradientBtn,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  aedappfm.Iconsax.wallet_3,
                  size: 25,
                ),
              ),
              onTap: () async {
                if (ref.read(sessionNotifierProvider).isConnected == false &&
                    isAppEmbedded == false &&
                    context.mounted &&
                    aedappfm.Responsive.isMobile(context)) {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return Scaffold(
                        extendBodyBehindAppBar: true,
                        extendBody: true,
                        backgroundColor: Colors.transparent.withAlpha(120),
                        body: const Align(
                          child: MobileInfoScreen(),
                        ),
                      );
                    },
                  );
                  return;
                }
                if (ref.read(sessionNotifierProvider).error.isNotEmpty) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor:
                          Theme.of(context).snackBarTheme.backgroundColor,
                      content: SelectableText(
                        ref.read(sessionNotifierProvider).error,
                        style: Theme.of(context).snackBarTheme.contentTextStyle,
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Opacity(
              opacity: 0.8,
              child: Text(
                AppLocalizations.of(context)!.btn_connect_wallet,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
