import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/token_selection/bloc/provider.dart';
import 'package:aedex/ui/views/token_selection/components/token_single.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenList extends ConsumerWidget {
  const TokenList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenSelectionForm =
        ref.watch(TokenSelectionFormProvider.tokenSelectionForm);
    final session = ref.watch(SessionProviders.session);
    if (tokenSelectionForm.isAddress == false) {
      final tokens = ref.watch(
        DexTokensProviders.getTokenFromAccount(session.genesisAddress),
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              AppLocalizations.of(context)!.token_selection_your_tokens_title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                      context,
                      Theme.of(context).textTheme.bodyLarge!,
                    ),
                  ),
            ),
          ),
          SizedBox(
            child: tokens.map(
              data: (data) {
                return _TokensList(tokens: data.value);
              },
              error: (error) => const SizedBox(
                height: 200,
              ),
              loading: (loading) => Stack(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .token_selection_get_tokens_from_wallet,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize:
                                    aedappfm.Responsive.fontSizeFromTextStyle(
                                  context,
                                  Theme.of(context).textTheme.bodyMedium!,
                                ),
                              ),
                        ),
                        const SizedBox(width: 10),
                        const SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return _TokensList(tokens: tokenSelectionForm.result!);
  }
}

class _TokensList extends ConsumerWidget {
  const _TokensList({required this.tokens});

  final List<DexToken> tokens;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenSelectionForm =
        ref.watch(TokenSelectionFormProvider.tokenSelectionForm);
    final tokensFiltered = [...tokens];
    if (tokenSelectionForm.searchText.isNotEmpty &&
        tokenSelectionForm.isAddress == false) {
      tokensFiltered.removeWhere(
        (element) =>
            element.symbol
                .toUpperCase()
                .contains(tokenSelectionForm.searchText.toUpperCase()) ==
            false,
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        shrinkWrap: true,
        padding: const EdgeInsets.only(
          left: 15,
        ),
        itemCount: tokensFiltered.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleToken(token: tokensFiltered[index])
              .animate(delay: (100 * index).ms)
              .fadeIn(duration: 900.ms, delay: 200.ms)
              .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
              .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad);
        },
      ),
    );
  }
}
