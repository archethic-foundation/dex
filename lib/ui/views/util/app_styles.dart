import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle bodyLarge(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
            context,
            Theme.of(context).textTheme.bodyLarge!,
          ),
        );
  }

  static TextStyle bodyLargeSecondaryColor(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: aedappfm.AppThemeBase.secondaryColor,
          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
            context,
            Theme.of(context).textTheme.bodyLarge!,
          ),
        );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
            context,
            Theme.of(context).textTheme.bodyMedium!,
          ),
        );
  }
}
