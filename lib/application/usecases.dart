import 'package:aedex/application/api_service.dart';
import 'package:aedex/application/notification.dart';
import 'package:aedex/application/verified_tokens.dart';
import 'package:aedex/domain/usecases/add_liquidity.usecase.dart';
import 'package:aedex/domain/usecases/add_pool.usecase.dart';
import 'package:aedex/domain/usecases/claim_farm.usecase.dart';
import 'package:aedex/domain/usecases/claim_farm_lock.usecase.dart';
import 'package:aedex/domain/usecases/deposit_farm.usecase.dart';
import 'package:aedex/domain/usecases/deposit_farm_lock.usecase.dart';
import 'package:aedex/domain/usecases/level_up_farm_lock.usecase.dart';
import 'package:aedex/domain/usecases/remove_liquidity.usecase.dart';
import 'package:aedex/domain/usecases/swap.usecase.dart';
import 'package:aedex/domain/usecases/withdraw_farm.usecase.dart';
import 'package:aedex/domain/usecases/withdraw_farm_lock.usecase.dart';
import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_deposit/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_level_up/bloc/provider.dart';
import 'package:aedex/ui/views/farm_lock_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/farm_withdraw/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_add/bloc/provider.dart';
import 'package:aedex/ui/views/liquidity_remove/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecases.g.dart';

@Riverpod(keepAlive: true)
AddLiquidityCase addLiquidityCase(
  AddLiquidityCaseRef ref,
) =>
    AddLiquidityCase(
      apiService: ref.watch(apiServiceProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      liquidityAddNotifier: ref.watch(
        liquidityAddFormNotifierProvider.notifier,
      ),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
    );

@Riverpod(keepAlive: true)
AddPoolCase addPoolCase(
  AddPoolCaseRef ref,
) =>
    AddPoolCase(
      apiService: ref.watch(apiServiceProvider),
      poolAddNotifier: ref.watch(poolAddFormNotifierProvider.notifier),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
    );

@Riverpod(keepAlive: true)
ClaimFarmLockCase claimFarmLockCase(
  ClaimFarmLockCaseRef ref,
) =>
    ClaimFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      farmClaimLockNotifier: ref.watch(
        farmLockClaimFormNotifierProvider.notifier,
      ),
      notificationService: ref.watch(NotificationProviders.notificationService),
    );

@Riverpod(keepAlive: true)
ClaimFarmCase claimFarmCase(
  ClaimFarmCaseRef ref,
) =>
    ClaimFarmCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      farmClaimNotifier: ref.watch(farmClaimFormNotifierProvider.notifier),
    );

@Riverpod(keepAlive: true)
DepositFarmLockCase depositFarmLockCase(
  DepositFarmLockCaseRef ref,
) =>
    DepositFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      farmLockDepositNotifier: ref.watch(
        farmLockDepositFormNotifierProvider.notifier,
      ),
    );

@Riverpod(keepAlive: true)
DepositFarmCase depositFarmCase(
  DepositFarmCaseRef ref,
) =>
    DepositFarmCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      farmDepositNotifier: ref.watch(farmDepositFormNotifierProvider.notifier),
    );

@Riverpod(keepAlive: true)
LevelUpFarmLockCase levelUpFarmLockCase(
  LevelUpFarmLockCaseRef ref,
) =>
    LevelUpFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      farmLevelUpNotifier:
          ref.watch(farmLockLevelUpFormNotifierProvider.notifier),
    );

@Riverpod(keepAlive: true)
RemoveLiquidityCase removeLiquidityCase(
  RemoveLiquidityCaseRef ref,
) =>
    RemoveLiquidityCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      liquidityRemoveNotifier: ref.watch(
        liquidityRemoveFormNotifierProvider.notifier,
      ),
    );

@Riverpod(keepAlive: true)
SwapCase swapCase(
  SwapCaseRef ref,
) =>
    SwapCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      swapNotifier: ref.watch(swapFormNotifierProvider.notifier),
    );

@Riverpod(keepAlive: true)
WithdrawFarmLockCase withdrawFarmLockCase(
  WithdrawFarmLockCaseRef ref,
) =>
    WithdrawFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      farmLockWithdrawNotifier: ref.watch(
        farmLockWithdrawFormNotifierProvider.notifier,
      ),
    );

@Riverpod(keepAlive: true)
WithdrawFarmCase withdrawFarmCase(
  WithdrawFarmCaseRef ref,
) =>
    WithdrawFarmCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      farmWithdrawNotifier: ref.watch(
        farmWithdrawFormNotifierProvider.notifier,
      ),
    );
