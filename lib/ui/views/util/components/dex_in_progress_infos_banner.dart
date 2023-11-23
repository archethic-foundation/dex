import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/info_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class DexInProgressInfosBanner extends StatelessWidget {
  const DexInProgressInfosBanner({
    required this.isProcessInProgress,
    required this.walletConfirmation,
    this.failure,
    super.key,
  });

  final bool isProcessInProgress;
  final bool walletConfirmation;
  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    if (failure != null) {
      return InfoBanner(
        FailureMessage(
          context: context,
          failure: failure,
        ).getMessage(),
        InfoBannerType.error,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (walletConfirmation == true) {
      return InfoBanner(
        AppLocalizations.of(context)!.poolAddInProgressConfirmAEWallet,
        InfoBannerType.request,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (failure == null && isProcessInProgress == false) {
      return InfoBanner(
        AppLocalizations.of(context)!.poolAddSuccessInfo,
        InfoBannerType.success,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    return InfoBanner(
      AppLocalizations.of(context)!.poolAddProcessInProgress,
      InfoBannerType.request,
      width: MediaQuery.of(context).size.width * 0.9,
      waitAnimation: true,
    );
  }
}
