import 'package:aedex/application/balance.dart';
import 'package:aedex/application/pool/dex_pool.dart';
import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_list/bloc/state_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolItemNotifier
    extends AutoDisposeFamilyNotifier<PoolItemState, String> {
  PoolItemNotifier();

  @override
  PoolItemState build(String arg) {
    return PoolItemState(
      poolAddress: arg,
    );
  }

  // ignore: use_setters_to_change_properties
  Future<void> setPool(DexPool pool) async {
    final stats = ref.read(DexPoolProviders.estimateStats(pool));
    //
    var lpTokenInUserBalance = false;
    final userBalance =
        await ref.read(BalanceProviders.getUserTokensBalance.future);
    if (userBalance != null) {
      for (final userTokensBalance in userBalance.token) {
        if (pool.lpToken.address!.toUpperCase() ==
            userTokensBalance.address!.toUpperCase()) {
          lpTokenInUserBalance = true;
        }
      }
    }

    final poolUpdated = pool.copyWith(
      lpTokenInUserBalance: lpTokenInUserBalance,
    );

    state = state.copyWith(
      pool: poolUpdated,
      fee24h: stats.fee24h,
      feeAllTime: stats.feeAllTime,
      volume24h: stats.volume24h,
      volumeAllTime: stats.volumeAllTime,
    );
  }

  void setRefreshInProgress(bool refreshInProgress) {
    state = state.copyWith(refreshInProgress: refreshInProgress);
  }
}

abstract class PoolItemProvider {
  static final poolItem = NotifierProvider.autoDispose
      .family<PoolItemNotifier, PoolItemState, String>(
    PoolItemNotifier.new,
  );
}
