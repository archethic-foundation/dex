import 'package:aedex/ui/views/farm_lock/layouts/farm_lock_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class PoolFarmAvailable extends StatefulWidget {
  const PoolFarmAvailable({
    this.iconSize = 14,
    super.key,
  });

  final double iconSize;

  @override
  PoolFarmAvailableState createState() => PoolFarmAvailableState();
}

class PoolFarmAvailableState extends State<PoolFarmAvailable> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: () {
          context.go(FarmLockSheet.routerPage2);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 2),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 1, end: _isHovered ? 1.1 : 1.0),
            duration: const Duration(milliseconds: 200),
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    aedappfm.ArchethicThemeBase.systemPositive300
                        .withOpacity(0.3),
                    aedappfm.ArchethicThemeBase.systemPositive600
                        .withOpacity(0.3),
                  ],
                  stops: const [0, 1],
                ),
                border: GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: [
                      aedappfm.ArchethicThemeBase.systemPositive100
                          .withOpacity(0.2),
                      aedappfm.ArchethicThemeBase.systemPositive300
                          .withOpacity(0.2),
                    ],
                    stops: const [0, 1],
                  ),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    aedappfm.Responsive.isMobile(context)
                        ? AppLocalizations.of(context)!.poolFarming
                        : AppLocalizations.of(context)!.poolFarmingAvailable,
                    style: TextStyle(
                      color: aedappfm.ArchethicThemeBase.systemPositive100,
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3, left: 5),
                    child: Icon(
                      Icons.arrow_outward,
                      color: aedappfm.ArchethicThemeBase.systemPositive100,
                      size: 14,
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fade(duration: const Duration(milliseconds: 300))
                .scale(duration: const Duration(milliseconds: 300)),
          ),
        ),
      ),
    );
  }
}
