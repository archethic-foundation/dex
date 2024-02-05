// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_price.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$coinPriceFromAddressHash() =>
    r'01bfd7816f627f416adb9aae748bd7834837c852';

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

/// See also [_coinPriceFromAddress].
@ProviderFor(_coinPriceFromAddress)
const _coinPriceFromAddressProvider = _CoinPriceFromAddressFamily();

/// See also [_coinPriceFromAddress].
class _CoinPriceFromAddressFamily extends Family<double> {
  /// See also [_coinPriceFromAddress].
  const _CoinPriceFromAddressFamily();

  /// See also [_coinPriceFromAddress].
  _CoinPriceFromAddressProvider call(
    String address,
  ) {
    return _CoinPriceFromAddressProvider(
      address,
    );
  }

  @override
  _CoinPriceFromAddressProvider getProviderOverride(
    covariant _CoinPriceFromAddressProvider provider,
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
  String? get name => r'_coinPriceFromAddressProvider';
}

/// See also [_coinPriceFromAddress].
class _CoinPriceFromAddressProvider extends AutoDisposeProvider<double> {
  /// See also [_coinPriceFromAddress].
  _CoinPriceFromAddressProvider(
    String address,
  ) : this._internal(
          (ref) => _coinPriceFromAddress(
            ref as _CoinPriceFromAddressRef,
            address,
          ),
          from: _coinPriceFromAddressProvider,
          name: r'_coinPriceFromAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$coinPriceFromAddressHash,
          dependencies: _CoinPriceFromAddressFamily._dependencies,
          allTransitiveDependencies:
              _CoinPriceFromAddressFamily._allTransitiveDependencies,
          address: address,
        );

  _CoinPriceFromAddressProvider._internal(
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
    double Function(_CoinPriceFromAddressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _CoinPriceFromAddressProvider._internal(
        (ref) => create(ref as _CoinPriceFromAddressRef),
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
  AutoDisposeProviderElement<double> createElement() {
    return _CoinPriceFromAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _CoinPriceFromAddressProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _CoinPriceFromAddressRef on AutoDisposeProviderRef<double> {
  /// The parameter `address` of this provider.
  String get address;
}

class _CoinPriceFromAddressProviderElement
    extends AutoDisposeProviderElement<double> with _CoinPriceFromAddressRef {
  _CoinPriceFromAddressProviderElement(super.provider);

  @override
  String get address => (origin as _CoinPriceFromAddressProvider).address;
}

String _$coinPriceNotifierHash() => r'ff36016167b22c11a63a1aa63ec71e39f425c30f';

/// See also [_CoinPriceNotifier].
@ProviderFor(_CoinPriceNotifier)
final _coinPriceNotifierProvider =
    NotifierProvider<_CoinPriceNotifier, CryptoPrice>.internal(
  _CoinPriceNotifier.new,
  name: r'_coinPriceNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$coinPriceNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CoinPriceNotifier = Notifier<CryptoPrice>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
