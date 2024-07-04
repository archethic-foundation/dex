import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

enum FarmLockDepositDurationType {
  flexible,
  oneWeek,
  oneMonth,
  threeMonths,
  sixMonths,
  oneYear,
  twoYears,
  threeYears;
}

String getFarmLockDepositDurationTypeLabel(
  BuildContext context,
  FarmLockDepositDurationType farmLockDepositDuration,
) {
  switch (farmLockDepositDuration) {
    case FarmLockDepositDurationType.flexible:
      return AppLocalizations.of(context)!.farmLockDepositDurationFlexible;
    case FarmLockDepositDurationType.oneMonth:
      return AppLocalizations.of(context)!.farmLockDepositDurationOneMonth;
    case FarmLockDepositDurationType.oneWeek:
      return AppLocalizations.of(context)!.farmLockDepositDurationOneWeek;
    case FarmLockDepositDurationType.oneYear:
      return AppLocalizations.of(context)!.farmLockDepositDurationOneYear;
    case FarmLockDepositDurationType.sixMonths:
      return AppLocalizations.of(context)!.farmLockDepositDurationSixMonths;
    case FarmLockDepositDurationType.threeMonths:
      return AppLocalizations.of(context)!.farmLockDepositDurationThreeMonths;
    case FarmLockDepositDurationType.threeYears:
      return AppLocalizations.of(context)!.farmLockDepositDurationThreeYears;
    case FarmLockDepositDurationType.twoYears:
      return AppLocalizations.of(context)!.farmLockDepositDurationTwoYears;
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
    default:
      return FarmLockDepositDurationType.flexible;
  }
}

DateTime? getFarmLockDepositDuration(
  FarmLockDepositDurationType farmLockDepositDuration, {
  int numberOfDaysAlreadyUsed = 0,
}) {
  final dateTimeNow = DateTime.now();
  switch (farmLockDepositDuration) {
    case FarmLockDepositDurationType.flexible:
      return null;
    case FarmLockDepositDurationType.oneMonth:
      return DateTime(
        dateTimeNow.year,
        dateTimeNow.month,
        dateTimeNow.day + 30 - numberOfDaysAlreadyUsed,
      );
    case FarmLockDepositDurationType.oneWeek:
      return DateTime(
        dateTimeNow.year,
        dateTimeNow.month,
        dateTimeNow.day + 7 - numberOfDaysAlreadyUsed,
      );
    case FarmLockDepositDurationType.oneYear:
      return DateTime(
        dateTimeNow.year,
        dateTimeNow.month,
        dateTimeNow.day + 365 - numberOfDaysAlreadyUsed,
      );
    case FarmLockDepositDurationType.sixMonths:
      return DateTime(
        dateTimeNow.year,
        dateTimeNow.month,
        dateTimeNow.day + 180 - numberOfDaysAlreadyUsed,
      );
    case FarmLockDepositDurationType.threeMonths:
      return DateTime(
        dateTimeNow.year,
        dateTimeNow.month,
        dateTimeNow.day + 90 - numberOfDaysAlreadyUsed,
      );
    case FarmLockDepositDurationType.threeYears:
      return DateTime(
        dateTimeNow.year,
        dateTimeNow.month,
        dateTimeNow.day + 1095 - numberOfDaysAlreadyUsed,
      );
    case FarmLockDepositDurationType.twoYears:
      return DateTime(
        dateTimeNow.year,
        dateTimeNow.month,
        dateTimeNow.day + 730 - numberOfDaysAlreadyUsed,
      );
  }
}
