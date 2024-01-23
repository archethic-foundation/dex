import 'dart:ui';

import 'package:aedex/application/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/farm_list/components/farm_details.dart';
import 'package:aedex/ui/views/util/components/dex_archethic_oracle_uco.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmListSheet extends ConsumerWidget {
  const FarmListSheet({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return ArchethicScrollbar(
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 120, bottom: 100, left: 50, right: 50),
          child: FutureBuilder<List<DexFarm>>(
            future: ref.watch(
              DexFarmProviders.getFarmList.future,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: snapshot.data!.map((farm) {
                    return SizedBox(
                      width: 500,
                      height: 575,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: DexThemeBase.backgroundPopupColor,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                        color: Colors.black.withOpacity(0.4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: FarmDetails(farm: farm),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: DexArchethicOracleUco(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
