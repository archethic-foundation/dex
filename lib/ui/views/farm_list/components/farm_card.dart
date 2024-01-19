import 'dart:ui';

import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details.dart';
import 'package:flutter/material.dart';

class FarmCard extends StatelessWidget {
  const FarmCard({
    super.key,
    required this.farm,
  });

  final DexFarm farm;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: DexThemeBase.backgroundPopupColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 30,
              left: 20,
              right: 20,
            ),
            child: FarmDetails(farm: farm),
          ),
        ),
      ),
    );
  }
}
