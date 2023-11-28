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

String _$getPoolInfosHash() => r'91bd638090682c1d52314c216e29aae0afc708ab';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
