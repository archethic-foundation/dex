import 'package:aedex/application/session/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_service.g.dart';

@Riverpod(keepAlive: true)
ApiService apiService(ApiServiceRef ref) {
  final environment = ref.watch(
    sessionNotifierProvider.select((session) => session.environment),
  );
  return ref.watch(aedappfm.apiServiceProvider(environment));
}