// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_pool.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dexPoolRepositoryHash() => r'f0302ebbeaf116b99bb49d1f59bca82c50263afd';

/// See also [_dexPoolRepository].
@ProviderFor(_dexPoolRepository)
final _dexPoolRepositoryProvider =
    AutoDisposeProvider<DexPoolRepositoryImpl>.internal(
  _dexPoolRepository,
  name: r'_dexPoolRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dexPoolRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _DexPoolRepositoryRef = AutoDisposeProviderRef<DexPoolRepositoryImpl>;
String _$invalidateDataUseCaseHash() =>
    r'37470bca8f7d6bab39331030db9bee9a1bfed9e2';

/// See also [_invalidateDataUseCase].
@ProviderFor(_invalidateDataUseCase)
final _invalidateDataUseCaseProvider = AutoDisposeProvider<void>.internal(
  _invalidateDataUseCase,
  name: r'_invalidateDataUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$invalidateDataUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _InvalidateDataUseCaseRef = AutoDisposeProviderRef<void>;
String _$putPoolListInfosToCacheHash() =>
    r'2a9dabdd4c6d5be7761a66406b53068ede775df0';

/// See also [_putPoolListInfosToCache].
@ProviderFor(_putPoolListInfosToCache)
final _putPoolListInfosToCacheProvider =
    AutoDisposeFutureProvider<void>.internal(
  _putPoolListInfosToCache,
  name: r'_putPoolListInfosToCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$putPoolListInfosToCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _PutPoolListInfosToCacheRef = AutoDisposeFutureProviderRef<void>;
String _$updatePoolInCacheHash() => r'6c51e67965fff8292b6fa37262468e914be55aef';

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

/// See also [_updatePoolInCache].
@ProviderFor(_updatePoolInCache)
const _updatePoolInCacheProvider = _UpdatePoolInCacheFamily();

/// See also [_updatePoolInCache].
class _UpdatePoolInCacheFamily extends Family<AsyncValue<void>> {
  /// See also [_updatePoolInCache].
  const _UpdatePoolInCacheFamily();

  /// See also [_updatePoolInCache].
  _UpdatePoolInCacheProvider call(
    DexPool pool,
  ) {
    return _UpdatePoolInCacheProvider(
      pool,
    );
  }

  @override
  _UpdatePoolInCacheProvider getProviderOverride(
    covariant _UpdatePoolInCacheProvider provider,
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
  String? get name => r'_updatePoolInCacheProvider';
}

/// See also [_updatePoolInCache].
class _UpdatePoolInCacheProvider extends AutoDisposeFutureProvider<void> {
  /// See also [_updatePoolInCache].
  _UpdatePoolInCacheProvider(
    DexPool pool,
  ) : this._internal(
          (ref) => _updatePoolInCache(
            ref as _UpdatePoolInCacheRef,
            pool,
          ),
          from: _updatePoolInCacheProvider,
          name: r'_updatePoolInCacheProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updatePoolInCacheHash,
          dependencies: _UpdatePoolInCacheFamily._dependencies,
          allTransitiveDependencies:
              _UpdatePoolInCacheFamily._allTransitiveDependencies,
          pool: pool,
        );

  _UpdatePoolInCacheProvider._internal(
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
    FutureOr<void> Function(_UpdatePoolInCacheRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _UpdatePoolInCacheProvider._internal(
        (ref) => create(ref as _UpdatePoolInCacheRef),
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
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdatePoolInCacheProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _UpdatePoolInCacheProvider && other.pool == pool;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pool.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _UpdatePoolInCacheRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `pool` of this provider.
  DexPool get pool;
}

class _UpdatePoolInCacheProviderElement
    extends AutoDisposeFutureProviderElement<void> with _UpdatePoolInCacheRef {
  _UpdatePoolInCacheProviderElement(super.provider);

  @override
  DexPool get pool => (origin as _UpdatePoolInCacheProvider).pool;
}

String _$putPoolToCacheHash() => r'1fbcbb72f42038bc47a03e4e21e4a93cda1acbce';

/// See also [_putPoolToCache].
@ProviderFor(_putPoolToCache)
const _putPoolToCacheProvider = _PutPoolToCacheFamily();

/// See also [_putPoolToCache].
class _PutPoolToCacheFamily extends Family<AsyncValue<void>> {
  /// See also [_putPoolToCache].
  const _PutPoolToCacheFamily();

  /// See also [_putPoolToCache].
  _PutPoolToCacheProvider call(
    String poolGenesisAddress, {
    bool isFavorite = false,
  }) {
    return _PutPoolToCacheProvider(
      poolGenesisAddress,
      isFavorite: isFavorite,
    );
  }

  @override
  _PutPoolToCacheProvider getProviderOverride(
    covariant _PutPoolToCacheProvider provider,
  ) {
    return call(
      provider.poolGenesisAddress,
      isFavorite: provider.isFavorite,
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
  String? get name => r'_putPoolToCacheProvider';
}

/// See also [_putPoolToCache].
class _PutPoolToCacheProvider extends AutoDisposeFutureProvider<void> {
  /// See also [_putPoolToCache].
  _PutPoolToCacheProvider(
    String poolGenesisAddress, {
    bool isFavorite = false,
  }) : this._internal(
          (ref) => _putPoolToCache(
            ref as _PutPoolToCacheRef,
            poolGenesisAddress,
            isFavorite: isFavorite,
          ),
          from: _putPoolToCacheProvider,
          name: r'_putPoolToCacheProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$putPoolToCacheHash,
          dependencies: _PutPoolToCacheFamily._dependencies,
          allTransitiveDependencies:
              _PutPoolToCacheFamily._allTransitiveDependencies,
          poolGenesisAddress: poolGenesisAddress,
          isFavorite: isFavorite,
        );

  _PutPoolToCacheProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.poolGenesisAddress,
    required this.isFavorite,
  }) : super.internal();

  final String poolGenesisAddress;
  final bool isFavorite;

  @override
  Override overrideWith(
    FutureOr<void> Function(_PutPoolToCacheRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _PutPoolToCacheProvider._internal(
        (ref) => create(ref as _PutPoolToCacheRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        poolGenesisAddress: poolGenesisAddress,
        isFavorite: isFavorite,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _PutPoolToCacheProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _PutPoolToCacheProvider &&
        other.poolGenesisAddress == poolGenesisAddress &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poolGenesisAddress.hashCode);
    hash = _SystemHash.combine(hash, isFavorite.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _PutPoolToCacheRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `poolGenesisAddress` of this provider.
  String get poolGenesisAddress;

  /// The parameter `isFavorite` of this provider.
  bool get isFavorite;
}

class _PutPoolToCacheProviderElement
    extends AutoDisposeFutureProviderElement<void> with _PutPoolToCacheRef {
  _PutPoolToCacheProviderElement(super.provider);

  @override
  String get poolGenesisAddress =>
      (origin as _PutPoolToCacheProvider).poolGenesisAddress;
  @override
  bool get isFavorite => (origin as _PutPoolToCacheProvider).isFavorite;
}

String _$getRatioHash() => r'ab779336d5767381e4e30930bda8546150c3af98';

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

String _$estimatePoolTVLInFiatHash() =>
    r'170da1d201b9d6b4bd35cf848b5e7fef2d34876a';

/// See also [_estimatePoolTVLInFiat].
@ProviderFor(_estimatePoolTVLInFiat)
const _estimatePoolTVLInFiatProvider = _EstimatePoolTVLInFiatFamily();

/// See also [_estimatePoolTVLInFiat].
class _EstimatePoolTVLInFiatFamily extends Family<double> {
  /// See also [_estimatePoolTVLInFiat].
  const _EstimatePoolTVLInFiatFamily();

  /// See also [_estimatePoolTVLInFiat].
  _EstimatePoolTVLInFiatProvider call(
    DexPool? pool,
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
class _EstimatePoolTVLInFiatProvider extends AutoDisposeProvider<double> {
  /// See also [_estimatePoolTVLInFiat].
  _EstimatePoolTVLInFiatProvider(
    DexPool? pool,
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

  final DexPool? pool;

  @override
  Override overrideWith(
    double Function(_EstimatePoolTVLInFiatRef provider) create,
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
  AutoDisposeProviderElement<double> createElement() {
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

mixin _EstimatePoolTVLInFiatRef on AutoDisposeProviderRef<double> {
  /// The parameter `pool` of this provider.
  DexPool? get pool;
}

class _EstimatePoolTVLInFiatProviderElement
    extends AutoDisposeProviderElement<double> with _EstimatePoolTVLInFiatRef {
  _EstimatePoolTVLInFiatProviderElement(super.provider);

  @override
  DexPool? get pool => (origin as _EstimatePoolTVLInFiatProvider).pool;
}

String _$populatePoolInfosWithTokenStats24hHash() =>
    r'c7a18f0e4649033f533bd61c8d7c638f6067e1e8';

/// See also [_populatePoolInfosWithTokenStats24h].
@ProviderFor(_populatePoolInfosWithTokenStats24h)
const _populatePoolInfosWithTokenStats24hProvider =
    _PopulatePoolInfosWithTokenStats24hFamily();

/// See also [_populatePoolInfosWithTokenStats24h].
class _PopulatePoolInfosWithTokenStats24hFamily extends Family<DexPool> {
  /// See also [_populatePoolInfosWithTokenStats24h].
  const _PopulatePoolInfosWithTokenStats24hFamily();

  /// See also [_populatePoolInfosWithTokenStats24h].
  _PopulatePoolInfosWithTokenStats24hProvider call(
    DexPool pool,
    Map<String, List<Transaction>> transactionChainResult,
  ) {
    return _PopulatePoolInfosWithTokenStats24hProvider(
      pool,
      transactionChainResult,
    );
  }

  @override
  _PopulatePoolInfosWithTokenStats24hProvider getProviderOverride(
    covariant _PopulatePoolInfosWithTokenStats24hProvider provider,
  ) {
    return call(
      provider.pool,
      provider.transactionChainResult,
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
  String? get name => r'_populatePoolInfosWithTokenStats24hProvider';
}

/// See also [_populatePoolInfosWithTokenStats24h].
class _PopulatePoolInfosWithTokenStats24hProvider
    extends AutoDisposeProvider<DexPool> {
  /// See also [_populatePoolInfosWithTokenStats24h].
  _PopulatePoolInfosWithTokenStats24hProvider(
    DexPool pool,
    Map<String, List<Transaction>> transactionChainResult,
  ) : this._internal(
          (ref) => _populatePoolInfosWithTokenStats24h(
            ref as _PopulatePoolInfosWithTokenStats24hRef,
            pool,
            transactionChainResult,
          ),
          from: _populatePoolInfosWithTokenStats24hProvider,
          name: r'_populatePoolInfosWithTokenStats24hProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$populatePoolInfosWithTokenStats24hHash,
          dependencies: _PopulatePoolInfosWithTokenStats24hFamily._dependencies,
          allTransitiveDependencies: _PopulatePoolInfosWithTokenStats24hFamily
              ._allTransitiveDependencies,
          pool: pool,
          transactionChainResult: transactionChainResult,
        );

  _PopulatePoolInfosWithTokenStats24hProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pool,
    required this.transactionChainResult,
  }) : super.internal();

  final DexPool pool;
  final Map<String, List<Transaction>> transactionChainResult;

  @override
  Override overrideWith(
    DexPool Function(_PopulatePoolInfosWithTokenStats24hRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _PopulatePoolInfosWithTokenStats24hProvider._internal(
        (ref) => create(ref as _PopulatePoolInfosWithTokenStats24hRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pool: pool,
        transactionChainResult: transactionChainResult,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<DexPool> createElement() {
    return _PopulatePoolInfosWithTokenStats24hProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _PopulatePoolInfosWithTokenStats24hProvider &&
        other.pool == pool &&
        other.transactionChainResult == transactionChainResult;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pool.hashCode);
    hash = _SystemHash.combine(hash, transactionChainResult.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _PopulatePoolInfosWithTokenStats24hRef
    on AutoDisposeProviderRef<DexPool> {
  /// The parameter `pool` of this provider.
  DexPool get pool;

  /// The parameter `transactionChainResult` of this provider.
  Map<String, List<Transaction>> get transactionChainResult;
}

class _PopulatePoolInfosWithTokenStats24hProviderElement
    extends AutoDisposeProviderElement<DexPool>
    with _PopulatePoolInfosWithTokenStats24hRef {
  _PopulatePoolInfosWithTokenStats24hProviderElement(super.provider);

  @override
  DexPool get pool =>
      (origin as _PopulatePoolInfosWithTokenStats24hProvider).pool;
  @override
  Map<String, List<Transaction>> get transactionChainResult =>
      (origin as _PopulatePoolInfosWithTokenStats24hProvider)
          .transactionChainResult;
}

String _$estimateStatsHash() => r'890e53d17c258e234b5f378657bdfcd245377e07';

/// See also [_estimateStats].
@ProviderFor(_estimateStats)
const _estimateStatsProvider = _EstimateStatsFamily();

/// See also [_estimateStats].
class _EstimateStatsFamily extends Family<
    ({
      double volume24h,
      double fee24h,
      double volumeAllTime,
      double feeAllTime
    })> {
  /// See also [_estimateStats].
  const _EstimateStatsFamily();

  /// See also [_estimateStats].
  _EstimateStatsProvider call(
    DexPool pool,
  ) {
    return _EstimateStatsProvider(
      pool,
    );
  }

  @override
  _EstimateStatsProvider getProviderOverride(
    covariant _EstimateStatsProvider provider,
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
  String? get name => r'_estimateStatsProvider';
}

/// See also [_estimateStats].
class _EstimateStatsProvider extends AutoDisposeProvider<
    ({
      double volume24h,
      double fee24h,
      double volumeAllTime,
      double feeAllTime
    })> {
  /// See also [_estimateStats].
  _EstimateStatsProvider(
    DexPool pool,
  ) : this._internal(
          (ref) => _estimateStats(
            ref as _EstimateStatsRef,
            pool,
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
          pool: pool,
        );

  _EstimateStatsProvider._internal(
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
    ({double volume24h, double fee24h, double volumeAllTime, double feeAllTime})
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
        pool: pool,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<
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
    return other is _EstimateStatsProvider && other.pool == pool;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pool.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _EstimateStatsRef on AutoDisposeProviderRef<
    ({
      double volume24h,
      double fee24h,
      double volumeAllTime,
      double feeAllTime
    })> {
  /// The parameter `pool` of this provider.
  DexPool get pool;
}

class _EstimateStatsProviderElement extends AutoDisposeProviderElement<
    ({
      double volume24h,
      double fee24h,
      double volumeAllTime,
      double feeAllTime
    })> with _EstimateStatsRef {
  _EstimateStatsProviderElement(super.provider);

  @override
  DexPool get pool => (origin as _EstimateStatsProvider).pool;
}

String _$getPoolHash() => r'f87bd61361cfb101125290cb61c607ff8a5b3516';

/// See also [_getPool].
@ProviderFor(_getPool)
const _getPoolProvider = _GetPoolFamily();

/// See also [_getPool].
class _GetPoolFamily extends Family<AsyncValue<DexPool?>> {
  /// See also [_getPool].
  const _GetPoolFamily();

  /// See also [_getPool].
  _GetPoolProvider call(
    String genesisAddress,
  ) {
    return _GetPoolProvider(
      genesisAddress,
    );
  }

  @override
  _GetPoolProvider getProviderOverride(
    covariant _GetPoolProvider provider,
  ) {
    return call(
      provider.genesisAddress,
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
  String? get name => r'_getPoolProvider';
}

/// See also [_getPool].
class _GetPoolProvider extends AutoDisposeFutureProvider<DexPool?> {
  /// See also [_getPool].
  _GetPoolProvider(
    String genesisAddress,
  ) : this._internal(
          (ref) => _getPool(
            ref as _GetPoolRef,
            genesisAddress,
          ),
          from: _getPoolProvider,
          name: r'_getPoolProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPoolHash,
          dependencies: _GetPoolFamily._dependencies,
          allTransitiveDependencies: _GetPoolFamily._allTransitiveDependencies,
          genesisAddress: genesisAddress,
        );

  _GetPoolProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.genesisAddress,
  }) : super.internal();

  final String genesisAddress;

  @override
  Override overrideWith(
    FutureOr<DexPool?> Function(_GetPoolRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetPoolProvider._internal(
        (ref) => create(ref as _GetPoolRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        genesisAddress: genesisAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DexPool?> createElement() {
    return _GetPoolProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetPoolProvider && other.genesisAddress == genesisAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, genesisAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetPoolRef on AutoDisposeFutureProviderRef<DexPool?> {
  /// The parameter `genesisAddress` of this provider.
  String get genesisAddress;
}

class _GetPoolProviderElement extends AutoDisposeFutureProviderElement<DexPool?>
    with _GetPoolRef {
  _GetPoolProviderElement(super.provider);

  @override
  String get genesisAddress => (origin as _GetPoolProvider).genesisAddress;
}

String _$getPoolInfosHash() => r'1bc7f25e7cdba4946109b73e9bc090b6412d4f1f';

/// See also [_getPoolInfos].
@ProviderFor(_getPoolInfos)
const _getPoolInfosProvider = _GetPoolInfosFamily();

/// See also [_getPoolInfos].
class _GetPoolInfosFamily extends Family<AsyncValue<DexPool?>> {
  /// See also [_getPoolInfos].
  const _GetPoolInfosFamily();

  /// See also [_getPoolInfos].
  _GetPoolInfosProvider call(
    DexPool poolInput,
  ) {
    return _GetPoolInfosProvider(
      poolInput,
    );
  }

  @override
  _GetPoolInfosProvider getProviderOverride(
    covariant _GetPoolInfosProvider provider,
  ) {
    return call(
      provider.poolInput,
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
    DexPool poolInput,
  ) : this._internal(
          (ref) => _getPoolInfos(
            ref as _GetPoolInfosRef,
            poolInput,
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
          poolInput: poolInput,
        );

  _GetPoolInfosProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.poolInput,
  }) : super.internal();

  final DexPool poolInput;

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
        poolInput: poolInput,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DexPool?> createElement() {
    return _GetPoolInfosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetPoolInfosProvider && other.poolInput == poolInput;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poolInput.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetPoolInfosRef on AutoDisposeFutureProviderRef<DexPool?> {
  /// The parameter `poolInput` of this provider.
  DexPool get poolInput;
}

class _GetPoolInfosProviderElement
    extends AutoDisposeFutureProviderElement<DexPool?> with _GetPoolInfosRef {
  _GetPoolInfosProviderElement(super.provider);

  @override
  DexPool get poolInput => (origin as _GetPoolInfosProvider).poolInput;
}

String _$removePoolFromFavoriteHash() =>
    r'7b1ce05229a825883e8779eb723857e59f5def85';

/// See also [_removePoolFromFavorite].
@ProviderFor(_removePoolFromFavorite)
const _removePoolFromFavoriteProvider = _RemovePoolFromFavoriteFamily();

/// See also [_removePoolFromFavorite].
class _RemovePoolFromFavoriteFamily extends Family<AsyncValue<void>> {
  /// See also [_removePoolFromFavorite].
  const _RemovePoolFromFavoriteFamily();

  /// See also [_removePoolFromFavorite].
  _RemovePoolFromFavoriteProvider call(
    String poolGenesisAddress,
  ) {
    return _RemovePoolFromFavoriteProvider(
      poolGenesisAddress,
    );
  }

  @override
  _RemovePoolFromFavoriteProvider getProviderOverride(
    covariant _RemovePoolFromFavoriteProvider provider,
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
  String? get name => r'_removePoolFromFavoriteProvider';
}

/// See also [_removePoolFromFavorite].
class _RemovePoolFromFavoriteProvider extends AutoDisposeFutureProvider<void> {
  /// See also [_removePoolFromFavorite].
  _RemovePoolFromFavoriteProvider(
    String poolGenesisAddress,
  ) : this._internal(
          (ref) => _removePoolFromFavorite(
            ref as _RemovePoolFromFavoriteRef,
            poolGenesisAddress,
          ),
          from: _removePoolFromFavoriteProvider,
          name: r'_removePoolFromFavoriteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$removePoolFromFavoriteHash,
          dependencies: _RemovePoolFromFavoriteFamily._dependencies,
          allTransitiveDependencies:
              _RemovePoolFromFavoriteFamily._allTransitiveDependencies,
          poolGenesisAddress: poolGenesisAddress,
        );

  _RemovePoolFromFavoriteProvider._internal(
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
    FutureOr<void> Function(_RemovePoolFromFavoriteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _RemovePoolFromFavoriteProvider._internal(
        (ref) => create(ref as _RemovePoolFromFavoriteRef),
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
  AutoDisposeFutureProviderElement<void> createElement() {
    return _RemovePoolFromFavoriteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _RemovePoolFromFavoriteProvider &&
        other.poolGenesisAddress == poolGenesisAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poolGenesisAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _RemovePoolFromFavoriteRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `poolGenesisAddress` of this provider.
  String get poolGenesisAddress;
}

class _RemovePoolFromFavoriteProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with _RemovePoolFromFavoriteRef {
  _RemovePoolFromFavoriteProviderElement(super.provider);

  @override
  String get poolGenesisAddress =>
      (origin as _RemovePoolFromFavoriteProvider).poolGenesisAddress;
}

String _$addPoolFromFavoriteHash() =>
    r'8812c94a0a9be6ba64a9d7516f349ee7164fa900';

/// See also [_addPoolFromFavorite].
@ProviderFor(_addPoolFromFavorite)
const _addPoolFromFavoriteProvider = _AddPoolFromFavoriteFamily();

/// See also [_addPoolFromFavorite].
class _AddPoolFromFavoriteFamily extends Family<AsyncValue<void>> {
  /// See also [_addPoolFromFavorite].
  const _AddPoolFromFavoriteFamily();

  /// See also [_addPoolFromFavorite].
  _AddPoolFromFavoriteProvider call(
    String poolGenesisAddress,
  ) {
    return _AddPoolFromFavoriteProvider(
      poolGenesisAddress,
    );
  }

  @override
  _AddPoolFromFavoriteProvider getProviderOverride(
    covariant _AddPoolFromFavoriteProvider provider,
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
  String? get name => r'_addPoolFromFavoriteProvider';
}

/// See also [_addPoolFromFavorite].
class _AddPoolFromFavoriteProvider extends AutoDisposeFutureProvider<void> {
  /// See also [_addPoolFromFavorite].
  _AddPoolFromFavoriteProvider(
    String poolGenesisAddress,
  ) : this._internal(
          (ref) => _addPoolFromFavorite(
            ref as _AddPoolFromFavoriteRef,
            poolGenesisAddress,
          ),
          from: _addPoolFromFavoriteProvider,
          name: r'_addPoolFromFavoriteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addPoolFromFavoriteHash,
          dependencies: _AddPoolFromFavoriteFamily._dependencies,
          allTransitiveDependencies:
              _AddPoolFromFavoriteFamily._allTransitiveDependencies,
          poolGenesisAddress: poolGenesisAddress,
        );

  _AddPoolFromFavoriteProvider._internal(
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
    FutureOr<void> Function(_AddPoolFromFavoriteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _AddPoolFromFavoriteProvider._internal(
        (ref) => create(ref as _AddPoolFromFavoriteRef),
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
  AutoDisposeFutureProviderElement<void> createElement() {
    return _AddPoolFromFavoriteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _AddPoolFromFavoriteProvider &&
        other.poolGenesisAddress == poolGenesisAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poolGenesisAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _AddPoolFromFavoriteRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `poolGenesisAddress` of this provider.
  String get poolGenesisAddress;
}

class _AddPoolFromFavoriteProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with _AddPoolFromFavoriteRef {
  _AddPoolFromFavoriteProviderElement(super.provider);

  @override
  String get poolGenesisAddress =>
      (origin as _AddPoolFromFavoriteProvider).poolGenesisAddress;
}

String _$getPoolListHash() => r'2e255a046c9e040657bbee32b921741558aedb27';

/// See also [_getPoolList].
@ProviderFor(_getPoolList)
final _getPoolListProvider = FutureProvider<List<DexPool>>.internal(
  _getPoolList,
  name: r'_getPoolListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getPoolListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetPoolListRef = FutureProviderRef<List<DexPool>>;
String _$getPoolListForUserHash() =>
    r'3dbd56aaf4a29253b4533da97664a85817a1b3c8';

/// See also [_getPoolListForUser].
@ProviderFor(_getPoolListForUser)
final _getPoolListForUserProvider = FutureProvider<List<DexPool>>.internal(
  _getPoolListForUser,
  name: r'_getPoolListForUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getPoolListForUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetPoolListForUserRef = FutureProviderRef<List<DexPool>>;
String _$getPoolListForSearchHash() =>
    r'1d516c63cc764907b2c037668f8695080ddbe415';

/// See also [_getPoolListForSearch].
@ProviderFor(_getPoolListForSearch)
const _getPoolListForSearchProvider = _GetPoolListForSearchFamily();

/// See also [_getPoolListForSearch].
class _GetPoolListForSearchFamily extends Family<AsyncValue<List<DexPool>>> {
  /// See also [_getPoolListForSearch].
  const _GetPoolListForSearchFamily();

  /// See also [_getPoolListForSearch].
  _GetPoolListForSearchProvider call(
    String searchText,
    List<DexPool> poolList,
  ) {
    return _GetPoolListForSearchProvider(
      searchText,
      poolList,
    );
  }

  @override
  _GetPoolListForSearchProvider getProviderOverride(
    covariant _GetPoolListForSearchProvider provider,
  ) {
    return call(
      provider.searchText,
      provider.poolList,
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
  String? get name => r'_getPoolListForSearchProvider';
}

/// See also [_getPoolListForSearch].
class _GetPoolListForSearchProvider
    extends AutoDisposeFutureProvider<List<DexPool>> {
  /// See also [_getPoolListForSearch].
  _GetPoolListForSearchProvider(
    String searchText,
    List<DexPool> poolList,
  ) : this._internal(
          (ref) => _getPoolListForSearch(
            ref as _GetPoolListForSearchRef,
            searchText,
            poolList,
          ),
          from: _getPoolListForSearchProvider,
          name: r'_getPoolListForSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPoolListForSearchHash,
          dependencies: _GetPoolListForSearchFamily._dependencies,
          allTransitiveDependencies:
              _GetPoolListForSearchFamily._allTransitiveDependencies,
          searchText: searchText,
          poolList: poolList,
        );

  _GetPoolListForSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchText,
    required this.poolList,
  }) : super.internal();

  final String searchText;
  final List<DexPool> poolList;

  @override
  Override overrideWith(
    FutureOr<List<DexPool>> Function(_GetPoolListForSearchRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetPoolListForSearchProvider._internal(
        (ref) => create(ref as _GetPoolListForSearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchText: searchText,
        poolList: poolList,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DexPool>> createElement() {
    return _GetPoolListForSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetPoolListForSearchProvider &&
        other.searchText == searchText &&
        other.poolList == poolList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchText.hashCode);
    hash = _SystemHash.combine(hash, poolList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetPoolListForSearchRef on AutoDisposeFutureProviderRef<List<DexPool>> {
  /// The parameter `searchText` of this provider.
  String get searchText;

  /// The parameter `poolList` of this provider.
  List<DexPool> get poolList;
}

class _GetPoolListForSearchProviderElement
    extends AutoDisposeFutureProviderElement<List<DexPool>>
    with _GetPoolListForSearchRef {
  _GetPoolListForSearchProviderElement(super.provider);

  @override
  String get searchText => (origin as _GetPoolListForSearchProvider).searchText;
  @override
  List<DexPool> get poolList =>
      (origin as _GetPoolListForSearchProvider).poolList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
