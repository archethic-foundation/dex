import 'package:aedex/application/dex_token.dart';
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

  void setSearchText(
    String searchText,
  ) {
    state = state.copyWith(
      searchText: searchText,
      result: [],
    );

    if (state.isAddress) {
      final token = ref
          .read(DexTokensProviders.getTokenFromAddress(searchText))
          .valueOrNull;
      if (token != null) {
        state = state.copyWith(
          result: token,
        );
      }
    }

    return;
  }
}

abstract class TokenSelectionFormProvider {
  static final tokenSelectionForm = _tokenSelectionFormProvider;
}
