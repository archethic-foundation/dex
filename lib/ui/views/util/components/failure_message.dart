/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';

class FailureMessage {
  const FailureMessage({
    required this.context,
    this.failure,
  });

  final aedappfm.Failure? failure;
  final BuildContext context;

  String getMessage() {
    if (failure == null) return '';

    if (failure is aedappfm.UserRejected) {
      return AppLocalizations.of(context)!.aeswap_failureUserRejected;
    }

    if (failure is aedappfm.ConnectivityArchethic) {
      if (kIsWeb == true) {
        if (BrowserUtil().isBraveBrowser()) {
          return AppLocalizations.of(context)!
              .aeswap_failureConnectivityArchethicBrave;
        }
      }
      return AppLocalizations.of(context)!.aeswap_failureConnectivityArchethic;
    }

    if (failure is aedappfm.Timeout) {
      return AppLocalizations.of(context)!.aeswap_failureTimeout;
    }

    if (failure is aedappfm.PoolAlreadyExists) {
      return AppLocalizations.of(context)!.aeswap_failurePoolAlreadyExists;
    }

    if (failure is aedappfm.PoolNotExists) {
      return AppLocalizations.of(context)!.aeswap_failurePoolNotExists;
    }

    if (failure is aedappfm.InsufficientFunds) {
      return AppLocalizations.of(context)!.aeswap_failureInsufficientFunds;
    }

    if (failure is aedappfm.WrongNetwork) {
      return (failure! as aedappfm.WrongNetwork).cause;
    }

    if (failure is aedappfm.LPTokenAmountExceedBalance) {
      return AppLocalizations.of(context)!.aeswap_lpTokenAmountExceedBalance;
    }

    if (failure is aedappfm.OtherFailure) {
      return (failure! as aedappfm.OtherFailure).cause.toString();
    }

    if (failure is aedappfm.IncompatibleBrowser) {
      return AppLocalizations.of(context)!.aeswap_failureIncompatibleBrowser;
    }

    return failure.toString();
  }
}
