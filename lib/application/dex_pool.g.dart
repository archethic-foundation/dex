// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_pool.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dexPoolsRepositoryHash() =>
    r'92ac8f739c5b4d8ae9289b01e516779284f976f4';

/// See also [_dexPoolsRepository].
@ProviderFor(_dexPoolsRepository)
final _dexPoolsRepositoryProvider =
    AutoDisposeProvider<DexPoolsRepository>.internal(
  _dexPoolsRepository,
  name: r'_dexPoolsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dexPoolsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _DexPoolsRepositoryRef = AutoDisposeProviderRef<DexPoolsRepository>;
String _$getPoolListHash() => r'84447390879847710a89a99895a95dc084b1209f';

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

/// See also [_getPoolList].
@ProviderFor(_getPoolList)
const _getPoolListProvider = _GetPoolListFamily();

/// See also [_getPoolList].
class _GetPoolListFamily extends Family<AsyncValue<List<DexPool>>> {
  /// See also [_getPoolList].
  const _GetPoolListFamily();

  /// See also [_getPoolList].
  _GetPoolListProvider call(
    bool onlyVerified,
  ) {
    return _GetPoolListProvider(
      onlyVerified,
    );
  }

  @override
  _GetPoolListProvider getProviderOverride(
    covariant _GetPoolListProvider provider,
  ) {
    return call(
      provider.onlyVerified,
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
  String? get name => r'_getPoolListProvider';
}

/// See also [_getPoolList].
class _GetPoolListProvider extends AutoDisposeFutureProvider<List<DexPool>> {
  /// See also [_getPoolList].
  _GetPoolListProvider(
    bool onlyVerified,
  ) : this._internal(
          (ref) => _getPoolList(
            ref as _GetPoolListRef,
            onlyVerified,
          ),
          from: _getPoolListProvider,
          name: r'_getPoolListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPoolListHash,
          dependencies: _GetPoolListFamily._dependencies,
          allTransitiveDependencies:
              _GetPoolListFamily._allTransitiveDependencies,
          onlyVerified: onlyVerified,
        );

  _GetPoolListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.onlyVerified,
  }) : super.internal();

  final bool onlyVerified;

  @override
  Override overrideWith(
    FutureOr<List<DexPool>> Function(_GetPoolListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetPoolListProvider._internal(
        (ref) => create(ref as _GetPoolListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        onlyVerified: onlyVerified,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DexPool>> createElement() {
    return _GetPoolListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetPoolListProvider && other.onlyVerified == onlyVerified;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, onlyVerified.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetPoolListRef on AutoDisposeFutureProviderRef<List<DexPool>> {
  /// The parameter `onlyVerified` of this provider.
  bool get onlyVerified;
}

class _GetPoolListProviderElement
    extends AutoDisposeFutureProviderElement<List<DexPool>>
    with _GetPoolListRef {
  _GetPoolListProviderElement(super.provider);

  @override
  bool get onlyVerified => (origin as _GetPoolListProvider).onlyVerified;
}

String _$getPoolInfosHash() => r'3a338779d5e0a7625005347be5240a889bcb93e4';

/// See also [_getPoolInfos].
@ProviderFor(_getPoolInfos)
const _getPoolInfosProvider = _GetPoolInfosFamily();

/// See also [_getPoolInfos].
class _GetPoolInfosFamily extends Family<AsyncValue<DexPool?>> {
  /// See also [_getPoolInfos].
  const _GetPoolInfosFamily();

  /// See also [_getPoolInfos].
  _GetPoolInfosProvider call(
    String poolGenesisAddress,
  ) {
    return _GetPoolInfosProvider(
      poolGenesisAddress,
    );
  }

  @override
  _GetPoolInfosProvider getProviderOverride(
    covariant _GetPoolInfosProvider provider,
  ) {
    return call(
      provider.poolGenesisAddress,
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
  String? get name => r'_getPoolInfosProvider';
}

/// See also [_getPoolInfos].
class _GetPoolInfosProvider extends AutoDisposeFutureProvider<DexPool?> {
  /// See also [_getPoolInfos].
  _GetPoolInfosProvider(
    String poolGenesisAddress,
  ) : this._internal(
          (ref) => _getPoolInfos(
            ref as _GetPoolInfosRef,
            poolGenesisAddress,
          ),
          from: _getPoolInfosProvider,
          name: r'_getPoolInfosProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPoolInfosHash,
          dependencies: _GetPoolInfosFamily._dependencies,
          allTransitiveDependencies:
              _GetPoolInfosFamily._allTransitiveDependencies,
          poolGenesisAddress: poolGenesisAddress,
        );

  _GetPoolInfosProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.poolGenesisAddress,
  }) : super.internal();

  final String poolGenesisAddress;

  @override
  Override overrideWith(
    FutureOr<DexPool?> Function(_GetPoolInfosRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetPoolInfosProvider._internal(
        (ref) => create(ref as _GetPoolInfosRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        poolGenesisAddress: poolGenesisAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DexPool?> createElement() {
    return _GetPoolInfosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetPoolInfosProvider &&
        other.poolGenesisAddress == poolGenesisAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poolGenesisAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetPoolInfosRef on AutoDisposeFutureProviderRef<DexPool?> {
  /// The parameter `poolGenesisAddress` of this provider.
  String get poolGenesisAddress;
}

class _GetPoolInfosProviderElement
    extends AutoDisposeFutureProviderElement<DexPool?> with _GetPoolInfosRef {
  _GetPoolInfosProviderElement(super.provider);

  @override
  String get poolGenesisAddress =>
      (origin as _GetPoolInfosProvider).poolGenesisAddress;
}

String _$getRatioHash() => r'354f7dc1b45d6a475670dfcda2997a5f86dec992';

/// See also [_getRatio].
@ProviderFor(_getRatio)
const _getRatioProvider = _GetRatioFamily();

/// See also [_getRatio].
class _GetRatioFamily extends Family<AsyncValue<double>> {
  /// See also [_getRatio].
  const _GetRatioFamily();

  /// See also [_getRatio].
  _GetRatioProvider call(
    String poolGenesisAddress,
    DexToken token,
  ) {
    return _GetRatioProvider(
      poolGenesisAddress,
      token,
    );
  }

  @override
  _GetRatioProvider getProviderOverride(
    covariant _GetRatioProvider provider,
  ) {
    return call(
      provider.poolGenesisAddress,
      provider.token,
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
  String? get name => r'_getRatioProvider';
}

/// See also [_getRatio].
class _GetRatioProvider extends AutoDisposeFutureProvider<double> {
  /// See also [_getRatio].
  _GetRatioProvider(
    String poolGenesisAddress,
    DexToken token,
  ) : this._internal(
          (ref) => _getRatio(
            ref as _GetRatioRef,
            poolGenesisAddress,
            token,
          ),
          from: _getRatioProvider,
          name: r'_getRatioProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getRatioHash,
          dependencies: _GetRatioFamily._dependencies,
          allTransitiveDependencies: _GetRatioFamily._allTransitiveDependencies,
          poolGenesisAddress: poolGenesisAddress,
          token: token,
        );

  _GetRatioProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.poolGenesisAddress,
    required this.token,
  }) : super.internal();

  final String poolGenesisAddress;
  final DexToken token;

  @override
  Override overrideWith(
    FutureOr<double> Function(_GetRatioRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetRatioProvider._internal(
        (ref) => create(ref as _GetRatioRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        poolGenesisAddress: poolGenesisAddress,
        token: token,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _GetRatioProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetRatioProvider &&
        other.poolGenesisAddress == poolGenesisAddress &&
        other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poolGenesisAddress.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetRatioRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `poolGenesisAddress` of this provider.
  String get poolGenesisAddress;

  /// The parameter `token` of this provider.
  DexToken get token;
}

class _GetRatioProviderElement extends AutoDisposeFutureProviderElement<double>
    with _GetRatioRef {
  _GetRatioProviderElement(super.provider);

  @override
  String get poolGenesisAddress =>
      (origin as _GetRatioProvider).poolGenesisAddress;
  @override
  DexToken get token => (origin as _GetRatioProvider).token;
}

String _$getPoolListFromCacheHash() =>
    r'4225ea7ad93f71d37c9a1356eb8ba9e7c20d8a8e';

/// See also [_getPoolListFromCache].
@ProviderFor(_getPoolListFromCache)
const _getPoolListFromCacheProvider = _GetPoolListFromCacheFamily();

/// See also [_getPoolListFromCache].
class _GetPoolListFromCacheFamily extends Family<AsyncValue<List<DexPool>>> {
  /// See also [_getPoolListFromCache].
  const _GetPoolListFromCacheFamily();

  /// See also [_getPoolListFromCache].
  _GetPoolListFromCacheProvider call(
    bool onlyVerified,
    bool onlyPoolsWithLiquidityPositions,
  ) {
    return _GetPoolListFromCacheProvider(
      onlyVerified,
      onlyPoolsWithLiquidityPositions,
    );
  }

  @override
  _GetPoolListFromCacheProvider getProviderOverride(
    covariant _GetPoolListFromCacheProvider provider,
  ) {
    return call(
      provider.onlyVerified,
      provider.onlyPoolsWithLiquidityPositions,
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
  String? get name => r'_getPoolListFromCacheProvider';
}

/// See also [_getPoolListFromCache].
class _GetPoolListFromCacheProvider
    extends AutoDisposeFutureProvider<List<DexPool>> {
  /// See also [_getPoolListFromCache].
  _GetPoolListFromCacheProvider(
    bool onlyVerified,
    bool onlyPoolsWithLiquidityPositions,
  ) : this._internal(
          (ref) => _getPoolListFromCache(
            ref as _GetPoolListFromCacheRef,
            onlyVerified,
            onlyPoolsWithLiquidityPositions,
          ),
          from: _getPoolListFromCacheProvider,
          name: r'_getPoolListFromCacheProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPoolListFromCacheHash,
          dependencies: _GetPoolListFromCacheFamily._dependencies,
          allTransitiveDependencies:
              _GetPoolListFromCacheFamily._allTransitiveDependencies,
          onlyVerified: onlyVerified,
          onlyPoolsWithLiquidityPositions: onlyPoolsWithLiquidityPositions,
        );

  _GetPoolListFromCacheProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.onlyVerified,
    required this.onlyPoolsWithLiquidityPositions,
  }) : super.internal();

  final bool onlyVerified;
  final bool onlyPoolsWithLiquidityPositions;

  @override
  Override overrideWith(
    FutureOr<List<DexPool>> Function(_GetPoolListFromCacheRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetPoolListFromCacheProvider._internal(
        (ref) => create(ref as _GetPoolListFromCacheRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        onlyVerified: onlyVerified,
        onlyPoolsWithLiquidityPositions: onlyPoolsWithLiquidityPositions,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DexPool>> createElement() {
    return _GetPoolListFromCacheProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetPoolListFromCacheProvider &&
        other.onlyVerified == onlyVerified &&
        other.onlyPoolsWithLiquidityPositions ==
            onlyPoolsWithLiquidityPositions;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, onlyVerified.hashCode);
    hash = _SystemHash.combine(hash, onlyPoolsWithLiquidityPositions.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetPoolListFromCacheRef on AutoDisposeFutureProviderRef<List<DexPool>> {
  /// The parameter `onlyVerified` of this provider.
  bool get onlyVerified;

  /// The parameter `onlyPoolsWithLiquidityPositions` of this provider.
  bool get onlyPoolsWithLiquidityPositions;
}

class _GetPoolListFromCacheProviderElement
    extends AutoDisposeFutureProviderElement<List<DexPool>>
    with _GetPoolListFromCacheRef {
  _GetPoolListFromCacheProviderElement(super.provider);

  @override
  bool get onlyVerified =>
      (origin as _GetPoolListFromCacheProvider).onlyVerified;
  @override
  bool get onlyPoolsWithLiquidityPositions =>
      (origin as _GetPoolListFromCacheProvider).onlyPoolsWithLiquidityPositions;
}

String _$putPoolListToCacheHash() =>
    r'a7371f5c8e5e80d23104a9bfd70f324bcab2183b';

/// See also [_putPoolListToCache].
@ProviderFor(_putPoolListToCache)
final _putPoolListToCacheProvider = AutoDisposeFutureProvider<void>.internal(
  _putPoolListToCache,
  name: r'_putPoolListToCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$putPoolListToCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _PutPoolListToCacheRef = AutoDisposeFutureProviderRef<void>;
String _$estimateTokenInFiatHash() =>
    r'9a71209573d9ea2867e12de00d6309c7a4165fa9';

/// See also [_estimateTokenInFiat].
@ProviderFor(_estimateTokenInFiat)
const _estimateTokenInFiatProvider = _EstimateTokenInFiatFamily();

/// See also [_estimateTokenInFiat].
class _EstimateTokenInFiatFamily extends Family<AsyncValue<double>> {
  /// See also [_estimateTokenInFiat].
  const _EstimateTokenInFiatFamily();

  /// See also [_estimateTokenInFiat].
  _EstimateTokenInFiatProvider call(
    DexToken token,
  ) {
    return _EstimateTokenInFiatProvider(
      token,
    );
  }

  @override
  _EstimateTokenInFiatProvider getProviderOverride(
    covariant _EstimateTokenInFiatProvider provider,
  ) {
    return call(
      provider.token,
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
  String? get name => r'_estimateTokenInFiatProvider';
}

/// See also [_estimateTokenInFiat].
class _EstimateTokenInFiatProvider extends AutoDisposeFutureProvider<double> {
  /// See also [_estimateTokenInFiat].
  _EstimateTokenInFiatProvider(
    DexToken token,
  ) : this._internal(
          (ref) => _estimateTokenInFiat(
            ref as _EstimateTokenInFiatRef,
            token,
          ),
          from: _estimateTokenInFiatProvider,
          name: r'_estimateTokenInFiatProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$estimateTokenInFiatHash,
          dependencies: _EstimateTokenInFiatFamily._dependencies,
          allTransitiveDependencies:
              _EstimateTokenInFiatFamily._allTransitiveDependencies,
          token: token,
        );

  _EstimateTokenInFiatProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.token,
  }) : super.internal();

  final DexToken token;

  @override
  Override overrideWith(
    FutureOr<double> Function(_EstimateTokenInFiatRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _EstimateTokenInFiatProvider._internal(
        (ref) => create(ref as _EstimateTokenInFiatRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        token: token,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _EstimateTokenInFiatProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _EstimateTokenInFiatProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _EstimateTokenInFiatRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `token` of this provider.
  DexToken get token;
}

class _EstimateTokenInFiatProviderElement
    extends AutoDisposeFutureProviderElement<double>
    with _EstimateTokenInFiatRef {
  _EstimateTokenInFiatProviderElement(super.provider);

  @override
  DexToken get token => (origin as _EstimateTokenInFiatProvider).token;
}

String _$estimatePoolTVLInFiatHash() =>
    r'952cc20b4026e709044cc9f64fdf463a38de7b86';

/// See also [_estimatePoolTVLInFiat].
@ProviderFor(_estimatePoolTVLInFiat)
const _estimatePoolTVLInFiatProvider = _EstimatePoolTVLInFiatFamily();

/// See also [_estimatePoolTVLInFiat].
class _EstimatePoolTVLInFiatFamily extends Family<AsyncValue<double>> {
  /// See also [_estimatePoolTVLInFiat].
  const _EstimatePoolTVLInFiatFamily();

  /// See also [_estimatePoolTVLInFiat].
  _EstimatePoolTVLInFiatProvider call(
    DexPool pool,
  ) {
    return _EstimatePoolTVLInFiatProvider(
      pool,
    );
  }

  @override
  _EstimatePoolTVLInFiatProvider getProviderOverride(
    covariant _EstimatePoolTVLInFiatProvider provider,
  ) {
    return call(
      provider.pool,
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
  String? get name => r'_estimatePoolTVLInFiatProvider';
}

/// See also [_estimatePoolTVLInFiat].
class _EstimatePoolTVLInFiatProvider extends AutoDisposeFutureProvider<double> {
  /// See also [_estimatePoolTVLInFiat].
  _EstimatePoolTVLInFiatProvider(
    DexPool pool,
  ) : this._internal(
          (ref) => _estimatePoolTVLInFiat(
            ref as _EstimatePoolTVLInFiatRef,
            pool,
          ),
          from: _estimatePoolTVLInFiatProvider,
          name: r'_estimatePoolTVLInFiatProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$estimatePoolTVLInFiatHash,
          dependencies: _EstimatePoolTVLInFiatFamily._dependencies,
          allTransitiveDependencies:
              _EstimatePoolTVLInFiatFamily._allTransitiveDependencies,
          pool: pool,
        );

  _EstimatePoolTVLInFiatProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pool,
  }) : super.internal();

  final DexPool pool;

  @override
  Override overrideWith(
    FutureOr<double> Function(_EstimatePoolTVLInFiatRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _EstimatePoolTVLInFiatProvider._internal(
        (ref) => create(ref as _EstimatePoolTVLInFiatRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pool: pool,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _EstimatePoolTVLInFiatProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _EstimatePoolTVLInFiatProvider && other.pool == pool;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pool.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _EstimatePoolTVLInFiatRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `pool` of this provider.
  DexPool get pool;
}

class _EstimatePoolTVLInFiatProviderElement
    extends AutoDisposeFutureProviderElement<double>
    with _EstimatePoolTVLInFiatRef {
  _EstimatePoolTVLInFiatProviderElement(super.provider);

  @override
  DexPool get pool => (origin as _EstimatePoolTVLInFiatProvider).pool;
}

String _$estimateStatsHash() => r'64b17ce6009c91745091aee419d8f194ef1df9f4';

/// See also [_estimateStats].
@ProviderFor(_estimateStats)
const _estimateStatsProvider = _EstimateStatsFamily();

/// See also [_estimateStats].
class _EstimateStatsFamily extends Family<
    AsyncValue<
        ({
          double volume24h,
          double fee24h,
          double volumeAllTime,
          double feeAllTime
        })>> {
  /// See also [_estimateStats].
  const _EstimateStatsFamily();

  /// See also [_estimateStats].
  _EstimateStatsProvider call(
    DexPool currentPoolInfos,
  ) {
    return _EstimateStatsProvider(
      currentPoolInfos,
    );
  }

  @override
  _EstimateStatsProvider getProviderOverride(
    covariant _EstimateStatsProvider provider,
  ) {
    return call(
      provider.currentPoolInfos,
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
  String? get name => r'_estimateStatsProvider';
}

/// See also [_estimateStats].
class _EstimateStatsProvider extends AutoDisposeFutureProvider<
    ({
      double volume24h,
      double fee24h,
      double volumeAllTime,
      double feeAllTime
    })> {
  /// See also [_estimateStats].
  _EstimateStatsProvider(
    DexPool currentPoolInfos,
  ) : this._internal(
          (ref) => _estimateStats(
            ref as _EstimateStatsRef,
            currentPoolInfos,
          ),
          from: _estimateStatsProvider,
          name: r'_estimateStatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$estimateStatsHash,
          dependencies: _EstimateStatsFamily._dependencies,
          allTransitiveDependencies:
              _EstimateStatsFamily._allTransitiveDependencies,
          currentPoolInfos: currentPoolInfos,
        );

  _EstimateStatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.currentPoolInfos,
  }) : super.internal();

  final DexPool currentPoolInfos;

  @override
  Override overrideWith(
    FutureOr<
                ({
                  double volume24h,
                  double fee24h,
                  double volumeAllTime,
                  double feeAllTime
                })>
            Function(_EstimateStatsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _EstimateStatsProvider._internal(
        (ref) => create(ref as _EstimateStatsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        currentPoolInfos: currentPoolInfos,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<
      ({
        double volume24h,
        double fee24h,
        double volumeAllTime,
        double feeAllTime
      })> createElement() {
    return _EstimateStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _EstimateStatsProvider &&
        other.currentPoolInfos == currentPoolInfos;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, currentPoolInfos.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _EstimateStatsRef on AutoDisposeFutureProviderRef<
    ({
      double volume24h,
      double fee24h,
      double volumeAllTime,
      double feeAllTime
    })> {
  /// The parameter `currentPoolInfos` of this provider.
  DexPool get currentPoolInfos;
}

class _EstimateStatsProviderElement extends AutoDisposeFutureProviderElement<
    ({
      double volume24h,
      double fee24h,
      double volumeAllTime,
      double feeAllTime
    })> with _EstimateStatsRef {
  _EstimateStatsProviderElement(super.provider);

  @override
  DexPool get currentPoolInfos =>
      (origin as _EstimateStatsProvider).currentPoolInfos;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
