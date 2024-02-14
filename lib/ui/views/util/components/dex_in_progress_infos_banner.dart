import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
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
      return aedappfm.InfoBanner(
        FailureMessage(
          context: context,
          failure: failure,
        ).getMessage(),
        aedappfm.InfoBannerType.error,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (walletConfirmation == true) {
      return aedappfm.InfoBanner(
        walletConfirmationTxt,
        aedappfm.InfoBannerType.request,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (failure == null && isProcessInProgress == false) {
      return aedappfm.InfoBanner(
        successTxt,
        aedappfm.InfoBannerType.success,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    return aedappfm.InfoBanner(
      inProgressTxt,
      aedappfm.InfoBannerType.request,
      width: MediaQuery.of(context).size.width * 0.9,
      waitAnimation: true,
    );
  }
}
