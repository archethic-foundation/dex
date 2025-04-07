import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'low_uco_in_dollars_warning_value.g.dart';

@riverpod
bool checkLowUCOInDollarsWarningValue(
  Ref ref,
  double balance,
  double amount,
) {
  const kLowUCOInDollarsWarningValue = 0.20;

  final remainingBalanceInUCO =
      (Decimal.parse(balance.toString()) - Decimal.parse(amount.toString()))
          .toDouble();

  final archethicOracleUCO = ref
      .watch(aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO)
      .valueOrNull;

  if (archethicOracleUCO == null || archethicOracleUCO.usd == 0) {
    // 20 UCO by default if no Oracle
    return remainingBalanceInUCO > 20;
  }

  return remainingBalanceInUCO >
      (Decimal.parse(kLowUCOInDollarsWarningValue.toString()) /
              Decimal.parse(archethicOracleUCO.usd.toString()))
          .toDouble();
}
