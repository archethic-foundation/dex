import 'package:flutter/widgets.dart';
import 'package:aedex/l10n/localizations-aeswap.dart';

enum FarmLockDepositDurationType {
  flexible,
  oneWeek,
  oneMonth,
  threeMonths,
  sixMonths,
  oneYear,
  twoYears,
  threeYears,
  max;
}

String getFarmLockDepositDurationTypeLabel(
  BuildContext context,
  FarmLockDepositDurationType farmLockDepositDuration,
) {
  switch (farmLockDepositDuration) {
    case FarmLockDepositDurationType.flexible:
      return AppLocalizations.of(context)!
          .aeswap_farmLockDepositDurationFlexible;
    case FarmLockDepositDurationType.oneMonth:
      return AppLocalizations.of(context)!
          .aeswap_farmLockDepositDurationOneMonth;
    case FarmLockDepositDurationType.oneWeek:
      return AppLocalizations.of(context)!
          .aeswap_farmLockDepositDurationOneWeek;
    case FarmLockDepositDurationType.oneYear:
      return AppLocalizations.of(context)!
          .aeswap_farmLockDepositDurationOneYear;
    case FarmLockDepositDurationType.sixMonths:
      return AppLocalizations.of(context)!
          .aeswap_farmLockDepositDurationSixMonths;
    case FarmLockDepositDurationType.threeMonths:
      return AppLocalizations.of(context)!
          .aeswap_farmLockDepositDurationThreeMonths;
    case FarmLockDepositDurationType.threeYears:
      return AppLocalizations.of(context)!
          .aeswap_farmLockDepositDurationThreeYears;
    case FarmLockDepositDurationType.twoYears:
      return AppLocalizations.of(context)!
          .aeswap_farmLockDepositDurationTwoYears;
    case FarmLockDepositDurationType.max:
      return AppLocalizations.of(context)!.aeswap_farmLockDepositDurationMax;
  }
}

FarmLockDepositDurationType getFarmLockDepositDurationTypeFromLevel(
  String level,
) {
  switch (level) {
    case '0':
      return FarmLockDepositDurationType.flexible;
    case '1':
      return FarmLockDepositDurationType.oneWeek;
    case '2':
      return FarmLockDepositDurationType.oneMonth;
    case '3':
      return FarmLockDepositDurationType.threeMonths;
    case '4':
      return FarmLockDepositDurationType.sixMonths;
    case '5':
      return FarmLockDepositDurationType.oneYear;
    case '6':
      return FarmLockDepositDurationType.twoYears;
    case '7':
      return FarmLockDepositDurationType.threeYears;
    case 'max':
      return FarmLockDepositDurationType.max;
    default:
      return FarmLockDepositDurationType.flexible;
  }
}
