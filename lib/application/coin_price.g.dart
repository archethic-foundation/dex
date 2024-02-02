// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_price.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$coinPriceFromSymbolHash() =>
    r'597f23c43454e23443b079c78c3693da2ca0b2c5';

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

/// See also [_coinPriceFromSymbol].
@ProviderFor(_coinPriceFromSymbol)
const _coinPriceFromSymbolProvider = _CoinPriceFromSymbolFamily();

/// See also [_coinPriceFromSymbol].
class _CoinPriceFromSymbolFamily extends Family<AsyncValue<double>> {
  /// See also [_coinPriceFromSymbol].
  const _CoinPriceFromSymbolFamily();

  /// See also [_coinPriceFromSymbol].
  _CoinPriceFromSymbolProvider call(
    String symbol,
  ) {
    return _CoinPriceFromSymbolProvider(
      symbol,
    );
  }

  @override
  _CoinPriceFromSymbolProvider getProviderOverride(
    covariant _CoinPriceFromSymbolProvider provider,
  ) {
    return call(
      provider.symbol,
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
  String? get name => r'_coinPriceFromSymbolProvider';
}

/// See also [_coinPriceFromSymbol].
class _CoinPriceFromSymbolProvider extends AutoDisposeFutureProvider<double> {
  /// See also [_coinPriceFromSymbol].
  _CoinPriceFromSymbolProvider(
    String symbol,
  ) : this._internal(
          (ref) => _coinPriceFromSymbol(
            ref as _CoinPriceFromSymbolRef,
            symbol,
          ),
          from: _coinPriceFromSymbolProvider,
          name: r'_coinPriceFromSymbolProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$coinPriceFromSymbolHash,
          dependencies: _CoinPriceFromSymbolFamily._dependencies,
          allTransitiveDependencies:
              _CoinPriceFromSymbolFamily._allTransitiveDependencies,
          symbol: symbol,
        );

  _CoinPriceFromSymbolProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.symbol,
  }) : super.internal();

  final String symbol;

  @override
  Override overrideWith(
    FutureOr<double> Function(_CoinPriceFromSymbolRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _CoinPriceFromSymbolProvider._internal(
        (ref) => create(ref as _CoinPriceFromSymbolRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        symbol: symbol,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _CoinPriceFromSymbolProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _CoinPriceFromSymbolProvider && other.symbol == symbol;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, symbol.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _CoinPriceFromSymbolRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `symbol` of this provider.
  String get symbol;
}

class _CoinPriceFromSymbolProviderElement
    extends AutoDisposeFutureProviderElement<double>
    with _CoinPriceFromSymbolRef {
  _CoinPriceFromSymbolProviderElement(super.provider);

  @override
  String get symbol => (origin as _CoinPriceFromSymbolProvider).symbol;
}

String _$coinPriceNotifierHash() => r'f6a23db9eca646e33b4e71b15641a6edc75add75';

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
