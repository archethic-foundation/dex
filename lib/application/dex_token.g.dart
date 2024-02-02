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
    r'989e930de7c534599970029d9f7c74b3459f5e81';

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
    dynamic accountAddress,
  ) {
    return _GetTokenFromAddressProvider(
      address,
      accountAddress,
    );
  }

  @override
  _GetTokenFromAddressProvider getProviderOverride(
    covariant _GetTokenFromAddressProvider provider,
  ) {
    return call(
      provider.address,
      provider.accountAddress,
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
    dynamic accountAddress,
  ) : this._internal(
          (ref) => _getTokenFromAddress(
            ref as _GetTokenFromAddressRef,
            address,
            accountAddress,
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
          accountAddress: accountAddress,
        );

  _GetTokenFromAddressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
    required this.accountAddress,
  }) : super.internal();

  final dynamic address;
  final dynamic accountAddress;

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
        accountAddress: accountAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DexToken>> createElement() {
    return _GetTokenFromAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetTokenFromAddressProvider &&
        other.address == address &&
        other.accountAddress == accountAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, accountAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetTokenFromAddressRef on AutoDisposeFutureProviderRef<List<DexToken>> {
  /// The parameter `address` of this provider.
  dynamic get address;

  /// The parameter `accountAddress` of this provider.
  dynamic get accountAddress;
}

class _GetTokenFromAddressProviderElement
    extends AutoDisposeFutureProviderElement<List<DexToken>>
    with _GetTokenFromAddressRef {
  _GetTokenFromAddressProviderElement(super.provider);

  @override
  dynamic get address => (origin as _GetTokenFromAddressProvider).address;
  @override
  dynamic get accountAddress =>
      (origin as _GetTokenFromAddressProvider).accountAddress;
}

String _$getTokenFromAccountHash() =>
    r'cced3582394bc7ba66181da5b63388c422db707a';

/// See also [_getTokenFromAccount].
@ProviderFor(_getTokenFromAccount)
const _getTokenFromAccountProvider = _GetTokenFromAccountFamily();

/// See also [_getTokenFromAccount].
class _GetTokenFromAccountFamily extends Family<AsyncValue<List<DexToken>>> {
  /// See also [_getTokenFromAccount].
  const _GetTokenFromAccountFamily();

  /// See also [_getTokenFromAccount].
  _GetTokenFromAccountProvider call(
    dynamic accountAddress,
  ) {
    return _GetTokenFromAccountProvider(
      accountAddress,
    );
  }

  @override
  _GetTokenFromAccountProvider getProviderOverride(
    covariant _GetTokenFromAccountProvider provider,
  ) {
    return call(
      provider.accountAddress,
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
    dynamic accountAddress,
  ) : this._internal(
          (ref) => _getTokenFromAccount(
            ref as _GetTokenFromAccountRef,
            accountAddress,
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
          accountAddress: accountAddress,
        );

  _GetTokenFromAccountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.accountAddress,
  }) : super.internal();

  final dynamic accountAddress;

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
        accountAddress: accountAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DexToken>> createElement() {
    return _GetTokenFromAccountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetTokenFromAccountProvider &&
        other.accountAddress == accountAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetTokenFromAccountRef on AutoDisposeFutureProviderRef<List<DexToken>> {
  /// The parameter `accountAddress` of this provider.
  dynamic get accountAddress;
}

class _GetTokenFromAccountProviderElement
    extends AutoDisposeFutureProviderElement<List<DexToken>>
    with _GetTokenFromAccountRef {
  _GetTokenFromAccountProviderElement(super.provider);

  @override
  dynamic get accountAddress =>
      (origin as _GetTokenFromAccountProvider).accountAddress;
}

String _$getTokenIconHash() => r'c34c61639fdac99ae3b6c450f7b21d3029b00b30';

/// See also [_getTokenIcon].
@ProviderFor(_getTokenIcon)
const _getTokenIconProvider = _GetTokenIconFamily();

/// See also [_getTokenIcon].
class _GetTokenIconFamily extends Family<AsyncValue<String?>> {
  /// See also [_getTokenIcon].
  const _GetTokenIconFamily();

  /// See also [_getTokenIcon].
  _GetTokenIconProvider call(
    dynamic address,
  ) {
    return _GetTokenIconProvider(
      address,
    );
  }

  @override
  _GetTokenIconProvider getProviderOverride(
    covariant _GetTokenIconProvider provider,
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
  String? get name => r'_getTokenIconProvider';
}

/// See also [_getTokenIcon].
class _GetTokenIconProvider extends AutoDisposeFutureProvider<String?> {
  /// See also [_getTokenIcon].
  _GetTokenIconProvider(
    dynamic address,
  ) : this._internal(
          (ref) => _getTokenIcon(
            ref as _GetTokenIconRef,
            address,
          ),
          from: _getTokenIconProvider,
          name: r'_getTokenIconProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTokenIconHash,
          dependencies: _GetTokenIconFamily._dependencies,
          allTransitiveDependencies:
              _GetTokenIconFamily._allTransitiveDependencies,
          address: address,
        );

  _GetTokenIconProvider._internal(
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
    FutureOr<String?> Function(_GetTokenIconRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetTokenIconProvider._internal(
        (ref) => create(ref as _GetTokenIconRef),
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
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _GetTokenIconProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetTokenIconProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetTokenIconRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `address` of this provider.
  dynamic get address;
}

class _GetTokenIconProviderElement
    extends AutoDisposeFutureProviderElement<String?> with _GetTokenIconRef {
  _GetTokenIconProviderElement(super.provider);

  @override
  dynamic get address => (origin as _GetTokenIconProvider).address;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
