// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sortedUserFarmLocksHash() =>
    r'5e5c25927ddfcf3201ea09172f0ce6894ff76632';

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

/// See also [sortedUserFarmLocks].
@ProviderFor(sortedUserFarmLocks)
const sortedUserFarmLocksProvider = SortedUserFarmLocksFamily();

/// See also [sortedUserFarmLocks].
class SortedUserFarmLocksFamily extends Family<List<DexFarmLockUserInfos>> {
  /// See also [sortedUserFarmLocks].
  const SortedUserFarmLocksFamily();

  /// See also [sortedUserFarmLocks].
  SortedUserFarmLocksProvider call(
    String? sortBy,
    bool? ascending,
  ) {
    return SortedUserFarmLocksProvider(
      sortBy,
      ascending,
    );
  }

  @override
  SortedUserFarmLocksProvider getProviderOverride(
    covariant SortedUserFarmLocksProvider provider,
  ) {
    return call(
      provider.sortBy,
      provider.ascending,
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
  String? get name => r'sortedUserFarmLocksProvider';
}

/// See also [sortedUserFarmLocks].
class SortedUserFarmLocksProvider
    extends AutoDisposeProvider<List<DexFarmLockUserInfos>> {
  /// See also [sortedUserFarmLocks].
  SortedUserFarmLocksProvider(
    String? sortBy,
    bool? ascending,
  ) : this._internal(
          (ref) => sortedUserFarmLocks(
            ref as SortedUserFarmLocksRef,
            sortBy,
            ascending,
          ),
          from: sortedUserFarmLocksProvider,
          name: r'sortedUserFarmLocksProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sortedUserFarmLocksHash,
          dependencies: SortedUserFarmLocksFamily._dependencies,
          allTransitiveDependencies:
              SortedUserFarmLocksFamily._allTransitiveDependencies,
          sortBy: sortBy,
          ascending: ascending,
        );

  SortedUserFarmLocksProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sortBy,
    required this.ascending,
  }) : super.internal();

  final String? sortBy;
  final bool? ascending;

  @override
  Override overrideWith(
    List<DexFarmLockUserInfos> Function(SortedUserFarmLocksRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SortedUserFarmLocksProvider._internal(
        (ref) => create(ref as SortedUserFarmLocksRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sortBy: sortBy,
        ascending: ascending,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<DexFarmLockUserInfos>> createElement() {
    return _SortedUserFarmLocksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SortedUserFarmLocksProvider &&
        other.sortBy == sortBy &&
        other.ascending == ascending;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sortBy.hashCode);
    hash = _SystemHash.combine(hash, ascending.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SortedUserFarmLocksRef
    on AutoDisposeProviderRef<List<DexFarmLockUserInfos>> {
  /// The parameter `sortBy` of this provider.
  String? get sortBy;

  /// The parameter `ascending` of this provider.
  bool? get ascending;
}

class _SortedUserFarmLocksProviderElement
    extends AutoDisposeProviderElement<List<DexFarmLockUserInfos>>
    with SortedUserFarmLocksRef {
  _SortedUserFarmLocksProviderElement(super.provider);

  @override
  String? get sortBy => (origin as SortedUserFarmLocksProvider).sortBy;
  @override
  bool? get ascending => (origin as SortedUserFarmLocksProvider).ascending;
}

String _$farmLockFormNotifierHash() =>
    r'ac319823982097a2cd303199dcfd955add94bcd1';

/// See also [FarmLockFormNotifier].
@ProviderFor(FarmLockFormNotifier)
final farmLockFormNotifierProvider = AutoDisposeAsyncNotifierProvider<
    FarmLockFormNotifier, FarmLockFormState>.internal(
  FarmLockFormNotifier.new,
  name: r'farmLockFormNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$farmLockFormNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FarmLockFormNotifier = AutoDisposeAsyncNotifier<FarmLockFormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
