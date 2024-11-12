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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecases.g.dart';

@riverpod
AddLiquidityCase addLiquidityCase(
  Ref ref,
) {
  final dappClientAsync = ref.watch(dappClientProvider);

  return dappClientAsync.when(
    data: (dappClient) => AddLiquidityCase(
      apiService: ref.watch(apiServiceProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      dappClient: dappClient,
    ),
    loading: () => throw UnimplementedError('Dapp client is loading'),
    error: (error, stack) =>
        throw UnimplementedError('Failed to load dapp client'),
  );
}

@riverpod
AddPoolCase addPoolCase(
  Ref ref,
) {
  final dappClientAsync = ref.watch(dappClientProvider);

  return dappClientAsync.when(
    data: (dappClient) => AddPoolCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      dappClient: dappClient,
    ),
    loading: () => throw UnimplementedError('Dapp client is loading'),
    error: (error, stack) =>
        throw UnimplementedError('Failed to load dapp client'),
  );
}

@riverpod
ClaimFarmLockCase claimFarmLockCase(
  Ref ref,
) {
  final dappClientAsync = ref.watch(dappClientProvider);

  return dappClientAsync.when(
    data: (dappClient) => ClaimFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: dappClient,
    ),
    loading: () => throw UnimplementedError('Dapp client is loading'),
    error: (error, stack) =>
        throw UnimplementedError('Failed to load dapp client'),
  );
}

@riverpod
ClaimFarmCase claimFarmCase(
  Ref ref,
) {
  final dappClientAsync = ref.watch(dappClientProvider);

  return dappClientAsync.when(
    data: (dappClient) => ClaimFarmCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: dappClient,
    ),
    loading: () => throw UnimplementedError('Dapp client is loading'),
    error: (error, stack) =>
        throw UnimplementedError('Failed to load dapp client'),
  );
}

@riverpod
DepositFarmLockCase depositFarmLockCase(
  Ref ref,
) {
  final dappClientAsync = ref.watch(dappClientProvider);

  return dappClientAsync.when(
    data: (dappClient) => DepositFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: dappClient,
    ),
    loading: () => throw UnimplementedError('Dapp client is loading'),
    error: (error, stack) =>
        throw UnimplementedError('Failed to load dapp client'),
  );
}

@riverpod
DepositFarmCase depositFarmCase(
  Ref ref,
) {
  final dappClientAsync = ref.watch(dappClientProvider);

  return dappClientAsync.when(
    data: (dappClient) => DepositFarmCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: dappClient,
    ),
    loading: () => throw UnimplementedError('Dapp client is loading'),
    error: (error, stack) =>
        throw UnimplementedError('Failed to load dapp client'),
  );
}

@riverpod
LevelUpFarmLockCase levelUpFarmLockCase(
  Ref ref,
) {
  final dappClientAsync = ref.watch(dappClientProvider);

  return dappClientAsync.when(
    data: (dappClient) => LevelUpFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: dappClient,
    ),
    loading: () => throw UnimplementedError('Dapp client is loading'),
    error: (error, stack) =>
        throw UnimplementedError('Failed to load dapp client'),
  );
}

@riverpod
RemoveLiquidityCase removeLiquidityCase(
  Ref ref,
) {
  final dappClientAsync = ref.watch(dappClientProvider);

  return dappClientAsync.when(
    data: (dappClient) => RemoveLiquidityCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: dappClient,
    ),
    loading: () => throw UnimplementedError('Dapp client is loading'),
    error: (error, stack) =>
        throw UnimplementedError('Failed to load dapp client'),
  );
}

@riverpod
SwapCase swapCase(
  Ref ref,
) {
  final dappClientAsync = ref.watch(dappClientProvider);

  return dappClientAsync.when(
    data: (dappClient) => SwapCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: dappClient,
    ),
    loading: () => throw UnimplementedError('Dapp client is loading'),
    error: (error, stack) =>
        throw UnimplementedError('Failed to load dapp client'),
  );
}

@riverpod
WithdrawFarmLockCase withdrawFarmLockCase(
  Ref ref,
) {
  final dappClientAsync = ref.watch(dappClientProvider);

  return dappClientAsync.when(
    data: (dappClient) => WithdrawFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: dappClient,
    ),
    loading: () => throw UnimplementedError('Dapp client is loading'),
    error: (error, stack) =>
        throw UnimplementedError('Failed to load dapp client'),
  );
}

@riverpod
WithdrawFarmCase withdrawFarmCase(
  Ref ref,
) {
  final dappClientAsync = ref.watch(dappClientProvider);

  return dappClientAsync.when(
    data: (dappClient) => WithdrawFarmCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      dappClient: dappClient,
    ),
    loading: () => throw UnimplementedError('Dapp client is loading'),
    error: (error, stack) =>
        throw UnimplementedError('Failed to load dapp client'),
  );
}
