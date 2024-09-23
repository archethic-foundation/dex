// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$environmentHash() => r'f1ead46a1d72e806b4700b7d0172b9c0f505a5d8';

/// See also [environment].
@ProviderFor(environment)
final environmentProvider = Provider<Environment>.internal(
  environment,
  name: r'environmentProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$environmentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EnvironmentRef = ProviderRef<Environment>;
String _$sessionNotifierHash() => r'ad609c4a7dafa6eba52ac35cb3f11800a3aaf3bb';

/// See also [SessionNotifier].
@ProviderFor(SessionNotifier)
final sessionNotifierProvider =
    NotifierProvider<SessionNotifier, Session>.internal(
  SessionNotifier.new,
  name: r'sessionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SessionNotifier = Notifier<Session>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
