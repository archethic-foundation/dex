// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$farmLockFormBalancesHash() =>
    r'4a4e9a531ddb7dd26b5550fbe92de058ef74052a';

/// See also [farmLockFormBalances].
@ProviderFor(farmLockFormBalances)
final farmLockFormBalancesProvider =
    AutoDisposeProvider<FarmLockFormBalances>.internal(
  farmLockFormBalances,
  name: r'farmLockFormBalancesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$farmLockFormBalancesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FarmLockFormBalancesRef = AutoDisposeProviderRef<FarmLockFormBalances>;
String _$farmLockFormSummaryHash() =>
    r'7821a41ece661e9493e3e3f9e94b44f1ce3a0f47';

/// See also [farmLockFormSummary].
@ProviderFor(farmLockFormSummary)
final farmLockFormSummaryProvider =
    AutoDisposeProvider<FarmLockFormSummary>.internal(
  farmLockFormSummary,
  name: r'farmLockFormSummaryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$farmLockFormSummaryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FarmLockFormSummaryRef = AutoDisposeProviderRef<FarmLockFormSummary>;
String _$farmLockFormPoolHash() => r'e0919af5d7966190d4c933f1d614626df7282290';

/// See also [farmLockFormPool].
@ProviderFor(farmLockFormPool)
final farmLockFormPoolProvider = AutoDisposeFutureProvider<DexPool?>.internal(
  farmLockFormPool,
  name: r'farmLockFormPoolProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$farmLockFormPoolHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FarmLockFormPoolRef = AutoDisposeFutureProviderRef<DexPool?>;
String _$farmLockFormFarmHash() => r'dffbc2a22080f79d4a620ae8e20e525d80803bf5';

/// See also [farmLockFormFarm].
@ProviderFor(farmLockFormFarm)
final farmLockFormFarmProvider = AutoDisposeFutureProvider<DexFarm?>.internal(
  farmLockFormFarm,
  name: r'farmLockFormFarmProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$farmLockFormFarmHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FarmLockFormFarmRef = AutoDisposeFutureProviderRef<DexFarm?>;
String _$farmLockFormFarmLockHash() =>
    r'5818f7b1cb6eb2f5632cd5abe9167524fccefec4';

/// See also [farmLockFormFarmLock].
@ProviderFor(farmLockFormFarmLock)
final farmLockFormFarmLockProvider =
    AutoDisposeFutureProvider<DexFarmLock?>.internal(
  farmLockFormFarmLock,
  name: r'farmLockFormFarmLockProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$farmLockFormFarmLockHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FarmLockFormFarmLockRef = AutoDisposeFutureProviderRef<DexFarmLock?>;
String _$farmLockFormSortedUserFarmLocksHash() =>
    r'20e83b7a3077b346536440ed6c3efd257706db55';

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

/// See also [farmLockFormSortedUserFarmLocks].
@ProviderFor(farmLockFormSortedUserFarmLocks)
const farmLockFormSortedUserFarmLocksProvider =
    FarmLockFormSortedUserFarmLocksFamily();

/// See also [farmLockFormSortedUserFarmLocks].
class FarmLockFormSortedUserFarmLocksFamily
    extends Family<AsyncValue<List<DexFarmLockUserInfos>>> {
  /// See also [farmLockFormSortedUserFarmLocks].
  const FarmLockFormSortedUserFarmLocksFamily();

  /// See also [farmLockFormSortedUserFarmLocks].
  FarmLockFormSortedUserFarmLocksProvider call(
    String? sortBy,
    bool? ascending,
  ) {
    return FarmLockFormSortedUserFarmLocksProvider(
      sortBy,
      ascending,
    );
  }

  @override
  FarmLockFormSortedUserFarmLocksProvider getProviderOverride(
    covariant FarmLockFormSortedUserFarmLocksProvider provider,
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
  String? get name => r'farmLockFormSortedUserFarmLocksProvider';
}

/// See also [farmLockFormSortedUserFarmLocks].
class FarmLockFormSortedUserFarmLocksProvider
    extends AutoDisposeFutureProvider<List<DexFarmLockUserInfos>> {
  /// See also [farmLockFormSortedUserFarmLocks].
  FarmLockFormSortedUserFarmLocksProvider(
    String? sortBy,
    bool? ascending,
  ) : this._internal(
          (ref) => farmLockFormSortedUserFarmLocks(
            ref as FarmLockFormSortedUserFarmLocksRef,
            sortBy,
            ascending,
          ),
          from: farmLockFormSortedUserFarmLocksProvider,
          name: r'farmLockFormSortedUserFarmLocksProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$farmLockFormSortedUserFarmLocksHash,
          dependencies: FarmLockFormSortedUserFarmLocksFamily._dependencies,
          allTransitiveDependencies:
              FarmLockFormSortedUserFarmLocksFamily._allTransitiveDependencies,
          sortBy: sortBy,
          ascending: ascending,
        );

  FarmLockFormSortedUserFarmLocksProvider._internal(
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
    FutureOr<List<DexFarmLockUserInfos>> Function(
            FarmLockFormSortedUserFarmLocksRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FarmLockFormSortedUserFarmLocksProvider._internal(
        (ref) => create(ref as FarmLockFormSortedUserFarmLocksRef),
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
  AutoDisposeFutureProviderElement<List<DexFarmLockUserInfos>> createElement() {
    return _FarmLockFormSortedUserFarmLocksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FarmLockFormSortedUserFarmLocksProvider &&
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

mixin FarmLockFormSortedUserFarmLocksRef
    on AutoDisposeFutureProviderRef<List<DexFarmLockUserInfos>> {
  /// The parameter `sortBy` of this provider.
  String? get sortBy;

  /// The parameter `ascending` of this provider.
  bool? get ascending;
}

class _FarmLockFormSortedUserFarmLocksProviderElement
    extends AutoDisposeFutureProviderElement<List<DexFarmLockUserInfos>>
    with FarmLockFormSortedUserFarmLocksRef {
  _FarmLockFormSortedUserFarmLocksProviderElement(super.provider);

  @override
  String? get sortBy =>
      (origin as FarmLockFormSortedUserFarmLocksProvider).sortBy;
  @override
  bool? get ascending =>
      (origin as FarmLockFormSortedUserFarmLocksProvider).ascending;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
