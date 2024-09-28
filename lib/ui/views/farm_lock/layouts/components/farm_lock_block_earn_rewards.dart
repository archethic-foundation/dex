import 'dart:convert';

import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/farm_list/layouts/components/farm_list_item.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock/bloc/state.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_block_apr_banner.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_btn.dart';
import 'package:aedex/ui/views/farm_lock/layouts/components/farm_lock_details/farm_lock_list_item.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/farm_lock_deposit_sheet.dart';
import 'package:aedex/ui/views/mobile_info/layouts/mobile_info.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/block_info.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmLockBlockEarnRewards extends ConsumerWidget {
  const FarmLockBlockEarnRewards({
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

    final farmLockForm = ref.watch(farmLockFormNotifierProvider).value ??
        const FarmLockFormState();

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
              const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: DexTokenIcon(
                  tokenAddress: 'UCO',
                ),
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
          if (farmLockForm.farmLock != null &&
              farmLockForm.farmLock!.startDate != null &&
              farmLockForm.farmLock!.startDate!
                  .isBefore(DateTime.now().toUtc()))
            Opacity(
              opacity: AppTextStyles.kOpacityText,
              child: Text(
                AppLocalizations.of(context)!.farmLockBlockEarnRewardsWarning,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: aedappfm.ArchethicThemeBase.systemWarning500,
                    ),
              ),
            )
          else if (farmLockForm.farmLock != null &&
              farmLockForm.farmLock!.startDate != null)
            Opacity(
              opacity: AppTextStyles.kOpacityText,
              child: Text(
                '${AppLocalizations.of(context)!.farmLockBlockEarnRewardsStartFarm} ${DateFormat.yMd(
                  Localizations.localeOf(context).languageCode,
                ).add_Hm().format(
                      farmLockForm.farmLock!.startDate!.toLocal(),
                    )}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: aedappfm.ArchethicThemeBase.systemWarning500,
                    ),
              ),
            ),
          InkWell(
            onTap: () async {
              final uri = Uri.parse(kURIFarmLockFarmTuto);
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
                    child: FarmLockHeaderButton(
                      icon: const Icon(
                        aedappfm.Iconsax.search_status,
                        size: 18,
                      ),
                      size: FarmLockHeaderButton.sizeSmall,
                      text: AppLocalizations.of(context)!
                          .farmLockBlockEarnRewardsBtnInfosFarmLegacy,
                      onTap: farmLockForm.farm == null
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
                                            key: ValueKey(
                                              farmLockForm.pool!.poolAddress,
                                            ),
                                            farm: farmLockForm.farm!,
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
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.40,
                    child: farmLockForm.mainInfoloadingInProgress == false
                        ? session.isConnected
                            ? _btnConnected(context, ref)
                            : _btnNotConnected(context, ref)
                        : const FarmLockHeaderLoadingButton(
                            size: FarmLockHeaderButton.sizeBig,
                            text: '',
                          ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.30,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: farmLockForm.farmLock == null
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
                                                key: ValueKey(
                                                  farmLockForm
                                                      .pool!.poolAddress,
                                                ),
                                                farmLock:
                                                    farmLockForm.farmLock!,
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
                              gradient: farmLockForm.farmLock == null
                                  ? aedappfm.AppThemeBase.gradient
                                  : aedappfm.AppThemeBase.gradientBtn,
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
    final farmLockForm = ref.watch(farmLockFormNotifierProvider).value ??
        const FarmLockFormState();

    return FarmLockHeaderButton(
      text: farmLockForm.farmLock == null ||
              farmLockForm.farmLock!.isOpen == false
          ? AppLocalizations.of(context)!
              .farmLockBlockEarnRewardsBtnNotAvailable
          : AppLocalizations.of(context)!.farmLockBlockEarnRewardsBtnAdd,
      icon: const Icon(
        aedappfm.Iconsax.import4,
        size: 25,
      ),
      size: FarmLockHeaderButton.sizeBig,
      onTap: farmLockForm.farmLock == null ||
              farmLockForm.farmLock!.isOpen == false
          ? null
          : () async {
              final poolJson = jsonEncode(farmLockForm.pool!.toJson());
              final poolEncoded = Uri.encodeComponent(poolJson);
              final farmLockJson = jsonEncode(farmLockForm.farmLock!.toJson());
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
            },
    );
  }

  Widget _btnNotConnected(BuildContext context, WidgetRef ref) {
    return FarmLockHeaderButton(
      text: AppLocalizations.of(context)!.btn_connect_wallet,
      icon: const Icon(
        aedappfm.Iconsax.wallet_3,
        size: 25,
      ),
      size: FarmLockHeaderButton.sizeBig,
      onTap: () async {
        if (ref.read(sessionNotifierProvider).isConnected == false &&
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
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
              content: SelectableText(
                ref.read(sessionNotifierProvider).error,
                style: Theme.of(context).snackBarTheme.contentTextStyle,
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
    );
  }
}
