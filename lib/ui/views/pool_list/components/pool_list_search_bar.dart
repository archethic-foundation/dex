import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/util/generic/formatters.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
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
  late final FocusNode searchFocus;

  @override
  void initState() {
    super.initState();
    searchFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      width: 300,
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
              style: TextStyle(
                fontFamily: aedappfm.AppThemeBase.addressFont,
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              autocorrect: false,
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
                      .setTabIndexSelected(PoolsListTab.searchPool);
                }
              },
              focusNode: searchFocus,
              textAlign: TextAlign.left,
              textInputAction: TextInputAction.none,
              keyboardType: TextInputType.text,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(68),
                UpperCaseTextFormatter(),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search by pool or token address or "UCO"',
                contentPadding: const EdgeInsets.only(bottom: 15),
                hintStyle: TextStyle(
                  fontFamily: aedappfm.AppThemeBase.mainFont,
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
    searchFocus.dispose();
    super.dispose();
  }
}
