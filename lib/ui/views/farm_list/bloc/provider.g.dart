// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$balanceHash() => r'2a521bdf28f4c1d325982472e64593f3f29531bb';

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

/// See also [_balance].
@ProviderFor(_balance)
const _balanceProvider = _BalanceFamily();

/// See also [_balance].
class _BalanceFamily extends Family<AsyncValue<double>> {
  /// See also [_balance].
  const _BalanceFamily();

  /// See also [_balance].
  _BalanceProvider call(
    String? lpTokenAddress,
  ) {
    return _BalanceProvider(
      lpTokenAddress,
    );
  }

  @override
  _BalanceProvider getProviderOverride(
    covariant _BalanceProvider provider,
  ) {
    return call(
      provider.lpTokenAddress,
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
  String? get name => r'_balanceProvider';
}

/// See also [_balance].
class _BalanceProvider extends AutoDisposeFutureProvider<double> {
  /// See also [_balance].
  _BalanceProvider(
    String? lpTokenAddress,
  ) : this._internal(
          (ref) => _balance(
            ref as _BalanceRef,
            lpTokenAddress,
          ),
          from: _balanceProvider,
          name: r'_balanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$balanceHash,
          dependencies: _BalanceFamily._dependencies,
          allTransitiveDependencies: _BalanceFamily._allTransitiveDependencies,
          lpTokenAddress: lpTokenAddress,
        );

  _BalanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lpTokenAddress,
  }) : super.internal();

  final String? lpTokenAddress;

  @override
  Override overrideWith(
    FutureOr<double> Function(_BalanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _BalanceProvider._internal(
        (ref) => create(ref as _BalanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lpTokenAddress: lpTokenAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _BalanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _BalanceProvider && other.lpTokenAddress == lpTokenAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lpTokenAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _BalanceRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `lpTokenAddress` of this provider.
  String? get lpTokenAddress;
}

class _BalanceProviderElement extends AutoDisposeFutureProviderElement<double>
    with _BalanceRef {
  _BalanceProviderElement(super.provider);

  @override
  String? get lpTokenAddress => (origin as _BalanceProvider).lpTokenAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
