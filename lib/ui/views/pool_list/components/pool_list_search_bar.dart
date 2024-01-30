import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
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
    return Container(
      padding: const EdgeInsets.only(top: 2),
      width: 250,
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
              Iconsax.search_normal,
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
              style: TextStyle(
                fontFamily: DexThemeBase.addressFont,
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              autocorrect: false,
              controller: searchController,
              onChanged: (text) {
                ref
                    .read(
                      PoolListFormProvider.poolListForm.notifier,
                    )
                    .setSearchText(text);
                if (text.isNotEmpty) {
                  ref
                      .read(
                        PoolListFormProvider.poolListForm.notifier,
                      )
                      .setTabIndexSelected(4);
                }
              },
              focusNode: searchFocus,
              textAlign: TextAlign.left,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(68),
                UpperCaseTextFormatter(),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search by pool address',
                contentPadding: const EdgeInsets.only(bottom: 15),
                hintStyle: TextStyle(
                  fontFamily: DexThemeBase.mainFont,
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
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
