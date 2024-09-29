// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$environmentHash() => r'f34c016a6abe9568da747b375457943ff011096f';

/// See also [environment].
@ProviderFor(environment)
final environmentProvider = AutoDisposeProvider<Environment>.internal(
  environment,
  name: r'environmentProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$environmentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EnvironmentRef = AutoDisposeProviderRef<Environment>;
String _$sessionNotifierHash() => r'966a0782eeb65e553bafcd6b75efebd9b80bf6ef';

/// See also [SessionNotifier].
@ProviderFor(SessionNotifier)
final sessionNotifierProvider =
    AutoDisposeNotifierProvider<SessionNotifier, Session>.internal(
  SessionNotifier.new,
  name: r'sessionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SessionNotifier = AutoDisposeNotifier<Session>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
