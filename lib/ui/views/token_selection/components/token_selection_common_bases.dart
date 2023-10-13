import 'package:aedex/model/dex_token.dart';
import 'package:aedex/ui/views/util/components/icon_button_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:gradient_borders/gradient_borders.dart';

class TokenSelectionCommonBases extends StatelessWidget {
  const TokenSelectionCommonBases({
    required this.tokens,
    super.key,
  });

  final List tokens;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!
                        .token_selection_common_bases_title,
                    style: Theme.of(context)
                        .textTheme
                        .apply(
                          displayColor: Theme.of(context).colorScheme.onSurface,
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
        Wrap(
          spacing: 10,
          children: tokens.map((dynamic entry) {
            final token = DexToken(
              name: entry['name'] ?? '',
              symbol: entry['symbol'] ?? '',
              genesisAddress: entry['genesisAddress'] ?? '',
            );
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              width: 150,
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
                        Text(
                          token.name,
                          style: Theme.of(context).textTheme.labelSmall,
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
          }).toList(),
        ),
      ],
    );
  }
}
