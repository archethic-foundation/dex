import 'dart:convert';

import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_list/components/farm_list_item.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_block_apr_banner.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_details/farm_lock_list_item.dart';
import 'package:aedex/ui/views/farm_lock/farm_lock_sheet.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/farm_lock_deposit_sheet.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/block_info.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockBlockEarnRewards extends ConsumerWidget {
  const FarmLockBlockEarnRewards({
    required this.pool,
    required this.farmLock,
    required this.farm,
    required this.width,
    required this.height,
    required this.sortCriteria,
    super.key,
  });

  final DexPool pool;
  final DexFarmLock? farmLock;
  final DexFarm? farm;
  final double width;
  final double height;
  final String sortCriteria;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(SessionProviders.session);

    final farmLockForm = ref.watch(FarmLockFormProvider.farmLockForm);

    return BlockInfo(
      info: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SelectableText(
                '${AppLocalizations.of(context)!.farmLockBlockEarnRewardsHeader} ',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: aedappfm.AppThemeBase.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SelectableText(
                'UCO',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(
                width: 5,
              ),
              const DexTokenIcon(
                tokenAddress: 'UCO',
              ),
            ],
          ),
          Opacity(
            opacity: AppTextStyles.kOpacityText,
            child: Text(
              AppLocalizations.of(context)!.farmLockBlockEarnRewardsDesc,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          InkWell(
            onTap: () {},
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
                      .farmLockBlockEarnRewardsViewGuideArticle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        color: aedappfm.AppThemeBase.secondaryColor,
                      ),
                ),
              ],
            ),
          ),
          FarmLockBlockAprBanner(
            width: width,
            height: 35,
          ),
          const Spacer(),
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.30,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: farm == null
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
                                              height: 550,
                                              child: FarmListItem(
                                                key: ValueKey(pool.poolAddress),
                                                farm: farm!,
                                                heightCard: 490,
                                                isInPopup: true,
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
                          child: Container(
                            height: 36,
                            width: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: aedappfm.AppThemeBase.gradientBtn,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              aedappfm.Iconsax.search_status,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            AppLocalizations.of(context)!
                                .farmLockBlockEarnRewardsBtnInfosFarmLegacy,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.40,
                    child: farmLockForm.mainInfoloadingInProgress == false
                        ? session.isConnected
                            ? _btnConnected(context, ref)
                            : _btnNotConnected(context, ref)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: aedappfm.AppThemeBase.gradient,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 0.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    ' ',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.30,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: farmLock == null
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
                                              child: FarmLockListItem(
                                                key: ValueKey(pool.poolAddress),
                                                farmLock: farmLock!,
                                                heightCard: 440,
                                                isInPopup: true,
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
                          child: Container(
                            height: 36,
                            width: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: aedappfm.AppThemeBase.gradientBtn,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              aedappfm.Iconsax.search_status,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            AppLocalizations.of(context)!
                                .farmLockBlockEarnRewardsBtnInfosFarmLock,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: farmLock == null || farmLock!.isOpen == false
              ? null
              : () async {
                  final poolJson = jsonEncode(pool.toJson());
                  final poolEncoded = Uri.encodeComponent(poolJson);
                  final farmLockJson = jsonEncode(farmLock!.toJson());
                  final farmLockEncoded = Uri.encodeComponent(farmLockJson);
                  await context.push(
                    Uri(
                      path: FarmLockDepositSheet.routerPage,
                      queryParameters: {
                        'pool': poolEncoded,
                        'farmLock': farmLockEncoded,
                      },
                    ).toString(),
                  );
                  if (context.mounted) {
                    {
                      await context
                          .findAncestorStateOfType<FarmLockSheetState>()
                          ?.loadInfo(sortCriteria: sortCriteria);
                    }
                  }
                },
          child: Column(
            children: [
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: farmLock == null || farmLock!.isOpen == false
                      ? aedappfm.AppThemeBase.gradient
                      : aedappfm.AppThemeBase.gradientBtn,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  aedappfm.Iconsax.import4,
                  size: 25,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Opacity(
                opacity: 0.8,
                child: Text(
                  farmLock == null || farmLock!.isOpen == false
                      ? AppLocalizations.of(context)!
                          .farmLockBlockEarnRewardsBtnNotAvailable
                      : AppLocalizations.of(context)!
                          .farmLockBlockEarnRewardsBtnAdd,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _btnNotConnected(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
                final sessionNotifier =
                    ref.watch(SessionProviders.session.notifier);
                await sessionNotifier.connectToWallet();
                if (ref.read(SessionProviders.session).error.isNotEmpty) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor:
                          Theme.of(context).snackBarTheme.backgroundColor,
                      content: SelectableText(
                        ref.read(SessionProviders.session).error,
                        style: Theme.of(context).snackBarTheme.contentTextStyle,
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
                if (context.mounted) {
                  await sessionNotifier.updateCtxInfo(context);
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
