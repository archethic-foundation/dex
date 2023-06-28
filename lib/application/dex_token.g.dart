// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_token.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String $_dexTokensRepositoryHash() =>
    r'fdeab2034c1b6b173c4a8929ba49ed9804cdfcee';

/// See also [_dexTokensRepository].
final _dexTokensRepositoryProvider = AutoDisposeProvider<DexTokensRepository>(
  _dexTokensRepository,
  name: r'_dexTokensRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_dexTokensRepositoryHash,
);
typedef _DexTokensRepositoryRef = AutoDisposeProviderRef<DexTokensRepository>;
String $_getTokenFromAddressHash() =>
    r'0a9a9e99d1b70300a25a0e1f9f68eea02079254d';

/// See also [_getTokenFromAddress].
class _GetTokenFromAddressProvider
    extends AutoDisposeFutureProvider<List<DexToken>> {
  _GetTokenFromAddressProvider(
    this.address,
  ) : super(
          (ref) => _getTokenFromAddress(
            ref,
            address,
          ),
          from: _getTokenFromAddressProvider,
          name: r'_getTokenFromAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_getTokenFromAddressHash,
        );

  final dynamic address;

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

typedef _GetTokenFromAddressRef = AutoDisposeFutureProviderRef<List<DexToken>>;

/// See also [_getTokenFromAddress].
final _getTokenFromAddressProvider = _GetTokenFromAddressFamily();

class _GetTokenFromAddressFamily extends Family<AsyncValue<List<DexToken>>> {
  _GetTokenFromAddressFamily();

  _GetTokenFromAddressProvider call(
    dynamic address,
  ) {
    return _GetTokenFromAddressProvider(
      address,
    );
  }

  @override
  AutoDisposeFutureProvider<List<DexToken>> getProviderOverride(
    covariant _GetTokenFromAddressProvider provider,
  ) {
    return call(
      provider.address,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_getTokenFromAddressProvider';
}

String $_getTokenFromAccountHash() =>
    r'212790a4193776f65c3c6f5aa0807247fa98f320';

/// See also [_getTokenFromAccount].
class _GetTokenFromAccountProvider
    extends AutoDisposeFutureProvider<List<DexToken>> {
  _GetTokenFromAccountProvider(
    this.address,
  ) : super(
          (ref) => _getTokenFromAccount(
            ref,
            address,
          ),
          from: _getTokenFromAccountProvider,
          name: r'_getTokenFromAccountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_getTokenFromAccountHash,
        );

  final dynamic address;

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

typedef _GetTokenFromAccountRef = AutoDisposeFutureProviderRef<List<DexToken>>;

/// See also [_getTokenFromAccount].
final _getTokenFromAccountProvider = _GetTokenFromAccountFamily();

class _GetTokenFromAccountFamily extends Family<AsyncValue<List<DexToken>>> {
  _GetTokenFromAccountFamily();

  _GetTokenFromAccountProvider call(
    dynamic address,
  ) {
    return _GetTokenFromAccountProvider(
      address,
    );
  }

  @override
  AutoDisposeFutureProvider<List<DexToken>> getProviderOverride(
    covariant _GetTokenFromAccountProvider provider,
  ) {
    return call(
      provider.address,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_getTokenFromAccountProvider';
}
