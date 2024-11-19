import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'low_uco_in_dollars_warning_value.g.dart';

@riverpod
double lowUCOInDollarsWarningValue(LowUCOInDollarsWarningValueRef ref) {
  const kLowUCOInDollarsWarningValue = 0.20;

  final archethicOracleUCO =
      ref.watch(aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO);

  if (archethicOracleUCO.usd == 0) {
    // 20 UCO by default if no Oracle
    return 20;
  }

  return (Decimal.parse(kLowUCOInDollarsWarningValue.toString()) /
          Decimal.parse(archethicOracleUCO.usd.toString()))
      .toDouble();
}
