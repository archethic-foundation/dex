import 'package:aedex/ui/views/token_selection/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenSelectionSearchBar extends ConsumerStatefulWidget {
  const TokenSelectionSearchBar({
    super.key,
  });

  @override
  TokenSelectionSearchBarState createState() => TokenSelectionSearchBarState();
}

class TokenSelectionSearchBarState
    extends ConsumerState<TokenSelectionSearchBar> {
  late final TextEditingController searchController = TextEditingController();
  late final FocusNode searchFocus;
  // ignore: unused_field
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    searchFocus = FocusNode();
    searchController.addListener(() {
      setState(() {
        _searchText = searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          width: 0.5,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(1),
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.3),
                          ],
                          stops: const [0, 1],
                        ),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(
                              aedappfm.Iconsax.search_normal,
                              size: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 10),
                            child: TextField(
                              style: TextStyle(
                                fontFamily: aedappfm.AppThemeBase.addressFont,
                              ),
                              autocorrect: false,
                              controller: searchController,
                              onChanged: (text) async {
                                await ref
                                    .read(
                                      TokenSelectionFormProvider
                                          .tokenSelectionForm.notifier,
                                    )
                                    .setSearchText(text);
                              },
                              focusNode: searchFocus,
                              textAlign: TextAlign.left,
                              textInputAction: TextInputAction.none,
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(68),
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!
                                    .token_selection_search_bar_hint,
                                hintStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                                contentPadding: const EdgeInsets.only(left: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocus.dispose();
    super.dispose();
  }
}
