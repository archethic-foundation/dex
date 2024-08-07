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
          context.go(FarmLockSheet.routerPage);
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

  // TODO(dev): HARDCODED
  ({
    String aeETHUCOPoolAddress,
    String aeETHUCOFarmLegacyAddress,
    String aeETHUCOFarmLockAddress
  }) getContextAddresses(String env) {
    switch (env) {
      case 'devnet':
        return (
          aeETHUCOPoolAddress:
              '0000c94189acdf76cd8d24eab10ef6494800e2f1a16022046b8ecb6ed39bb3c2fa42',
          aeETHUCOFarmLegacyAddress:
              '00008e063dffde69214737c4e9e65b6d9d5776c5369729410ba25dab0950fbcf921e',
          aeETHUCOFarmLockAddress:
              '00007338a899446b8d211bb82b653dfd134cc351dd4060bb926d7d9c7028cf0273bf'
        );
      case 'testnet':
        return (
          aeETHUCOPoolAddress:
              '0000818EF23676779DAE1C97072BB99A3E0DD1C31BAD3787422798DBE3F777F74A43',
          aeETHUCOFarmLegacyAddress:
              '0000208A670B5590939174D65F88140C05DDDBA63C0C920582E12162B22F3985E510',
          aeETHUCOFarmLockAddress:
              '000019FABA71D7E9E626ECBE5B00AF23025C7E90CF77A7338794C132B7D7E61C93A2'
        );
      case 'mainnet':
      default:
        return (
          aeETHUCOPoolAddress:
              '000090C5AFCC97C2357E964E3DDF5BE9948477F7C1DE2C633CDFC95B202970AEA036',
          aeETHUCOFarmLegacyAddress:
              '0000474A5B5D261A86D1EB2B054C8E7D9347767C3977F5FC20BB8A05D6F6AFB53DCC',
          aeETHUCOFarmLockAddress:
              '0000b2339aadf5685b1c8d400c9092c921e51588dc049e097ec9437017e7dded0feb'
        );
    }
  }
}
