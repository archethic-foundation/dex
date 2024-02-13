// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userInfosHash() => r'e15a1d994f5f6b0a696e6be8289722a437b59e79';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [_userInfos].
@ProviderFor(_userInfos)
const _userInfosProvider = _UserInfosFamily();

/// See also [_userInfos].
class _UserInfosFamily extends Family<AsyncValue<DexFarmUserInfos>> {
  /// See also [_userInfos].
  const _UserInfosFamily();

  /// See also [_userInfos].
  _UserInfosProvider call(
    DexFarm farm,
  ) {
    return _UserInfosProvider(
      farm,
    );
  }

  @override
  _UserInfosProvider getProviderOverride(
    covariant _UserInfosProvider provider,
  ) {
    return call(
      provider.farm,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_userInfosProvider';
}

/// See also [_userInfos].
class _UserInfosProvider extends AutoDisposeFutureProvider<DexFarmUserInfos> {
  /// See also [_userInfos].
  _UserInfosProvider(
    DexFarm farm,
  ) : this._internal(
          (ref) => _userInfos(
            ref as _UserInfosRef,
            farm,
          ),
          from: _userInfosProvider,
          name: r'_userInfosProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userInfosHash,
          dependencies: _UserInfosFamily._dependencies,
          allTransitiveDependencies:
              _UserInfosFamily._allTransitiveDependencies,
          farm: farm,
        );

  _UserInfosProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.farm,
  }) : super.internal();

  final DexFarm farm;

  @override
  Override overrideWith(
    FutureOr<DexFarmUserInfos> Function(_UserInfosRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _UserInfosProvider._internal(
        (ref) => create(ref as _UserInfosRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        farm: farm,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DexFarmUserInfos> createElement() {
    return _UserInfosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _UserInfosProvider && other.farm == farm;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, farm.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _UserInfosRef on AutoDisposeFutureProviderRef<DexFarmUserInfos> {
  /// The parameter `farm` of this provider.
  DexFarm get farm;
}

class _UserInfosProviderElement
    extends AutoDisposeFutureProviderElement<DexFarmUserInfos>
    with _UserInfosRef {
  _UserInfosProviderElement(super.provider);

  @override
  DexFarm get farm => (origin as _UserInfosProvider).farm;
}

String _$balanceHash() => r'4a67a5dc4ae2a54ceaf1a149c68699c2c047f5cc';

/// See also [_balance].
@ProviderFor(_balance)
const _balanceProvider = _BalanceFamily();

/// See also [_balance].
class _BalanceFamily extends Family<AsyncValue<double>> {
  /// See also [_balance].
  const _BalanceFamily();

  /// See also [_balance].
  _BalanceProvider call(
    String? lpTokenAddress,
  ) {
    return _BalanceProvider(
      lpTokenAddress,
    );
  }

  @override
  _BalanceProvider getProviderOverride(
    covariant _BalanceProvider provider,
  ) {
    return call(
      provider.lpTokenAddress,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_balanceProvider';
}

/// See also [_balance].
class _BalanceProvider extends AutoDisposeFutureProvider<double> {
  /// See also [_balance].
  _BalanceProvider(
    String? lpTokenAddress,
  ) : this._internal(
          (ref) => _balance(
            ref as _BalanceRef,
            lpTokenAddress,
          ),
          from: _balanceProvider,
          name: r'_balanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$balanceHash,
          dependencies: _BalanceFamily._dependencies,
          allTransitiveDependencies: _BalanceFamily._allTransitiveDependencies,
          lpTokenAddress: lpTokenAddress,
        );

  _BalanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lpTokenAddress,
  }) : super.internal();

  final String? lpTokenAddress;

  @override
  Override overrideWith(
    FutureOr<double> Function(_BalanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _BalanceProvider._internal(
        (ref) => create(ref as _BalanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lpTokenAddress: lpTokenAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _BalanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _BalanceProvider && other.lpTokenAddress == lpTokenAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lpTokenAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _BalanceRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `lpTokenAddress` of this provider.
  String? get lpTokenAddress;
}

class _BalanceProviderElement extends AutoDisposeFutureProviderElement<double>
    with _BalanceRef {
  _BalanceProviderElement(super.provider);

  @override
  String? get lpTokenAddress => (origin as _BalanceProvider).lpTokenAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
