import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';

class FarmLockHeaderLoadingButton extends StatelessWidget {
  const FarmLockHeaderLoadingButton({
    super.key,
    required this.size,
    required this.text,
  });

  final double size;
  final String text;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            height: size,
            width: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: aedappfm.AppThemeBase.gradient,
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              height: size * 0.6,
              width: size * 0.6,
              child: const CircularProgressIndicator(
                strokeWidth: 0.5,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Opacity(
            opacity: 0.8,
            child: Text(
              text,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ],
      );
}

class FarmLockHeaderButton extends StatelessWidget {
  const FarmLockHeaderButton({
    super.key,
    this.onTap,
    required this.text,
    required this.icon,
    required this.size,
  });

  final VoidCallback? onTap;
  final String text;
  final Icon icon;
  final double size;

  static const sizeSmall = 36.0;
  static const sizeBig = 50.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: size,
            width: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: onTap != null
                  ? aedappfm.AppThemeBase.gradientBtn
                  : aedappfm.AppThemeBase.gradient,
              shape: BoxShape.circle,
            ),
            child: icon,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Opacity(
          opacity: 0.8,
          child: Text(
            text,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
