// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'low_uco_in_dollars_warning_value.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$checkLowUCOInDollarsWarningValueHash() =>
    r'b8e87c7dd6d71b9ea8917e97b1ba2a597e4f221d';

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

/// See also [checkLowUCOInDollarsWarningValue].
@ProviderFor(checkLowUCOInDollarsWarningValue)
const checkLowUCOInDollarsWarningValueProvider =
    CheckLowUCOInDollarsWarningValueFamily();

/// See also [checkLowUCOInDollarsWarningValue].
class CheckLowUCOInDollarsWarningValueFamily extends Family<bool> {
  /// See also [checkLowUCOInDollarsWarningValue].
  const CheckLowUCOInDollarsWarningValueFamily();

  /// See also [checkLowUCOInDollarsWarningValue].
  CheckLowUCOInDollarsWarningValueProvider call(
    double balance,
    double amount,
  ) {
    return CheckLowUCOInDollarsWarningValueProvider(
      balance,
      amount,
    );
  }

  @override
  CheckLowUCOInDollarsWarningValueProvider getProviderOverride(
    covariant CheckLowUCOInDollarsWarningValueProvider provider,
  ) {
    return call(
      provider.balance,
      provider.amount,
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
  String? get name => r'checkLowUCOInDollarsWarningValueProvider';
}

/// See also [checkLowUCOInDollarsWarningValue].
class CheckLowUCOInDollarsWarningValueProvider
    extends AutoDisposeProvider<bool> {
  /// See also [checkLowUCOInDollarsWarningValue].
  CheckLowUCOInDollarsWarningValueProvider(
    double balance,
    double amount,
  ) : this._internal(
          (ref) => checkLowUCOInDollarsWarningValue(
            ref as CheckLowUCOInDollarsWarningValueRef,
            balance,
            amount,
          ),
          from: checkLowUCOInDollarsWarningValueProvider,
          name: r'checkLowUCOInDollarsWarningValueProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkLowUCOInDollarsWarningValueHash,
          dependencies: CheckLowUCOInDollarsWarningValueFamily._dependencies,
          allTransitiveDependencies:
              CheckLowUCOInDollarsWarningValueFamily._allTransitiveDependencies,
          balance: balance,
          amount: amount,
        );

  CheckLowUCOInDollarsWarningValueProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.balance,
    required this.amount,
  }) : super.internal();

  final double balance;
  final double amount;

  @override
  Override overrideWith(
    bool Function(CheckLowUCOInDollarsWarningValueRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CheckLowUCOInDollarsWarningValueProvider._internal(
        (ref) => create(ref as CheckLowUCOInDollarsWarningValueRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        balance: balance,
        amount: amount,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _CheckLowUCOInDollarsWarningValueProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckLowUCOInDollarsWarningValueProvider &&
        other.balance == balance &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, balance.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CheckLowUCOInDollarsWarningValueRef on AutoDisposeProviderRef<bool> {
  /// The parameter `balance` of this provider.
  double get balance;

  /// The parameter `amount` of this provider.
  double get amount;
}

class _CheckLowUCOInDollarsWarningValueProviderElement
    extends AutoDisposeProviderElement<bool>
    with CheckLowUCOInDollarsWarningValueRef {
  _CheckLowUCOInDollarsWarningValueProviderElement(super.provider);

  @override
  double get balance =>
      (origin as CheckLowUCOInDollarsWarningValueProvider).balance;
  @override
  double get amount =>
      (origin as CheckLowUCOInDollarsWarningValueProvider).amount;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
