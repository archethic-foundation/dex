// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verified_tokens.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$verifiedTokensRepositoryHash() =>
    r'987a9d6bf9496249eaf45b2163561f0c1cca7ac8';

/// See also [_verifiedTokensRepository].
@ProviderFor(_verifiedTokensRepository)
final _verifiedTokensRepositoryProvider =
    Provider<VerifiedTokensRepositoryImpl>.internal(
  _verifiedTokensRepository,
  name: r'_verifiedTokensRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verifiedTokensRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _VerifiedTokensRepositoryRef
    = ProviderRef<VerifiedTokensRepositoryImpl>;
String _$getVerifiedTokensHash() => r'fdd8866488e517f410a06ff21dbafbbdc420d431';

/// See also [_getVerifiedTokens].
@ProviderFor(_getVerifiedTokens)
final _getVerifiedTokensProvider = FutureProvider<VerifiedTokens>.internal(
  _getVerifiedTokens,
  name: r'_getVerifiedTokensProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getVerifiedTokensHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetVerifiedTokensRef = FutureProviderRef<VerifiedTokens>;
String _$getVerifiedTokensFromNetworkHash() =>
    r'95870d8cba19d76ef4ca32d54ba71ca7f2652e99';

/// See also [_getVerifiedTokensFromNetwork].
@ProviderFor(_getVerifiedTokensFromNetwork)
final _getVerifiedTokensFromNetworkProvider =
    FutureProvider<List<String>>.internal(
  _getVerifiedTokensFromNetwork,
  name: r'_getVerifiedTokensFromNetworkProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getVerifiedTokensFromNetworkHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetVerifiedTokensFromNetworkRef = FutureProviderRef<List<String>>;
String _$isVerifiedTokenHash() => r'e83d28efbb2d4da616d3537e2d2eda8cc1b15c42';

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

/// See also [_isVerifiedToken].
@ProviderFor(_isVerifiedToken)
const _isVerifiedTokenProvider = _IsVerifiedTokenFamily();

/// See also [_isVerifiedToken].
class _IsVerifiedTokenFamily extends Family<AsyncValue<bool>> {
  /// See also [_isVerifiedToken].
  const _IsVerifiedTokenFamily();

  /// See also [_isVerifiedToken].
  _IsVerifiedTokenProvider call(
    String address,
  ) {
    return _IsVerifiedTokenProvider(
      address,
    );
  }

  @override
  _IsVerifiedTokenProvider getProviderOverride(
    covariant _IsVerifiedTokenProvider provider,
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
  String? get name => r'_isVerifiedTokenProvider';
}

/// See also [_isVerifiedToken].
class _IsVerifiedTokenProvider extends FutureProvider<bool> {
  /// See also [_isVerifiedToken].
  _IsVerifiedTokenProvider(
    String address,
  ) : this._internal(
          (ref) => _isVerifiedToken(
            ref as _IsVerifiedTokenRef,
            address,
          ),
          from: _isVerifiedTokenProvider,
          name: r'_isVerifiedTokenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isVerifiedTokenHash,
          dependencies: _IsVerifiedTokenFamily._dependencies,
          allTransitiveDependencies:
              _IsVerifiedTokenFamily._allTransitiveDependencies,
          address: address,
        );

  _IsVerifiedTokenProvider._internal(
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
    FutureOr<bool> Function(_IsVerifiedTokenRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _IsVerifiedTokenProvider._internal(
        (ref) => create(ref as _IsVerifiedTokenRef),
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
    return _IsVerifiedTokenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _IsVerifiedTokenProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _IsVerifiedTokenRef on FutureProviderRef<bool> {
  /// The parameter `address` of this provider.
  String get address;
}

class _IsVerifiedTokenProviderElement extends FutureProviderElement<bool>
    with _IsVerifiedTokenRef {
  _IsVerifiedTokenProviderElement(super.provider);

  @override
  String get address => (origin as _IsVerifiedTokenProvider).address;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
