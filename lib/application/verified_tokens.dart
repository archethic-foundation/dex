import 'package:aedex/application/session/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verified_tokens.g.dart';

@Riverpod(keepAlive: true)
aedappfm.VerifiedTokensRepositoryInterface verifiedTokensRepository(
  VerifiedTokensRepositoryRef ref,
) {
  final environment = ref.watch(environmentProvider);
  return ref.watch(
    aedappfm.VerifiedTokensProviders.verifiedTokensRepository(environment),
  );
}
