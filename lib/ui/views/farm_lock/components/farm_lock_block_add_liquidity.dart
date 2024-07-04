import 'dart:convert';

import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/farm_lock/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aedex/ui/views/liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aedex/ui/views/util/components/block_info.dart';
import 'package:aedex/ui/views/util/components/dex_pair_icons.dart';
import 'package:aedex/ui/views/util/components/dex_token_balance.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmLockBlockAddLiquidity extends ConsumerWidget {
  const FarmLockBlockAddLiquidity({
    required this.pool,
    required this.width,
    required this.height,
    super.key,
  });

  final DexPool pool;
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
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  '${AppLocalizations.of(context)!.farmLockBlockAddLiquidityHeader} ',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: aedappfm.AppThemeBase.secondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Tooltip(
                message: pool.pair.token1.symbol,
                child: SelectableText(
                  pool.pair.token1.symbol.reduceSymbol(lengthMax: 6),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              SelectableText(
                '/',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Tooltip(
                message: pool.pair.token2.symbol,
                child: SelectableText(
                  pool.pair.token2.symbol.reduceSymbol(lengthMax: 6),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: DexPairIcons(
                  token1Address: pool.pair.token1.address!,
                  token2Address: pool.pair.token2.address!,
                  iconSize: 14,
                ),
              ),
            ],
          ),
          Text(
            AppLocalizations.of(context)!.farmLockBlockAddLiquidityDesc,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          InkWell(
            onTap: () async {
              // TODO(reddwarf03): Add link to video
              if (!await canLaunchUrl(Uri.parse(''))) return;
              await launchUrl(Uri.parse(''));
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
                      .farmLockBlockAddLiquidityWatchVideoGuide,
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
      bottomWidget: _balanceUser(context, ref),
    );
  }

  Widget _btnConnected(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
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
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Info',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
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
                  aedappfm.Iconsax.import4,
                  size: 25,
                ),
              ),
              onTap: () async {
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
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Add',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        Column(
          children: [
            InkWell(
              child: Container(
                height: 36,
                width: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: aedappfm.AppThemeBase.gradientBtn,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  aedappfm.Iconsax.export4,
                  size: 18,
                ),
              ),
              onTap: () async {
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
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Withdraw',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  Widget _btnNotConnected(BuildContext context, WidgetRef ref) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DexTokenBalance(
            tokenBalance: farmLock.token1Balance,
            token: pool.pair.token1,
            digits: farmLock.token1Balance < 1 ? 8 : 2,
          ),
          DexTokenBalance(
            tokenBalance: farmLock.token2Balance,
            token: pool.pair.token2,
            digits: farmLock.token2Balance < 1 ? 8 : 2,
          ),
        ],
      ),
    );
  }
}