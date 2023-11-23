/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/info_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapInProgressInfosBanner extends ConsumerWidget {
  const SwapInProgressInfosBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);

    if (swap.failure != null) {
      return InfoBanner(
        FailureMessage(
          context: context,
          failure: swap.failure,
        ).getMessage(),
        InfoBannerType.error,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (swap.walletConfirmation == true) {
      return InfoBanner(
        AppLocalizations.of(context)!.swapInProgressConfirmAEWallet,
        InfoBannerType.request,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (swap.failure == null && swap.isProcessInProgress == false) {
      return InfoBanner(
        AppLocalizations.of(context)!.swapSuccessInfo,
        InfoBannerType.success,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    return InfoBanner(
      AppLocalizations.of(context)!.swapProcessInProgress,
      InfoBannerType.request,
      width: MediaQuery.of(context).size.width * 0.9,
      waitAnimation: true,
    );
  }
}
