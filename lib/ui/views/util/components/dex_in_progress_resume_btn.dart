/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/failures.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class DexInProgressResumeBtn extends StatelessWidget {
  const DexInProgressResumeBtn({
    required this.isProcessInProgress,
    required this.currentStep,
    required this.onPressed,
    this.failure,
    super.key,
  });

  final bool isProcessInProgress;
  final int currentStep;
  final VoidCallback onPressed;
  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    if (isProcessInProgress == false && failure != null && currentStep > 0) {
      return aedappfm.AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_resume,
        onPressed: onPressed,
      );
    }
    return const SizedBox.shrink();
  }
}
