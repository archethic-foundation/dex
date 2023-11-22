/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/domain/models/failures.dart';
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
      return AppLocalizations.of(context)!.failureConnectivityArchethic;
    }

    if (failure is Timeout) {
      return AppLocalizations.of(context)!.failureTimeout;
    }

    if (failure is PoolAlreadyExists) {
      return AppLocalizations.of(context)!.failurePoolAlreadyExists;
    }

    if (failure is InsufficientFunds) {
      return AppLocalizations.of(context)!.failureInsufficientFunds;
    }

    if (failure is WrongNetwork) {
      return (failure! as WrongNetwork).cause;
    }

    if (failure is OtherFailure) {
      return (failure! as OtherFailure).cause.toString();
    }

    return failure.toString();
  }
}
