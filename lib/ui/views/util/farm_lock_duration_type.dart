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
  threeYears,
  max;
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
    case FarmLockDepositDurationType.max:
      return AppLocalizations.of(context)!.farmLockDepositDurationMax;
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

DateTime? getFarmLockDepositDuration(
  FarmLockDepositDurationType farmLockDepositDuration, {
  int numberOfDaysAlreadyUsed = 0,
  // TODO: Init with secondsInDay = 86400
  int secondsInDay = 60,
  DateTime? farmLockEndDate,
}) {
  final dateTimeNow = DateTime.now();
  final simulatedDayDuration = Duration(seconds: secondsInDay);

  switch (farmLockDepositDuration) {
    case FarmLockDepositDurationType.flexible:
      return null;
    case FarmLockDepositDurationType.oneMonth:
      return dateTimeNow
          .add(simulatedDayDuration * (30 - numberOfDaysAlreadyUsed));
    case FarmLockDepositDurationType.oneWeek:
      return dateTimeNow
          .add(simulatedDayDuration * (7 - numberOfDaysAlreadyUsed));
    case FarmLockDepositDurationType.oneYear:
      return dateTimeNow
          .add(simulatedDayDuration * (365 - numberOfDaysAlreadyUsed));
    case FarmLockDepositDurationType.sixMonths:
      return dateTimeNow
          .add(simulatedDayDuration * (180 - numberOfDaysAlreadyUsed));
    case FarmLockDepositDurationType.threeMonths:
      return dateTimeNow
          .add(simulatedDayDuration * (90 - numberOfDaysAlreadyUsed));
    case FarmLockDepositDurationType.threeYears:
      return dateTimeNow
          .add(simulatedDayDuration * (1095 - numberOfDaysAlreadyUsed));
    case FarmLockDepositDurationType.twoYears:
      return dateTimeNow
          .add(simulatedDayDuration * (730 - numberOfDaysAlreadyUsed));
    case FarmLockDepositDurationType.max:
      return farmLockEndDate ?? DateTime.now();
  }
}
