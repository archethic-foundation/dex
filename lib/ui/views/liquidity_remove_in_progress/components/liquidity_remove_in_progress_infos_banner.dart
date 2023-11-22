/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/info_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveInProgressInfosBanner extends ConsumerWidget {
  const LiquidityRemoveInProgressInfosBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);

    if (liquidityRemove.failure != null) {
      return InfoBanner(
        FailureMessage(
          context: context,
          failure: liquidityRemove.failure,
        ).getMessage(),
        InfoBannerType.error,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (liquidityRemove.walletConfirmation == true) {
      return InfoBanner(
        AppLocalizations.of(context)!.liquidityRemoveInProgressConfirmAEWallet,
        InfoBannerType.request,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (liquidityRemove.failure == null &&
        liquidityRemove.isProcessInProgress == false) {
      return InfoBanner(
        AppLocalizations.of(context)!.liquidityRemoveSuccessInfo,
        InfoBannerType.success,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    return InfoBanner(
      AppLocalizations.of(context)!.liquidityRemoveProcessInProgress,
      InfoBannerType.request,
      width: MediaQuery.of(context).size.width * 0.9,
      waitAnimation: true,
    );
  }
}
