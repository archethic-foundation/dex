/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/info_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddInProgressInfosBanner extends ConsumerWidget {
  const LiquidityAddInProgressInfosBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);

    if (liquidityAdd.failure != null) {
      return InfoBanner(
        FailureMessage(
          context: context,
          failure: liquidityAdd.failure,
        ).getMessage(),
        InfoBannerType.error,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (liquidityAdd.walletConfirmation == true) {
      return InfoBanner(
        AppLocalizations.of(context)!.liquidityAddInProgressConfirmAEWallet,
        InfoBannerType.request,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (liquidityAdd.failure == null &&
        liquidityAdd.isProcessInProgress == false) {
      return InfoBanner(
        AppLocalizations.of(context)!.liquidityAddSuccessInfo,
        InfoBannerType.success,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    return InfoBanner(
      AppLocalizations.of(context)!.liquidityAddProcessInProgress,
      InfoBannerType.request,
      width: MediaQuery.of(context).size.width * 0.9,
      waitAnimation: true,
    );
  }
}
