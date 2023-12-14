import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/info_banner.dart';
import 'package:flutter/material.dart';

class DexInProgressInfosBanner extends StatelessWidget {
  const DexInProgressInfosBanner({
    required this.isProcessInProgress,
    required this.walletConfirmation,
    required this.walletConfirmationTxt,
    required this.successTxt,
    required this.inProgressTxt,
    this.failure,
    super.key,
  });

  final bool isProcessInProgress;
  final bool walletConfirmation;
  final Failure? failure;
  final String walletConfirmationTxt;
  final String successTxt;
  final String inProgressTxt;

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
        walletConfirmationTxt,
        InfoBannerType.request,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (failure == null && isProcessInProgress == false) {
      return InfoBanner(
        successTxt,
        InfoBannerType.success,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    return InfoBanner(
      inProgressTxt,
      InfoBannerType.request,
      width: MediaQuery.of(context).size.width * 0.9,
      waitAnimation: true,
    );
  }
}
