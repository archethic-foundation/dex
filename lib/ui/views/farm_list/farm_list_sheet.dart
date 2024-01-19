import 'package:aedex/application/dex_farm.dart';
import 'package:aedex/domain/models/dex_farm.dart';
import 'package:aedex/ui/views/farm_list/components/farm_card.dart';
import 'package:aedex/ui/views/util/generic/responsive.dart';
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
    return Padding(
      padding: const EdgeInsets.all(50),
      child: FutureBuilder<List<DexFarm>>(
        future: ref.watch(
          DexFarmProviders.getFarmList.future,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: Responsive.isDesktop(context) ? 2 : 1,
              children: snapshot.data!.map((farm) {
                return FarmCard(farm: farm);
              }).toList(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
