import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _poolAddFormNotifierProvider =
    NotifierProvider.autoDispose<PoolAddFormNotifier, PoolAddFormState>(
  () {
    return PoolAddFormNotifier();
  },
);

class PoolAddFormNotifier extends AutoDisposeNotifier<PoolAddFormState> {
  @override
  PoolAddFormState build() {
    if (sl.isRegistered<EVMWalletProvider>()) {
      sl.unregister<EVMWalletProvider>();
    }
    ref.read(SessionProviders.session.notifier).cancelAllWalletsConnection();

    return const PoolAddFormState();
  }

  Future<void> setContractAddress(String htlcAddress) async {
    state = state.copyWith(htlcAddress: htlcAddress);
    await setStatus();
  }

  Future<void> setStatus() async {
    if (state.evmWallet == null || state.evmWallet!.isConnected == false) {
      return;
    }

    state = state.copyWith(
      poolAddTxAddress: null,
      isAlreadyPoolAdded: false,
      isAlreadyWithdrawn: false,
    );

    final chainId = sl.get<EVMWalletProvider>().currentChain ?? 0;

    if (await control()) {
      final evmHTLC = EVMHTLC(
        state.evmWallet!.providerEndpoint,
        state.htlcAddress,
        chainId,
      );

      int? status;
      try {
        status = await evmHTLC.getStatus();
      } catch (e) {
        setFailure(const Failure.notHTLC());
        throw const Failure.notHTLC();
      }
      if (status == 2) {
        final poolAddTxAddress = await evmHTLC.getTxPoolAdd();

        state = state.copyWith(
          poolAddTxAddress: poolAddTxAddress,
          isAlreadyPoolAdded: true,
        );
        return;
      }
      if (status == 1) {
        state = state.copyWith(
          isAlreadyWithdrawn: true,
        );
      }

      final resultLockTime = await evmHTLC.getHTLCLockTimeAndPoolAddState();
      resultLockTime.map(
        success: (locktime) {
          state = state.copyWith(
            htlcDateLock: locktime.dateLockTime,
            htlcCanPoolAdd: locktime.canPoolAdd,
          );
        },
        failure: setFailure,
      );

      final resultAmount = await evmHTLC.getAmount();
      resultAmount.map(
        success: (amount) {
          setAmount(amount);
        },
        failure: setFailure,
      );

      final blockchain = await ref.read(
        BridgeBlockchainsProviders.getBlockchainFromChainId(chainId).future,
      );

      final resultAmountCurrency =
          await evmHTLC.getAmountCurrency(blockchain!.nativeCurrency);
      resultAmountCurrency.map(
        success: (currency) {
          setAmountCurrency(currency);
        },
        failure: setFailure,
      );

      if (state.amountCurrency == 'UCO') {
        final evmHTLCERC = EVMHTLCERC(
          state.evmWallet!.providerEndpoint!,
          state.htlcAddress,
          chainId,
        );
        final resultFee = await evmHTLCERC.getFee();
        resultFee.map(
          success: (fee) {
            setFee(fee);
          },
          failure: setFailure,
        );
      } else {
        final evmHTLCNative = EVMHTLCNative(
          state.evmWallet!.providerEndpoint!,
          state.htlcAddress,
          chainId,
        );
        final resultFee = await evmHTLCNative.getFee();
        resultFee.map(
          success: (fee) {
            setFee(fee);
          },
          failure: setFailure,
        );
      }
    }
  }

  void setWalletConfirmation(
    WalletConfirmationPoolAdd? walletConfirmation,
  ) {
    state = state.copyWith(
      walletConfirmation: walletConfirmation,
    );
  }

  void setFailure(
    Failure? failure,
  ) {
    state = state.copyWith(
      failure: failure,
    );
  }

  void setPoolAddInProgress(bool poolAddInProgress) {
    state = state.copyWith(poolAddInProgress: poolAddInProgress);
  }

  void setAmount(double amount) {
    state = state.copyWith(amount: amount);
  }

  void setAmountCurrency(String amountCurrency) {
    state = state.copyWith(amountCurrency: amountCurrency);
  }

  void setFee(double fee) {
    state = state.copyWith(fee: fee);
  }

  void setPoolAddOk(bool poolAddOk) {
    state = state.copyWith(poolAddOk: poolAddOk);
  }

  void setPoolAddTxAddress(String? poolAddTxAddress) {
    state = state.copyWith(poolAddTxAddress: poolAddTxAddress);
  }

  ({bool result, Failure? failure}) _controlAddress() {
    if (state.htlcAddress.isEmpty) {
      return (
        result: false,
        failure: const Failure.other(cause: 'Please enter a contract address.'),
      );
    }

    try {
      webthree.EthereumAddress.fromHex(state.htlcAddress);
    } catch (e) {
      return (
        result: false,
        failure: const Failure.other(cause: 'Malformated address.'),
      );
    }

    return (result: true, failure: null);
  }

  Future<bool> control() async {
    state = state.copyWith(
      poolAddOk: false,
      poolAddTxAddress: null,
      isAlreadyPoolAdded: false,
      htlcDateLock: null,
      htlcCanPoolAdd: false,
      amount: 0,
      failure: null,
      addressOk: null,
    );

    final controlAddress = _controlAddress();
    if (controlAddress.failure != null) {
      state = state.copyWith(
        failure: controlAddress.failure,
      );
    } else {
      state = state.copyWith(
        addressOk: true,
      );
    }

    return controlAddress.result;
  }

  Future<void> poolAdd(BuildContext context, WidgetRef ref) async {
    //
    if (state.chainId == null) {
      return;
    }

    await RefunEVMCase().run(
      ref,
      state.evmWallet!.providerEndpoint!,
      state.htlcAddress,
      state.chainId!,
    );
  }

  Future<Result<void, Failure>> connectToEVMWallet() async {
    return Result.guard(
      () async {
        var evmWallet = const BridgeWallet();
        evmWallet = evmWallet.copyWith(
          isConnected: false,
          error: '',
        );
        state = state.copyWith(evmWallet: evmWallet);
        final evmWalletProvider = EVMWalletProvider();

        try {
          final currentChainId = await evmWalletProvider.getChainId();
          final bridgeBlockchain = await ref.read(
            BridgeBlockchainsProviders.getBlockchainFromChainId(
              currentChainId,
            ).future,
          );
          await evmWalletProvider.connect(currentChainId);
          if (evmWalletProvider.walletConnected) {
            evmWallet = evmWallet.copyWith(
              wallet: 'evmWallet',
              isConnected: true,
              error: '',
              nameAccount: evmWalletProvider.accountName!,
              genesisAddress: evmWalletProvider.currentAddress!,
              endpoint: bridgeBlockchain!.name,
              providerEndpoint: bridgeBlockchain.providerEndpoint,
            );
            state = state.copyWith(
              evmWallet: evmWallet,
              chainId: currentChainId,
            );
            if (sl.isRegistered<EVMWalletProvider>()) {
              await sl.unregister<EVMWalletProvider>();
            }
            sl.registerLazySingleton<EVMWalletProvider>(
              () => evmWalletProvider,
            );
            await setStatus();
          }
        } catch (e) {
          throw const Failure.connectivityEVM();
        }
      },
    );
  }
}

abstract class PoolAddFormProvider {
  static final poolAddForm = _poolAddFormNotifierProvider;
}
