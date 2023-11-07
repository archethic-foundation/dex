import 'package:aedex/application/dex_token.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/token_selection/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/icon_button_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class TokenList extends ConsumerWidget {
  const TokenList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenSelectionForm =
        ref.watch(TokenSelectionFormProvider.tokenSelectionForm);
    if (tokenSelectionForm.isAddress == false) {
      final session = ref.read(SessionProviders.session);
      final tokens = ref.watch(
        DexTokensProviders.getTokenFromAccount(session.genesisAddress),
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!
                          .token_selection_your_tokens_title,
                      style: Theme.of(context)
                          .textTheme
                          .apply(
                            displayColor:
                                Theme.of(context).colorScheme.onSurface,
                          )
                          .labelMedium,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: IconButtonAnimated(
                        icon: Icon(
                          Icons.help,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {},
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                              .apply(
                                displayColor:
                                    Theme.of(context).colorScheme.onSurface,
                              )
                              .labelMedium,
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
    final tokens = ref.watch(
      DexTokensProviders.getTokenFromAddress(tokenSelectionForm.searchText),
    );
    return SizedBox(
      child: tokens.map(
        data: (data) {
          return _TokensList(tokens: data.value);
        },
        error: (error) => const SizedBox(
          height: 200,
        ),
        loading: (loading) => const Stack(
          children: [
            SizedBox(
              height: 200,
            ),
            SizedBox(
              height: 20,
              width: 20,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TokensList extends StatelessWidget {
  const _TokensList({required this.tokens});

  final List<DexToken> tokens;
  @override
  Widget build(BuildContext context) {
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
        itemCount: tokens.length,
        itemBuilder: (BuildContext context, int index) {
          return _SingleToken(token: tokens[index])
              .animate(delay: (100 * index).ms)
              .fadeIn(duration: 900.ms, delay: 200.ms)
              .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
              .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad);
        },
      ),
    );
  }
}

class _SingleToken extends StatelessWidget {
  const _SingleToken({required this.token});

  final DexToken token;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.4),
            Colors.white.withOpacity(0.1),
          ],
          stops: const [0, 1],
        ),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.4),
              Colors.white.withOpacity(0.1),
            ],
            stops: const [0, 1],
          ),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context, token);
        },
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: Center(
                child: Text(
                  token.symbol,
                  style: const TextStyle(
                    fontSize: 6,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${token.name} ',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    if (token.balance > 0)
                      Text(
                        '(${token.balance.toStringAsFixed(2)} ${token.symbol})',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                  ],
                ),
                Text(
                  token.symbol,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
