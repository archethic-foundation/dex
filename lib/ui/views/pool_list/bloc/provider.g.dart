// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$poolsToDisplayHash() => r'7438c7c248d63f54ad3d6805d139abecbdd46995';

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

/// See also [_poolsToDisplay].
@ProviderFor(_poolsToDisplay)
const _poolsToDisplayProvider = _PoolsToDisplayFamily();

/// See also [_poolsToDisplay].
class _PoolsToDisplayFamily extends Family<AsyncValue<List<DexPool>>> {
  /// See also [_poolsToDisplay].
  const _PoolsToDisplayFamily();

  /// See also [_poolsToDisplay].
  _PoolsToDisplayProvider call(
    PoolsListTab currentTab,
  ) {
    return _PoolsToDisplayProvider(
      currentTab,
    );
  }

  @override
  _PoolsToDisplayProvider getProviderOverride(
    covariant _PoolsToDisplayProvider provider,
  ) {
    return call(
      provider.currentTab,
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
  String? get name => r'_poolsToDisplayProvider';
}

/// See also [_poolsToDisplay].
class _PoolsToDisplayProvider extends AutoDisposeFutureProvider<List<DexPool>> {
  /// See also [_poolsToDisplay].
  _PoolsToDisplayProvider(
    PoolsListTab currentTab,
  ) : this._internal(
          (ref) => _poolsToDisplay(
            ref as _PoolsToDisplayRef,
            currentTab,
          ),
          from: _poolsToDisplayProvider,
          name: r'_poolsToDisplayProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$poolsToDisplayHash,
          dependencies: _PoolsToDisplayFamily._dependencies,
          allTransitiveDependencies:
              _PoolsToDisplayFamily._allTransitiveDependencies,
          currentTab: currentTab,
        );

  _PoolsToDisplayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.currentTab,
  }) : super.internal();

  final PoolsListTab currentTab;

  @override
  Override overrideWith(
    FutureOr<List<DexPool>> Function(_PoolsToDisplayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _PoolsToDisplayProvider._internal(
        (ref) => create(ref as _PoolsToDisplayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        currentTab: currentTab,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DexPool>> createElement() {
    return _PoolsToDisplayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _PoolsToDisplayProvider && other.currentTab == currentTab;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, currentTab.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _PoolsToDisplayRef on AutoDisposeFutureProviderRef<List<DexPool>> {
  /// The parameter `currentTab` of this provider.
  PoolsListTab get currentTab;
}

class _PoolsToDisplayProviderElement
    extends AutoDisposeFutureProviderElement<List<DexPool>>
    with _PoolsToDisplayRef {
  _PoolsToDisplayProviderElement(super.provider);

  @override
  PoolsListTab get currentTab => (origin as _PoolsToDisplayProvider).currentTab;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
