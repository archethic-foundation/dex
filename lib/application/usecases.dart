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

@Riverpod(keepAlive: true)
AddLiquidityCase addLiquidityCase(
  AddLiquidityCaseRef ref,
) =>
    AddLiquidityCase(
      apiService: ref.watch(apiServiceProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      dappClient: ref.watch(dappClientProvider),
    );

@Riverpod(keepAlive: true)
AddPoolCase addPoolCase(
  AddPoolCaseRef ref,
) =>
    AddPoolCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      dappClient: ref.watch(dappClientProvider),
    );

@Riverpod(keepAlive: true)
ClaimFarmLockCase claimFarmLockCase(
  ClaimFarmLockCaseRef ref,
) =>
    ClaimFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@Riverpod(keepAlive: true)
ClaimFarmCase claimFarmCase(
  ClaimFarmCaseRef ref,
) =>
    ClaimFarmCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@Riverpod(keepAlive: true)
DepositFarmLockCase depositFarmLockCase(
  DepositFarmLockCaseRef ref,
) =>
    DepositFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@Riverpod(keepAlive: true)
DepositFarmCase depositFarmCase(
  DepositFarmCaseRef ref,
) =>
    DepositFarmCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@Riverpod(keepAlive: true)
LevelUpFarmLockCase levelUpFarmLockCase(
  LevelUpFarmLockCaseRef ref,
) =>
    LevelUpFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@Riverpod(keepAlive: true)
RemoveLiquidityCase removeLiquidityCase(
  RemoveLiquidityCaseRef ref,
) =>
    RemoveLiquidityCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@Riverpod(keepAlive: true)
SwapCase swapCase(
  SwapCaseRef ref,
) =>
    SwapCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@Riverpod(keepAlive: true)
WithdrawFarmLockCase withdrawFarmLockCase(
  WithdrawFarmLockCaseRef ref,
) =>
    WithdrawFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );

@Riverpod(keepAlive: true)
WithdrawFarmCase withdrawFarmCase(
  WithdrawFarmCaseRef ref,
) =>
    WithdrawFarmCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: ref.watch(dappClientProvider),
    );
