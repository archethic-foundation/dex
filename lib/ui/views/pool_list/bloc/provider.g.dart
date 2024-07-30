// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$poolsListHash() => r'a8e75a1b5d75e37cb4bcbb6531dba6b4156516e8';

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

/// See also [_poolsList].
@ProviderFor(_poolsList)
const _poolsListProvider = _PoolsListFamily();

/// See also [_poolsList].
class _PoolsListFamily extends Family<AsyncValue<List<DexPool>>> {
  /// See also [_poolsList].
  const _PoolsListFamily();

  /// See also [_poolsList].
  _PoolsListProvider call(
    PoolsListTab selectedTab,
  ) {
    return _PoolsListProvider(
      selectedTab,
    );
  }

  @override
  _PoolsListProvider getProviderOverride(
    covariant _PoolsListProvider provider,
  ) {
    return call(
      provider.selectedTab,
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
  String? get name => r'_poolsListProvider';
}

/// See also [_poolsList].
class _PoolsListProvider extends AutoDisposeFutureProvider<List<DexPool>> {
  /// See also [_poolsList].
  _PoolsListProvider(
    PoolsListTab selectedTab,
  ) : this._internal(
          (ref) => _poolsList(
            ref as _PoolsListRef,
            selectedTab,
          ),
          from: _poolsListProvider,
          name: r'_poolsListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$poolsListHash,
          dependencies: _PoolsListFamily._dependencies,
          allTransitiveDependencies:
              _PoolsListFamily._allTransitiveDependencies,
          selectedTab: selectedTab,
        );

  _PoolsListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.selectedTab,
  }) : super.internal();

  final PoolsListTab selectedTab;

  @override
  Override overrideWith(
    FutureOr<List<DexPool>> Function(_PoolsListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _PoolsListProvider._internal(
        (ref) => create(ref as _PoolsListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        selectedTab: selectedTab,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DexPool>> createElement() {
    return _PoolsListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _PoolsListProvider && other.selectedTab == selectedTab;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, selectedTab.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _PoolsListRef on AutoDisposeFutureProviderRef<List<DexPool>> {
  /// The parameter `selectedTab` of this provider.
  PoolsListTab get selectedTab;
}

class _PoolsListProviderElement
    extends AutoDisposeFutureProviderElement<List<DexPool>> with _PoolsListRef {
  _PoolsListProviderElement(super.provider);

  @override
  PoolsListTab get selectedTab => (origin as _PoolsListProvider).selectedTab;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
