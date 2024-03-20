import 'package:aedex/ui/views/pool_list/bloc/provider.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      PoolListFormProvider.poolListForm,
      (previous, next) async {
        if (previous != null &&
            previous.tabIndexSelected != PoolsListTab.searchPool &&
            previous.searchText.isNotEmpty &&
            previous.searchText != next.searchText) {
          searchController.value = TextEditingValue(text: next.searchText);
        }
      },
    );

    return Container(
      padding: const EdgeInsets.only(top: 2),
      width: aedappfm.Responsive.isDesktop(context)
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
            Theme.of(context).colorScheme.background.withOpacity(1),
            Theme.of(context).colorScheme.background.withOpacity(0.3),
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
              bottom: 6,
            ),
            child: TextField(
              controller: searchController,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontFamily: aedappfm.AppThemeBase.addressFont),
              autocorrect: false,
              onChanged: (text) async {
                ref
                    .read(
                      PoolListFormProvider.poolListForm.notifier,
                    )
                    .setSearchText(text);

                if (text.isNotEmpty) {
                  await ref
                      .read(PoolListFormProvider.poolListForm.notifier)
                      .setTabIndexSelected(PoolsListTab.searchPool);
                }
              },
              textAlign: TextAlign.left,
              textInputAction: TextInputAction.none,
              keyboardType: TextInputType.text,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(68),
                aedappfm.UpperCaseTextFormatter(),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search by pool or token address or "UCO"',
                contentPadding: const EdgeInsets.only(bottom: 17),
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
