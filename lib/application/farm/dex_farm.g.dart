// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_farm.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dexFarmRepositoryHash() => r'f295867c279e664b85311f7001dd026c3a2be22f';

/// See also [_dexFarmRepository].
@ProviderFor(_dexFarmRepository)
final _dexFarmRepositoryProvider =
    AutoDisposeProvider<DexFarmRepositoryImpl>.internal(
  _dexFarmRepository,
  name: r'_dexFarmRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dexFarmRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _DexFarmRepositoryRef = AutoDisposeProviderRef<DexFarmRepositoryImpl>;
String _$getFarmInfosHash() => r'b639a5ac7881bc1d2578a3f4b738c4d349ab474c';

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

/// See also [_getFarmInfos].
@ProviderFor(_getFarmInfos)
const _getFarmInfosProvider = _GetFarmInfosFamily();

/// See also [_getFarmInfos].
class _GetFarmInfosFamily extends Family<AsyncValue<DexFarm?>> {
  /// See also [_getFarmInfos].
  const _GetFarmInfosFamily();

  /// See also [_getFarmInfos].
  _GetFarmInfosProvider call(
    String farmGenesisAddress,
    String poolAddress, {
    DexFarm? dexFarmInput,
  }) {
    return _GetFarmInfosProvider(
      farmGenesisAddress,
      poolAddress,
      dexFarmInput: dexFarmInput,
    );
  }

  @override
  _GetFarmInfosProvider getProviderOverride(
    covariant _GetFarmInfosProvider provider,
  ) {
    return call(
      provider.farmGenesisAddress,
      provider.poolAddress,
      dexFarmInput: provider.dexFarmInput,
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
  String? get name => r'_getFarmInfosProvider';
}

/// See also [_getFarmInfos].
class _GetFarmInfosProvider extends AutoDisposeFutureProvider<DexFarm?> {
  /// See also [_getFarmInfos].
  _GetFarmInfosProvider(
    String farmGenesisAddress,
    String poolAddress, {
    DexFarm? dexFarmInput,
  }) : this._internal(
          (ref) => _getFarmInfos(
            ref as _GetFarmInfosRef,
            farmGenesisAddress,
            poolAddress,
            dexFarmInput: dexFarmInput,
          ),
          from: _getFarmInfosProvider,
          name: r'_getFarmInfosProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getFarmInfosHash,
          dependencies: _GetFarmInfosFamily._dependencies,
          allTransitiveDependencies:
              _GetFarmInfosFamily._allTransitiveDependencies,
          farmGenesisAddress: farmGenesisAddress,
          poolAddress: poolAddress,
          dexFarmInput: dexFarmInput,
        );

  _GetFarmInfosProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.farmGenesisAddress,
    required this.poolAddress,
    required this.dexFarmInput,
  }) : super.internal();

  final String farmGenesisAddress;
  final String poolAddress;
  final DexFarm? dexFarmInput;

  @override
  Override overrideWith(
    FutureOr<DexFarm?> Function(_GetFarmInfosRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetFarmInfosProvider._internal(
        (ref) => create(ref as _GetFarmInfosRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        farmGenesisAddress: farmGenesisAddress,
        poolAddress: poolAddress,
        dexFarmInput: dexFarmInput,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DexFarm?> createElement() {
    return _GetFarmInfosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetFarmInfosProvider &&
        other.farmGenesisAddress == farmGenesisAddress &&
        other.poolAddress == poolAddress &&
        other.dexFarmInput == dexFarmInput;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, farmGenesisAddress.hashCode);
    hash = _SystemHash.combine(hash, poolAddress.hashCode);
    hash = _SystemHash.combine(hash, dexFarmInput.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetFarmInfosRef on AutoDisposeFutureProviderRef<DexFarm?> {
  /// The parameter `farmGenesisAddress` of this provider.
  String get farmGenesisAddress;

  /// The parameter `poolAddress` of this provider.
  String get poolAddress;

  /// The parameter `dexFarmInput` of this provider.
  DexFarm? get dexFarmInput;
}

class _GetFarmInfosProviderElement
    extends AutoDisposeFutureProviderElement<DexFarm?> with _GetFarmInfosRef {
  _GetFarmInfosProviderElement(super.provider);

  @override
  String get farmGenesisAddress =>
      (origin as _GetFarmInfosProvider).farmGenesisAddress;
  @override
  String get poolAddress => (origin as _GetFarmInfosProvider).poolAddress;
  @override
  DexFarm? get dexFarmInput => (origin as _GetFarmInfosProvider).dexFarmInput;
}

String _$getUserInfosHash() => r'3d0d27ade16181e5df87c29457886f8c0b1ed239';

/// See also [_getUserInfos].
@ProviderFor(_getUserInfos)
const _getUserInfosProvider = _GetUserInfosFamily();

/// See also [_getUserInfos].
class _GetUserInfosFamily extends Family<AsyncValue<DexFarmUserInfos?>> {
  /// See also [_getUserInfos].
  const _GetUserInfosFamily();

  /// See also [_getUserInfos].
  _GetUserInfosProvider call(
    String farmGenesisAddress,
    String userGenesisAddress,
  ) {
    return _GetUserInfosProvider(
      farmGenesisAddress,
      userGenesisAddress,
    );
  }

  @override
  _GetUserInfosProvider getProviderOverride(
    covariant _GetUserInfosProvider provider,
  ) {
    return call(
      provider.farmGenesisAddress,
      provider.userGenesisAddress,
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
  String? get name => r'_getUserInfosProvider';
}

/// See also [_getUserInfos].
class _GetUserInfosProvider
    extends AutoDisposeFutureProvider<DexFarmUserInfos?> {
  /// See also [_getUserInfos].
  _GetUserInfosProvider(
    String farmGenesisAddress,
    String userGenesisAddress,
  ) : this._internal(
          (ref) => _getUserInfos(
            ref as _GetUserInfosRef,
            farmGenesisAddress,
            userGenesisAddress,
          ),
          from: _getUserInfosProvider,
          name: r'_getUserInfosProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUserInfosHash,
          dependencies: _GetUserInfosFamily._dependencies,
          allTransitiveDependencies:
              _GetUserInfosFamily._allTransitiveDependencies,
          farmGenesisAddress: farmGenesisAddress,
          userGenesisAddress: userGenesisAddress,
        );

  _GetUserInfosProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.farmGenesisAddress,
    required this.userGenesisAddress,
  }) : super.internal();

  final String farmGenesisAddress;
  final String userGenesisAddress;

  @override
  Override overrideWith(
    FutureOr<DexFarmUserInfos?> Function(_GetUserInfosRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetUserInfosProvider._internal(
        (ref) => create(ref as _GetUserInfosRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        farmGenesisAddress: farmGenesisAddress,
        userGenesisAddress: userGenesisAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DexFarmUserInfos?> createElement() {
    return _GetUserInfosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetUserInfosProvider &&
        other.farmGenesisAddress == farmGenesisAddress &&
        other.userGenesisAddress == userGenesisAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, farmGenesisAddress.hashCode);
    hash = _SystemHash.combine(hash, userGenesisAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetUserInfosRef on AutoDisposeFutureProviderRef<DexFarmUserInfos?> {
  /// The parameter `farmGenesisAddress` of this provider.
  String get farmGenesisAddress;

  /// The parameter `userGenesisAddress` of this provider.
  String get userGenesisAddress;
}

class _GetUserInfosProviderElement
    extends AutoDisposeFutureProviderElement<DexFarmUserInfos?>
    with _GetUserInfosRef {
  _GetUserInfosProviderElement(super.provider);

  @override
  String get farmGenesisAddress =>
      (origin as _GetUserInfosProvider).farmGenesisAddress;
  @override
  String get userGenesisAddress =>
      (origin as _GetUserInfosProvider).userGenesisAddress;
}

String _$getFarmListHash() => r'c43313ef288cfce89358dfeb599db2caa09fb027';

/// See also [_getFarmList].
@ProviderFor(_getFarmList)
final _getFarmListProvider = FutureProvider<List<DexFarm>>.internal(
  _getFarmList,
  name: r'_getFarmListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getFarmListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetFarmListRef = FutureProviderRef<List<DexFarm>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
