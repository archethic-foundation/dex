import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolListSearchBar extends ConsumerStatefulWidget {
  const PoolListSearchBar({
    super.key,
  });

  @override
  PoolListSearchBarState createState() => PoolListSearchBarState();
}

class PoolListSearchBarState extends ConsumerState<PoolListSearchBar> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      poolListFormNotifierProvider,
      (previous, next) async {
        if (previous != null &&
            previous.selectedTab != PoolsListTab.searchPool &&
            previous.searchText.isNotEmpty &&
            previous.searchText != next.searchText) {
          searchController.value = TextEditingValue(text: next.searchText);
        }
      },
    );

    return Container(
      padding: const EdgeInsets.only(top: 2),
      width: aedappfm.Responsive.isDesktop(context) ||
              aedappfm.Responsive.isTablet(context)
          ? 300
          : MediaQuery.of(context).size.width - 100,
      height: 31,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
          width: 0.5,
        ),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface.withOpacity(1),
            Theme.of(context).colorScheme.surface.withOpacity(0.3),
          ],
          stops: const [0, 1],
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              aedappfm.Iconsax.search_normal,
              size: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 10,
              bottom: 3,
            ),
            child: TextField(
              controller: searchController,
              style: Theme.of(context).textTheme.bodySmall,
              autocorrect: false,
              onChanged: (text) async {
                ref
                    .read(
                      poolListFormNotifierProvider.notifier,
                    )
                    .setSearchText(text);

                if (text.isNotEmpty) {
                  ref.read(poolListFormNotifierProvider.notifier).selectTab(
                        PoolsListTab.searchPool,
                      );
                }
              },
              textAlign: TextAlign.left,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(68),
                aedappfm.UpperCaseTextFormatter(),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: AppLocalizations.of(context)!.poolListSearchBarHint,
                hintStyle: Theme.of(context).textTheme.bodySmall,
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
    super.dispose();
  }
}
