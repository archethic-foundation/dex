import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/token_selection/bloc/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _tokenSelectionFormProvider = NotifierProvider.autoDispose<
    TokenSelectionFormNotifier, TokenSelectionFormState>(
  () {
    return TokenSelectionFormNotifier();
  },
);

class TokenSelectionFormNotifier
    extends AutoDisposeNotifier<TokenSelectionFormState> {
  TokenSelectionFormNotifier();

  @override
  TokenSelectionFormState build() => const TokenSelectionFormState();

  Future<void> setSearchText(
    String searchText,
  ) async {
    state = state.copyWith(
      searchText: searchText,
      result: [],
    );

    if (state.isAddress) {
      final session = ref.read(SessionProviders.session);
      final token = await ref.read(
        DexTokensProviders.getTokenFromAddress(
          searchText,
          session.genesisAddress,
        ).future,
      );

      state = state.copyWith(
        result: token,
      );
    }
  }
}

abstract class TokenSelectionFormProvider {
  static final tokenSelectionForm = _tokenSelectionFormProvider;
}
