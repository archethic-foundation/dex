// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_pool.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dexPoolsRepositoryHash() =>
    r'100f295d126c7ac2fb2b67f836c9d14c12ed2b8a';

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
String _$invalidateDataUseCaseHash() =>
    r'38131e0ba0da813e6ad515cfe2e8b7349233bd95';

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
String _$getPoolHash() => r'c119ca4279833a4029474933cfd39c43d735d152';

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

String _$getPoolInfosHash() => r'ddefc822cfe21bd471dbe0aba7b5e9c37a088ecb';

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

String _$myPoolsHash() => r'b941edfb7caff23b932c6085737e2b35c1f7a6e8';

/// See also [_myPools].
@ProviderFor(_myPools)
final _myPoolsProvider = AutoDisposeFutureProvider<List<DexPool>>.internal(
  _myPools,
  name: r'_myPoolsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$myPoolsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _MyPoolsRef = AutoDisposeFutureProviderRef<List<DexPool>>;
String _$verifiedPoolsHash() => r'9190cdc02b6c01948bc9ace40e4ad1a732bb14b1';

/// See also [_verifiedPools].
@ProviderFor(_verifiedPools)
final _verifiedPoolsProvider =
    AutoDisposeFutureProvider<List<DexPool>>.internal(
  _verifiedPools,
  name: r'_verifiedPoolsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verifiedPoolsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _VerifiedPoolsRef = AutoDisposeFutureProviderRef<List<DexPool>>;
String _$favoritePoolsHash() => r'd4e6ca8677e70b3ac51a878f35d9c46b4c66de16';

/// See also [_favoritePools].
@ProviderFor(_favoritePools)
final _favoritePoolsProvider =
    AutoDisposeFutureProvider<List<DexPool>>.internal(
  _favoritePools,
  name: r'_favoritePoolsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritePoolsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _FavoritePoolsRef = AutoDisposeFutureProviderRef<List<DexPool>>;
String _$getPoolListFromCacheHash() =>
    r'd5f243bec2cd32d50eb2593ad2fcb39b54e79162';

/// See also [_getPoolListFromCache].
@ProviderFor(_getPoolListFromCache)
final _getPoolListFromCacheProvider =
    AutoDisposeFutureProvider<List<DexPool>>.internal(
  _getPoolListFromCache,
  name: r'_getPoolListFromCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getPoolListFromCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetPoolListFromCacheRef = AutoDisposeFutureProviderRef<List<DexPool>>;
String _$putPoolListInfosToCacheHash() =>
    r'4016b4dbec265b278ad706f82c4c9bb9b02ad75f';

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
String _$updatePoolInCacheHash() => r'f4b220a85cfa1612e5bd387fce5a1ed4aac409df';

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

String _$putPoolToCacheHash() => r'204e41089c1f3619612199c39767d7013b31c011';

/// See also [_putPoolToCache].
@ProviderFor(_putPoolToCache)
const _putPoolToCacheProvider = _PutPoolToCacheFamily();

/// See also [_putPoolToCache].
class _PutPoolToCacheFamily extends Family<AsyncValue<void>> {
  /// See also [_putPoolToCache].
  const _PutPoolToCacheFamily();

  /// See also [_putPoolToCache].
  _PutPoolToCacheProvider call(
    String poolGenesisAddress,
  ) {
    return _PutPoolToCacheProvider(
      poolGenesisAddress,
    );
  }

  @override
  _PutPoolToCacheProvider getProviderOverride(
    covariant _PutPoolToCacheProvider provider,
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
  String? get name => r'_putPoolToCacheProvider';
}

/// See also [_putPoolToCache].
class _PutPoolToCacheProvider extends AutoDisposeFutureProvider<void> {
  /// See also [_putPoolToCache].
  _PutPoolToCacheProvider(
    String poolGenesisAddress,
  ) : this._internal(
          (ref) => _putPoolToCache(
            ref as _PutPoolToCacheRef,
            poolGenesisAddress,
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
        );

  _PutPoolToCacheProvider._internal(
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
        other.poolGenesisAddress == poolGenesisAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poolGenesisAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _PutPoolToCacheRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `poolGenesisAddress` of this provider.
  String get poolGenesisAddress;
}

class _PutPoolToCacheProviderElement
    extends AutoDisposeFutureProviderElement<void> with _PutPoolToCacheRef {
  _PutPoolToCacheProviderElement(super.provider);

  @override
  String get poolGenesisAddress =>
      (origin as _PutPoolToCacheProvider).poolGenesisAddress;
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

String _$estimatePoolTVLandAPRInFiatHash() =>
    r'329003c691c67a5bcfde52f140a32f7fd26e7cf3';

/// See also [_estimatePoolTVLandAPRInFiat].
@ProviderFor(_estimatePoolTVLandAPRInFiat)
const _estimatePoolTVLandAPRInFiatProvider =
    _EstimatePoolTVLandAPRInFiatFamily();

/// See also [_estimatePoolTVLandAPRInFiat].
class _EstimatePoolTVLandAPRInFiatFamily
    extends Family<AsyncValue<({double tvl, double apr})>> {
  /// See also [_estimatePoolTVLandAPRInFiat].
  const _EstimatePoolTVLandAPRInFiatFamily();

  /// See also [_estimatePoolTVLandAPRInFiat].
  _EstimatePoolTVLandAPRInFiatProvider call(
    DexPool pool,
  ) {
    return _EstimatePoolTVLandAPRInFiatProvider(
      pool,
    );
  }

  @override
  _EstimatePoolTVLandAPRInFiatProvider getProviderOverride(
    covariant _EstimatePoolTVLandAPRInFiatProvider provider,
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
  String? get name => r'_estimatePoolTVLandAPRInFiatProvider';
}

/// See also [_estimatePoolTVLandAPRInFiat].
class _EstimatePoolTVLandAPRInFiatProvider
    extends AutoDisposeFutureProvider<({double tvl, double apr})> {
  /// See also [_estimatePoolTVLandAPRInFiat].
  _EstimatePoolTVLandAPRInFiatProvider(
    DexPool pool,
  ) : this._internal(
          (ref) => _estimatePoolTVLandAPRInFiat(
            ref as _EstimatePoolTVLandAPRInFiatRef,
            pool,
          ),
          from: _estimatePoolTVLandAPRInFiatProvider,
          name: r'_estimatePoolTVLandAPRInFiatProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$estimatePoolTVLandAPRInFiatHash,
          dependencies: _EstimatePoolTVLandAPRInFiatFamily._dependencies,
          allTransitiveDependencies:
              _EstimatePoolTVLandAPRInFiatFamily._allTransitiveDependencies,
          pool: pool,
        );

  _EstimatePoolTVLandAPRInFiatProvider._internal(
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
    FutureOr<({double tvl, double apr})> Function(
            _EstimatePoolTVLandAPRInFiatRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _EstimatePoolTVLandAPRInFiatProvider._internal(
        (ref) => create(ref as _EstimatePoolTVLandAPRInFiatRef),
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
  AutoDisposeFutureProviderElement<({double tvl, double apr})> createElement() {
    return _EstimatePoolTVLandAPRInFiatProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _EstimatePoolTVLandAPRInFiatProvider && other.pool == pool;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pool.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _EstimatePoolTVLandAPRInFiatRef
    on AutoDisposeFutureProviderRef<({double tvl, double apr})> {
  /// The parameter `pool` of this provider.
  DexPool get pool;
}

class _EstimatePoolTVLandAPRInFiatProviderElement
    extends AutoDisposeFutureProviderElement<({double tvl, double apr})>
    with _EstimatePoolTVLandAPRInFiatRef {
  _EstimatePoolTVLandAPRInFiatProviderElement(super.provider);

  @override
  DexPool get pool => (origin as _EstimatePoolTVLandAPRInFiatProvider).pool;
}

String _$estimateStatsHash() => r'b96d4b1bdae0ca6d2bec4affebab3051ad064d70';

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
class _EstimateStatsProvider extends AutoDisposeFutureProvider<
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
        pool: pool,
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
    return other is _EstimateStatsProvider && other.pool == pool;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pool.hashCode);

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
  /// The parameter `pool` of this provider.
  DexPool get pool;
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
  DexPool get pool => (origin as _EstimateStatsProvider).pool;
}

String _$getPoolListHash() => r'458b882441a4741e96c8783fd00daed48a169f22';

/// See also [_getPoolList].
@ProviderFor(_getPoolList)
final _getPoolListProvider = AutoDisposeFutureProvider<List<DexPool>>.internal(
  _getPoolList,
  name: r'_getPoolListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getPoolListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetPoolListRef = AutoDisposeFutureProviderRef<List<DexPool>>;
String _$getPoolListForUserHash() =>
    r'8c01e382a405d079f8573241d7b7b9ca020a1b4c';

/// See also [_getPoolListForUser].
@ProviderFor(_getPoolListForUser)
final _getPoolListForUserProvider =
    AutoDisposeFutureProvider<List<DexPool>>.internal(
  _getPoolListForUser,
  name: r'_getPoolListForUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getPoolListForUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetPoolListForUserRef = AutoDisposeFutureProviderRef<List<DexPool>>;
String _$getPoolListForSearchHash() =>
    r'11f084c03d262afa45698cb8b327d14f7bc3bf4f';

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
  ) {
    return _GetPoolListForSearchProvider(
      searchText,
    );
  }

  @override
  _GetPoolListForSearchProvider getProviderOverride(
    covariant _GetPoolListForSearchProvider provider,
  ) {
    return call(
      provider.searchText,
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
  ) : this._internal(
          (ref) => _getPoolListForSearch(
            ref as _GetPoolListForSearchRef,
            searchText,
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
        );

  _GetPoolListForSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchText,
  }) : super.internal();

  final String searchText;

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
        other.searchText == searchText;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchText.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetPoolListForSearchRef on AutoDisposeFutureProviderRef<List<DexPool>> {
  /// The parameter `searchText` of this provider.
  String get searchText;
}

class _GetPoolListForSearchProviderElement
    extends AutoDisposeFutureProviderElement<List<DexPool>>
    with _GetPoolListForSearchRef {
  _GetPoolListForSearchProviderElement(super.provider);

  @override
  String get searchText => (origin as _GetPoolListForSearchProvider).searchText;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member