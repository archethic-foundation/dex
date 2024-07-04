import 'dart:convert';

import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_block_apr_banner.dart';
import 'package:aedex/ui/views/farm_lock_deposit/layouts/farm_lock_deposit_sheet.dart';
import 'package:aedex/ui/views/util/components/block_info.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:aedex/ui/views/util/components/dex_token_icon.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockBlockEarnRewards extends ConsumerWidget {
  const FarmLockBlockEarnRewards({
    required this.pool,
    required this.farmLock,
    required this.width,
    required this.height,
    super.key,
  });

  final DexPool pool;
  final DexFarmLock farmLock;
  final double width;
  final double height;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final session = ref.watch(SessionProviders.session);

    return BlockInfo(
      info: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SelectableText(
                '${AppLocalizations.of(context)!.farmLockBlockEarnRewardsHeader} ',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: aedappfm.AppThemeBase.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SelectableText(
                'UCO',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(
                width: 5,
              ),
              const DexTokenIcon(
                tokenAddress: 'UCO',
                iconSize: 14,
              ),
            ],
          ),
          Text(
            AppLocalizations.of(context)!.farmLockBlockEarnRewardsDesc,
            style: Theme.of(context).textTheme.bodyMedium,
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
                      .farmLockBlockEarnRewardsWatchVideoGuide,
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
      bottomWidget: _balanceUser(context, ref),
    );
  }

  Widget _btnConnected(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            final poolJson = jsonEncode(pool.toJson());
            final poolEncoded = Uri.encodeComponent(poolJson);
            final farmLockJson = jsonEncode(farmLock.toJson());
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
          child: Column(
            children: [
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: aedappfm.AppThemeBase.gradientBtn,
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
              const Text(
                'Add',
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _btnNotConnected(BuildContext context, WidgetRef ref) {
    return Row(
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
            Text(
              AppLocalizations.of(context)!.btn_connect_wallet,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  Widget _balanceUser(BuildContext context, WidgetRef ref) {
    final farmLock = ref.watch(FarmLockFormProvider.farmLockForm);

    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
      ),
      child: DexTokenBalance(
        tokenBalance: farmLock.lpTokenBalance,
        token: pool.lpToken,
        digits: farmLock.lpTokenBalance < 1 ? 8 : 2,
      ),
    );
  }
}