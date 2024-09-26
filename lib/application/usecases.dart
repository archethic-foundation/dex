import 'package:aedex/application/api_service.dart';
import 'package:aedex/application/dapp_client.dart';
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
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecases.g.dart';

@riverpod
AddLiquidityCase addLiquidityCase(
  AddLiquidityCaseRef ref,
) =>
    AddLiquidityCase(
      apiService: ref.watch(apiServiceProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      dappClient: ref.watch(dappClientProvider),
    );

@riverpod
AddPoolCase addPoolCase(
  AddPoolCaseRef ref,
) =>
    AddPoolCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      dappClient: ref.watch(dappClientProvider),
    );

@riverpod
ClaimFarmLockCase claimFarmLockCase(
  ClaimFarmLockCaseRef ref,
) =>
    ClaimFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@riverpod
ClaimFarmCase claimFarmCase(
  ClaimFarmCaseRef ref,
) =>
    ClaimFarmCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@riverpod
DepositFarmLockCase depositFarmLockCase(
  DepositFarmLockCaseRef ref,
) =>
    DepositFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@riverpod
DepositFarmCase depositFarmCase(
  DepositFarmCaseRef ref,
) =>
    DepositFarmCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@riverpod
LevelUpFarmLockCase levelUpFarmLockCase(
  LevelUpFarmLockCaseRef ref,
) =>
    LevelUpFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@riverpod
RemoveLiquidityCase removeLiquidityCase(
  RemoveLiquidityCaseRef ref,
) =>
    RemoveLiquidityCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@riverpod
SwapCase swapCase(
  SwapCaseRef ref,
) =>
    SwapCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@riverpod
WithdrawFarmLockCase withdrawFarmLockCase(
  WithdrawFarmLockCaseRef ref,
) =>
    WithdrawFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@riverpod
WithdrawFarmCase withdrawFarmCase(
  WithdrawFarmCaseRef ref,
) =>
    WithdrawFarmCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );
