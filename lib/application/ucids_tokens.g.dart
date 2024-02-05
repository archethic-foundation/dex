// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ucids_tokens.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ucidsTokensRepositoryHash() =>
    r'9f920f785a6782fb0089a11caa73f88a388b4d50';

/// See also [_ucidsTokensRepository].
@ProviderFor(_ucidsTokensRepository)
final _ucidsTokensRepositoryProvider =
    Provider<UcidsTokensRepositoryImpl>.internal(
  _ucidsTokensRepository,
  name: r'_ucidsTokensRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ucidsTokensRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _UcidsTokensRepositoryRef = ProviderRef<UcidsTokensRepositoryImpl>;
String _$getUcidsTokensHash() => r'1f2e6f3f0d5af713ec0e916a64a420ebcb136810';

/// See also [_getUcidsTokens].
@ProviderFor(_getUcidsTokens)
final _getUcidsTokensProvider = FutureProvider<UcidsTokens>.internal(
  _getUcidsTokens,
  name: r'_getUcidsTokensProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getUcidsTokensHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetUcidsTokensRef = FutureProviderRef<UcidsTokens>;
String _$getUcidsTokensFromNetworkHash() =>
    r'fea8de4fa85c8aa43752ee3c589f994775df98f1';

/// See also [_getUcidsTokensFromNetwork].
@ProviderFor(_getUcidsTokensFromNetwork)
final _getUcidsTokensFromNetworkProvider =
    FutureProvider<Map<String, int>>.internal(
  _getUcidsTokensFromNetwork,
  name: r'_getUcidsTokensFromNetworkProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getUcidsTokensFromNetworkHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetUcidsTokensFromNetworkRef = FutureProviderRef<Map<String, int>>;
String _$getUcidFromAddressHash() =>
    r'0e954f4ecfc46d430a93dd5fa87cf4fb3183bf13';

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

/// See also [_getUcidFromAddress].
@ProviderFor(_getUcidFromAddress)
const _getUcidFromAddressProvider = _GetUcidFromAddressFamily();

/// See also [_getUcidFromAddress].
class _GetUcidFromAddressFamily extends Family<AsyncValue<int>> {
  /// See also [_getUcidFromAddress].
  const _GetUcidFromAddressFamily();

  /// See also [_getUcidFromAddress].
  _GetUcidFromAddressProvider call(
    String address,
  ) {
    return _GetUcidFromAddressProvider(
      address,
    );
  }

  @override
  _GetUcidFromAddressProvider getProviderOverride(
    covariant _GetUcidFromAddressProvider provider,
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
  String? get name => r'_getUcidFromAddressProvider';
}

/// See also [_getUcidFromAddress].
class _GetUcidFromAddressProvider extends FutureProvider<int> {
  /// See also [_getUcidFromAddress].
  _GetUcidFromAddressProvider(
    String address,
  ) : this._internal(
          (ref) => _getUcidFromAddress(
            ref as _GetUcidFromAddressRef,
            address,
          ),
          from: _getUcidFromAddressProvider,
          name: r'_getUcidFromAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUcidFromAddressHash,
          dependencies: _GetUcidFromAddressFamily._dependencies,
          allTransitiveDependencies:
              _GetUcidFromAddressFamily._allTransitiveDependencies,
          address: address,
        );

  _GetUcidFromAddressProvider._internal(
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
    FutureOr<int> Function(_GetUcidFromAddressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetUcidFromAddressProvider._internal(
        (ref) => create(ref as _GetUcidFromAddressRef),
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
  FutureProviderElement<int> createElement() {
    return _GetUcidFromAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetUcidFromAddressProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetUcidFromAddressRef on FutureProviderRef<int> {
  /// The parameter `address` of this provider.
  String get address;
}

class _GetUcidFromAddressProviderElement extends FutureProviderElement<int>
    with _GetUcidFromAddressRef {
  _GetUcidFromAddressProviderElement(super.provider);

  @override
  String get address => (origin as _GetUcidFromAddressProvider).address;
}

String _$ucidsTokensNotifierHash() =>
    r'b0a107d3c9a7e36c293d810c83be9fe914bf5450';

/// See also [_UcidsTokensNotifier].
@ProviderFor(_UcidsTokensNotifier)
final _ucidsTokensNotifierProvider =
    NotifierProvider<_UcidsTokensNotifier, Map<String, int>>.internal(
  _UcidsTokensNotifier.new,
  name: r'_ucidsTokensNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ucidsTokensNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UcidsTokensNotifier = Notifier<Map<String, int>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
