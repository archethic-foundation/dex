// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verified_pools.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$verifiedPoolsRepositoryHash() =>
    r'cfbd3a7fde4634e30069064489058e2f159ab94b';

/// See also [_verifiedPoolsRepository].
@ProviderFor(_verifiedPoolsRepository)
final _verifiedPoolsRepositoryProvider =
    Provider<VerifiedPoolsRepository>.internal(
  _verifiedPoolsRepository,
  name: r'_verifiedPoolsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verifiedPoolsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _VerifiedPoolsRepositoryRef = ProviderRef<VerifiedPoolsRepository>;
String _$getVerifiedPoolsHash() => r'f38411bc3ce16908e57181f6d77e24033e7ae921';

/// See also [_getVerifiedPools].
@ProviderFor(_getVerifiedPools)
final _getVerifiedPoolsProvider = FutureProvider<VerifiedPools>.internal(
  _getVerifiedPools,
  name: r'_getVerifiedPoolsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getVerifiedPoolsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetVerifiedPoolsRef = FutureProviderRef<VerifiedPools>;
String _$getVerifiedPoolsFromNetworkHash() =>
    r'ff470a24f62ec01b44163d51acf51bf8a1ad7466';

/// See also [_getVerifiedPoolsFromNetwork].
@ProviderFor(_getVerifiedPoolsFromNetwork)
final _getVerifiedPoolsFromNetworkProvider =
    FutureProvider<List<String>>.internal(
  _getVerifiedPoolsFromNetwork,
  name: r'_getVerifiedPoolsFromNetworkProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getVerifiedPoolsFromNetworkHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetVerifiedPoolsFromNetworkRef = FutureProviderRef<List<String>>;
String _$isVerifiedPoolHash() => r'25f187fe7103324e1cbc0ea6ff0602bd51cbd031';

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

/// See also [_isVerifiedPool].
@ProviderFor(_isVerifiedPool)
const _isVerifiedPoolProvider = _IsVerifiedPoolFamily();

/// See also [_isVerifiedPool].
class _IsVerifiedPoolFamily extends Family<AsyncValue<bool>> {
  /// See also [_isVerifiedPool].
  const _IsVerifiedPoolFamily();

  /// See also [_isVerifiedPool].
  _IsVerifiedPoolProvider call(
    String address,
  ) {
    return _IsVerifiedPoolProvider(
      address,
    );
  }

  @override
  _IsVerifiedPoolProvider getProviderOverride(
    covariant _IsVerifiedPoolProvider provider,
  ) {
    return call(
      provider.address,
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
  String? get name => r'_isVerifiedPoolProvider';
}

/// See also [_isVerifiedPool].
class _IsVerifiedPoolProvider extends FutureProvider<bool> {
  /// See also [_isVerifiedPool].
  _IsVerifiedPoolProvider(
    String address,
  ) : this._internal(
          (ref) => _isVerifiedPool(
            ref as _IsVerifiedPoolRef,
            address,
          ),
          from: _isVerifiedPoolProvider,
          name: r'_isVerifiedPoolProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isVerifiedPoolHash,
          dependencies: _IsVerifiedPoolFamily._dependencies,
          allTransitiveDependencies:
              _IsVerifiedPoolFamily._allTransitiveDependencies,
          address: address,
        );

  _IsVerifiedPoolProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final String address;

  @override
  Override overrideWith(
    FutureOr<bool> Function(_IsVerifiedPoolRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _IsVerifiedPoolProvider._internal(
        (ref) => create(ref as _IsVerifiedPoolRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
      ),
    );
  }

  @override
  FutureProviderElement<bool> createElement() {
    return _IsVerifiedPoolProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _IsVerifiedPoolProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _IsVerifiedPoolRef on FutureProviderRef<bool> {
  /// The parameter `address` of this provider.
  String get address;
}

class _IsVerifiedPoolProviderElement extends FutureProviderElement<bool>
    with _IsVerifiedPoolRef {
  _IsVerifiedPoolProviderElement(super.provider);

  @override
  String get address => (origin as _IsVerifiedPoolProvider).address;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
