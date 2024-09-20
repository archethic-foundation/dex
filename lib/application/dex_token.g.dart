// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_token.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dexTokenRepositoryHash() =>
    r'ade02ca17b75a909abb603d932b162020132aaaf';

/// See also [_dexTokenRepository].
@ProviderFor(_dexTokenRepository)
final _dexTokenRepositoryProvider =
    AutoDisposeProvider<DexTokenRepositoryImpl>.internal(
  _dexTokenRepository,
  name: r'_dexTokenRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dexTokenRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _DexTokenRepositoryRef = AutoDisposeProviderRef<DexTokenRepositoryImpl>;
String _$getTokenFromAddressHash() =>
    r'cf8e812a1e9ba63434814666d403198598251bc8';

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
class _GetTokenFromAddressFamily extends Family<AsyncValue<DexToken?>> {
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
    extends AutoDisposeFutureProvider<DexToken?> {
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
    FutureOr<DexToken?> Function(_GetTokenFromAddressRef provider) create,
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
  AutoDisposeFutureProviderElement<DexToken?> createElement() {
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

mixin _GetTokenFromAddressRef on AutoDisposeFutureProviderRef<DexToken?> {
  /// The parameter `address` of this provider.
  dynamic get address;
}

class _GetTokenFromAddressProviderElement
    extends AutoDisposeFutureProviderElement<DexToken?>
    with _GetTokenFromAddressRef {
  _GetTokenFromAddressProviderElement(super.provider);

  @override
  dynamic get address => (origin as _GetTokenFromAddressProvider).address;
}

String _$getTokenFromAccountHash() =>
    r'adf8602761f3b03e95f3bb285434ff6b1b97f35f';

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

String _$dexTokenDescriptionsHash() =>
    r'b120b6d2c566c6d43bae4e8b4fb71acb6f3c6412';

/// See also [_dexTokenDescriptions].
@ProviderFor(_dexTokenDescriptions)
final _dexTokenDescriptionsProvider =
    AutoDisposeFutureProvider<List<DexTokenDescription>>.internal(
  _dexTokenDescriptions,
  name: r'_dexTokenDescriptionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dexTokenDescriptionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _DexTokenDescriptionsRef
    = AutoDisposeFutureProviderRef<List<DexTokenDescription>>;
String _$dexTokenDescriptionHash() =>
    r'0dae4932f1e2a73a5ffe6ab0ba808b45708e7ef8';

/// See also [_dexTokenDescription].
@ProviderFor(_dexTokenDescription)
const _dexTokenDescriptionProvider = _DexTokenDescriptionFamily();

/// See also [_dexTokenDescription].
class _DexTokenDescriptionFamily
    extends Family<AsyncValue<DexTokenDescription?>> {
  /// See also [_dexTokenDescription].
  const _DexTokenDescriptionFamily();

  /// See also [_dexTokenDescription].
  _DexTokenDescriptionProvider call(
    String address,
  ) {
    return _DexTokenDescriptionProvider(
      address,
    );
  }

  @override
  _DexTokenDescriptionProvider getProviderOverride(
    covariant _DexTokenDescriptionProvider provider,
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
  String? get name => r'_dexTokenDescriptionProvider';
}

/// See also [_dexTokenDescription].
class _DexTokenDescriptionProvider
    extends AutoDisposeFutureProvider<DexTokenDescription?> {
  /// See also [_dexTokenDescription].
  _DexTokenDescriptionProvider(
    String address,
  ) : this._internal(
          (ref) => _dexTokenDescription(
            ref as _DexTokenDescriptionRef,
            address,
          ),
          from: _dexTokenDescriptionProvider,
          name: r'_dexTokenDescriptionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dexTokenDescriptionHash,
          dependencies: _DexTokenDescriptionFamily._dependencies,
          allTransitiveDependencies:
              _DexTokenDescriptionFamily._allTransitiveDependencies,
          address: address,
        );

  _DexTokenDescriptionProvider._internal(
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
    FutureOr<DexTokenDescription?> Function(_DexTokenDescriptionRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _DexTokenDescriptionProvider._internal(
        (ref) => create(ref as _DexTokenDescriptionRef),
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
  AutoDisposeFutureProviderElement<DexTokenDescription?> createElement() {
    return _DexTokenDescriptionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _DexTokenDescriptionProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _DexTokenDescriptionRef
    on AutoDisposeFutureProviderRef<DexTokenDescription?> {
  /// The parameter `address` of this provider.
  String get address;
}

class _DexTokenDescriptionProviderElement
    extends AutoDisposeFutureProviderElement<DexTokenDescription?>
    with _DexTokenDescriptionRef {
  _DexTokenDescriptionProviderElement(super.provider);

  @override
  String get address => (origin as _DexTokenDescriptionProvider).address;
}

String _$getTokenIconHash() => r'f855dac1325cbc3b54cb4e8f5d3fef0c9311847d';

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

String _$estimateTokenInFiatHash() =>
    r'4da060e8331e874aade07955209404b1444a3947';

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
class _EstimateTokenInFiatProvider extends FutureProvider<double> {
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
  FutureProviderElement<double> createElement() {
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

mixin _EstimateTokenInFiatRef on FutureProviderRef<double> {
  /// The parameter `token` of this provider.
  DexToken get token;
}

class _EstimateTokenInFiatProviderElement extends FutureProviderElement<double>
    with _EstimateTokenInFiatRef {
  _EstimateTokenInFiatProviderElement(super.provider);

  @override
  DexToken get token => (origin as _EstimateTokenInFiatProvider).token;
}

String _$estimateLPTokenInFiatHash() =>
    r'2246df0af9c65196a7b71371c7bc2da3cbaf246f';

/// See also [_estimateLPTokenInFiat].
@ProviderFor(_estimateLPTokenInFiat)
const _estimateLPTokenInFiatProvider = _EstimateLPTokenInFiatFamily();

/// See also [_estimateLPTokenInFiat].
class _EstimateLPTokenInFiatFamily extends Family<AsyncValue<double>> {
  /// See also [_estimateLPTokenInFiat].
  const _EstimateLPTokenInFiatFamily();

  /// See also [_estimateLPTokenInFiat].
  _EstimateLPTokenInFiatProvider call(
    DexToken token1,
    DexToken token2,
    double lpTokenAmount,
    String poolAddress,
  ) {
    return _EstimateLPTokenInFiatProvider(
      token1,
      token2,
      lpTokenAmount,
      poolAddress,
    );
  }

  @override
  _EstimateLPTokenInFiatProvider getProviderOverride(
    covariant _EstimateLPTokenInFiatProvider provider,
  ) {
    return call(
      provider.token1,
      provider.token2,
      provider.lpTokenAmount,
      provider.poolAddress,
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
  String? get name => r'_estimateLPTokenInFiatProvider';
}

/// See also [_estimateLPTokenInFiat].
class _EstimateLPTokenInFiatProvider extends FutureProvider<double> {
  /// See also [_estimateLPTokenInFiat].
  _EstimateLPTokenInFiatProvider(
    DexToken token1,
    DexToken token2,
    double lpTokenAmount,
    String poolAddress,
  ) : this._internal(
          (ref) => _estimateLPTokenInFiat(
            ref as _EstimateLPTokenInFiatRef,
            token1,
            token2,
            lpTokenAmount,
            poolAddress,
          ),
          from: _estimateLPTokenInFiatProvider,
          name: r'_estimateLPTokenInFiatProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$estimateLPTokenInFiatHash,
          dependencies: _EstimateLPTokenInFiatFamily._dependencies,
          allTransitiveDependencies:
              _EstimateLPTokenInFiatFamily._allTransitiveDependencies,
          token1: token1,
          token2: token2,
          lpTokenAmount: lpTokenAmount,
          poolAddress: poolAddress,
        );

  _EstimateLPTokenInFiatProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.token1,
    required this.token2,
    required this.lpTokenAmount,
    required this.poolAddress,
  }) : super.internal();

  final DexToken token1;
  final DexToken token2;
  final double lpTokenAmount;
  final String poolAddress;

  @override
  Override overrideWith(
    FutureOr<double> Function(_EstimateLPTokenInFiatRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _EstimateLPTokenInFiatProvider._internal(
        (ref) => create(ref as _EstimateLPTokenInFiatRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        token1: token1,
        token2: token2,
        lpTokenAmount: lpTokenAmount,
        poolAddress: poolAddress,
      ),
    );
  }

  @override
  FutureProviderElement<double> createElement() {
    return _EstimateLPTokenInFiatProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _EstimateLPTokenInFiatProvider &&
        other.token1 == token1 &&
        other.token2 == token2 &&
        other.lpTokenAmount == lpTokenAmount &&
        other.poolAddress == poolAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token1.hashCode);
    hash = _SystemHash.combine(hash, token2.hashCode);
    hash = _SystemHash.combine(hash, lpTokenAmount.hashCode);
    hash = _SystemHash.combine(hash, poolAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _EstimateLPTokenInFiatRef on FutureProviderRef<double> {
  /// The parameter `token1` of this provider.
  DexToken get token1;

  /// The parameter `token2` of this provider.
  DexToken get token2;

  /// The parameter `lpTokenAmount` of this provider.
  double get lpTokenAmount;

  /// The parameter `poolAddress` of this provider.
  String get poolAddress;
}

class _EstimateLPTokenInFiatProviderElement
    extends FutureProviderElement<double> with _EstimateLPTokenInFiatRef {
  _EstimateLPTokenInFiatProviderElement(super.provider);

  @override
  DexToken get token1 => (origin as _EstimateLPTokenInFiatProvider).token1;
  @override
  DexToken get token2 => (origin as _EstimateLPTokenInFiatProvider).token2;
  @override
  double get lpTokenAmount =>
      (origin as _EstimateLPTokenInFiatProvider).lpTokenAmount;
  @override
  String get poolAddress =>
      (origin as _EstimateLPTokenInFiatProvider).poolAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
