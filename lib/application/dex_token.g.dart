// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_token.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dexTokensRepositoryHash() =>
    r'fdeab2034c1b6b173c4a8929ba49ed9804cdfcee';

/// See also [_dexTokensRepository].
@ProviderFor(_dexTokensRepository)
final _dexTokensRepositoryProvider =
    AutoDisposeProvider<DexTokensRepository>.internal(
  _dexTokensRepository,
  name: r'_dexTokensRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dexTokensRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _DexTokensRepositoryRef = AutoDisposeProviderRef<DexTokensRepository>;
String _$getTokenFromAddressHash() =>
    r'0a9a9e99d1b70300a25a0e1f9f68eea02079254d';

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

/// See also [_getTokenFromAddress].
@ProviderFor(_getTokenFromAddress)
const _getTokenFromAddressProvider = _GetTokenFromAddressFamily();

/// See also [_getTokenFromAddress].
class _GetTokenFromAddressFamily extends Family<AsyncValue<List<DexToken>>> {
  /// See also [_getTokenFromAddress].
  const _GetTokenFromAddressFamily();

  /// See also [_getTokenFromAddress].
  _GetTokenFromAddressProvider call(
    dynamic address,
  ) {
    return _GetTokenFromAddressProvider(
      address,
    );
  }

  @override
  _GetTokenFromAddressProvider getProviderOverride(
    covariant _GetTokenFromAddressProvider provider,
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
  String? get name => r'_getTokenFromAddressProvider';
}

/// See also [_getTokenFromAddress].
class _GetTokenFromAddressProvider
    extends AutoDisposeFutureProvider<List<DexToken>> {
  /// See also [_getTokenFromAddress].
  _GetTokenFromAddressProvider(
    dynamic address,
  ) : this._internal(
          (ref) => _getTokenFromAddress(
            ref as _GetTokenFromAddressRef,
            address,
          ),
          from: _getTokenFromAddressProvider,
          name: r'_getTokenFromAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTokenFromAddressHash,
          dependencies: _GetTokenFromAddressFamily._dependencies,
          allTransitiveDependencies:
              _GetTokenFromAddressFamily._allTransitiveDependencies,
          address: address,
        );

  _GetTokenFromAddressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final dynamic address;

  @override
  Override overrideWith(
    FutureOr<List<DexToken>> Function(_GetTokenFromAddressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetTokenFromAddressProvider._internal(
        (ref) => create(ref as _GetTokenFromAddressRef),
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
  AutoDisposeFutureProviderElement<List<DexToken>> createElement() {
    return _GetTokenFromAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetTokenFromAddressProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetTokenFromAddressRef on AutoDisposeFutureProviderRef<List<DexToken>> {
  /// The parameter `address` of this provider.
  dynamic get address;
}

class _GetTokenFromAddressProviderElement
    extends AutoDisposeFutureProviderElement<List<DexToken>>
    with _GetTokenFromAddressRef {
  _GetTokenFromAddressProviderElement(super.provider);

  @override
  dynamic get address => (origin as _GetTokenFromAddressProvider).address;
}

String _$getTokenFromAccountHash() =>
    r'6f6dc2e149e9fadf7fafe64e53a04a65177ad5a7';

/// See also [_getTokenFromAccount].
@ProviderFor(_getTokenFromAccount)
const _getTokenFromAccountProvider = _GetTokenFromAccountFamily();

/// See also [_getTokenFromAccount].
class _GetTokenFromAccountFamily extends Family<AsyncValue<List<DexToken>>> {
  /// See also [_getTokenFromAccount].
  const _GetTokenFromAccountFamily();

  /// See also [_getTokenFromAccount].
  _GetTokenFromAccountProvider call(
    dynamic address,
  ) {
    return _GetTokenFromAccountProvider(
      address,
    );
  }

  @override
  _GetTokenFromAccountProvider getProviderOverride(
    covariant _GetTokenFromAccountProvider provider,
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
  String? get name => r'_getTokenFromAccountProvider';
}

/// See also [_getTokenFromAccount].
class _GetTokenFromAccountProvider
    extends AutoDisposeFutureProvider<List<DexToken>> {
  /// See also [_getTokenFromAccount].
  _GetTokenFromAccountProvider(
    dynamic address,
  ) : this._internal(
          (ref) => _getTokenFromAccount(
            ref as _GetTokenFromAccountRef,
            address,
          ),
          from: _getTokenFromAccountProvider,
          name: r'_getTokenFromAccountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTokenFromAccountHash,
          dependencies: _GetTokenFromAccountFamily._dependencies,
          allTransitiveDependencies:
              _GetTokenFromAccountFamily._allTransitiveDependencies,
          address: address,
        );

  _GetTokenFromAccountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final dynamic address;

  @override
  Override overrideWith(
    FutureOr<List<DexToken>> Function(_GetTokenFromAccountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetTokenFromAccountProvider._internal(
        (ref) => create(ref as _GetTokenFromAccountRef),
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
  AutoDisposeFutureProviderElement<List<DexToken>> createElement() {
    return _GetTokenFromAccountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetTokenFromAccountProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetTokenFromAccountRef on AutoDisposeFutureProviderRef<List<DexToken>> {
  /// The parameter `address` of this provider.
  dynamic get address;
}

class _GetTokenFromAccountProviderElement
    extends AutoDisposeFutureProviderElement<List<DexToken>>
    with _GetTokenFromAccountRef {
  _GetTokenFromAccountProviderElement(super.provider);

  @override
  dynamic get address => (origin as _GetTokenFromAccountProvider).address;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
