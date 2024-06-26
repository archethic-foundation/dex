// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$balanceRepositoryHash() => r'694ad0789c371d8ff21073c2834711009024d9ae';

/// See also [_balanceRepository].
@ProviderFor(_balanceRepository)
final _balanceRepositoryProvider =
    AutoDisposeProvider<BalanceRepository>.internal(
  _balanceRepository,
  name: r'_balanceRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$balanceRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _BalanceRepositoryRef = AutoDisposeProviderRef<BalanceRepository>;
String _$getBalanceHash() => r'674952bdad70b137bd8f679e3499d6cea0cd64a4';

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

/// See also [_getBalance].
@ProviderFor(_getBalance)
const _getBalanceProvider = _GetBalanceFamily();

/// See also [_getBalance].
class _GetBalanceFamily extends Family<AsyncValue<double>> {
  /// See also [_getBalance].
  const _GetBalanceFamily();

  /// See also [_getBalance].
  _GetBalanceProvider call(
    String address,
    String tokenAddress,
  ) {
    return _GetBalanceProvider(
      address,
      tokenAddress,
    );
  }

  @override
  _GetBalanceProvider getProviderOverride(
    covariant _GetBalanceProvider provider,
  ) {
    return call(
      provider.address,
      provider.tokenAddress,
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
  String? get name => r'_getBalanceProvider';
}

/// See also [_getBalance].
class _GetBalanceProvider extends AutoDisposeFutureProvider<double> {
  /// See also [_getBalance].
  _GetBalanceProvider(
    String address,
    String tokenAddress,
  ) : this._internal(
          (ref) => _getBalance(
            ref as _GetBalanceRef,
            address,
            tokenAddress,
          ),
          from: _getBalanceProvider,
          name: r'_getBalanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBalanceHash,
          dependencies: _GetBalanceFamily._dependencies,
          allTransitiveDependencies:
              _GetBalanceFamily._allTransitiveDependencies,
          address: address,
          tokenAddress: tokenAddress,
        );

  _GetBalanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
    required this.tokenAddress,
  }) : super.internal();

  final String address;
  final String tokenAddress;

  @override
  Override overrideWith(
    FutureOr<double> Function(_GetBalanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetBalanceProvider._internal(
        (ref) => create(ref as _GetBalanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
        tokenAddress: tokenAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _GetBalanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetBalanceProvider &&
        other.address == address &&
        other.tokenAddress == tokenAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, tokenAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetBalanceRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `address` of this provider.
  String get address;

  /// The parameter `tokenAddress` of this provider.
  String get tokenAddress;
}

class _GetBalanceProviderElement
    extends AutoDisposeFutureProviderElement<double> with _GetBalanceRef {
  _GetBalanceProviderElement(super.provider);

  @override
  String get address => (origin as _GetBalanceProvider).address;
  @override
  String get tokenAddress => (origin as _GetBalanceProvider).tokenAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
