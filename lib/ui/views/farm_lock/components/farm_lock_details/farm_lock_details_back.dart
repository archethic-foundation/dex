import 'package:aedex/domain/models/dex_farm_lock.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_details/farm_lock_details_info_lp_deposited_level.dart';
import 'package:aedex/ui/views/farm_lock/components/farm_lock_details/farm_lock_details_info_lp_deposited_level_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDetailsBack extends ConsumerStatefulWidget {
  const FarmLockDetailsBack({
    super.key,
    required this.farmLock,
  });

  final DexFarmLock farmLock;

  @override
  FarmDetailsBackState createState() => FarmDetailsBackState();
}

class FarmDetailsBackState extends ConsumerState<FarmLockDetailsBack>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(
    BuildContext context,
  ) {
    super.build(context);

    return Column(
      children: [
        const FarmLockDetailsInfoLPDepositedLeveHeader(),
        const SizedBox(
          height: 5,
        ),
        ...widget.farmLock.stats.entries.map((entry) {
          return FarmLockDetailsInfoLPDepositedLevel(
            farmLock: widget.farmLock,
            level: entry.key,
            farmLockStats: entry.value,
          );
        }).toList(),
      ],
    );
  }
}
