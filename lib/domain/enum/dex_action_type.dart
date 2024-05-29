import 'package:flutter/widgets.dart';

enum DexActionType {
  swap,
  addLiquidity,
  removeLiquidity,
  claimFarm,
  depositFarm,
  withdrawFarm,
  addPool
}

extension DexActionTypeExtension on DexActionType {
  String getLabel(BuildContext context) {
    switch (this) {
      case DexActionType.swap:
        return 'Swap';
      case DexActionType.addLiquidity:
        return 'Add liquidity';
      case DexActionType.removeLiquidity:
        return 'Remove liquidity';
      case DexActionType.claimFarm:
        return 'Claim';
      case DexActionType.depositFarm:
        return 'Deposit';
      case DexActionType.withdrawFarm:
        return 'Withdraw';
      case DexActionType.addPool:
        return 'Add Pool';
    }
  }
}
