// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$poolsToDisplayHash() => r'c79c476f66ade25ce1dddc77e5fe95a439a5650d';

/// See also [poolsToDisplay].
@ProviderFor(poolsToDisplay)
final poolsToDisplayProvider =
    AutoDisposeFutureProvider<List<DexPool>>.internal(
  poolsToDisplay,
  name: r'poolsToDisplayProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$poolsToDisplayHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PoolsToDisplayRef = AutoDisposeFutureProviderRef<List<DexPool>>;
String _$poolListFormNotifierHash() =>
    r'4e0a501aad162899b02207e9fd75cb667b7fcc3a';

/// See also [PoolListFormNotifier].
@ProviderFor(PoolListFormNotifier)
final poolListFormNotifierProvider =
    NotifierProvider<PoolListFormNotifier, PoolListFormState>.internal(
  PoolListFormNotifier.new,
  name: r'poolListFormNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$poolListFormNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PoolListFormNotifier = Notifier<PoolListFormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
