/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/failures.dart';
import 'package:aedex/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aedex/util/browser_util_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class FailureMessage {
  const FailureMessage({
    required this.context,
    this.failure,
  });

  final Failure? failure;
  final BuildContext context;

  String getMessage() {
    if (failure == null) return '';

    if (failure is UserRejected) {
      return AppLocalizations.of(context)!.failureUserRejected;
    }

    if (failure is ConnectivityArchethic) {
      if (kIsWeb == true) {
        if (BrowserUtil().isBraveBrowser()) {
          return AppLocalizations.of(context)!
              .failureConnectivityArchethicBrave;
        }
      }
      return AppLocalizations.of(context)!.failureConnectivityArchethic;
    }

    if (failure is Timeout) {
      return AppLocalizations.of(context)!.failureTimeout;
    }

    if (failure is PoolAlreadyExists) {
      return AppLocalizations.of(context)!.failurePoolAlreadyExists;
    }

    if (failure is PoolNotExists) {
      return AppLocalizations.of(context)!.failurePoolNotExists;
    }

    if (failure is InsufficientFunds) {
      return AppLocalizations.of(context)!.failureInsufficientFunds;
    }

    if (failure is WrongNetwork) {
      return (failure! as WrongNetwork).cause;
    }

    if (failure is LPTokenAmountExceedBalance) {
      return AppLocalizations.of(context)!.lpTokenAmountExceedBalance;
    }

    if (failure is OtherFailure) {
      return (failure! as OtherFailure).cause.toString();
    }

    if (failure is IncompatibleBrowser) {
      return AppLocalizations.of(context)!.failureIncompatibleBrowser;
    }

    return failure.toString();
  }
}
