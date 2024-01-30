import 'package:aedex/application/main_screen_widget_displayed.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/components/pool_list_search_bar.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class PoolListSearch extends ConsumerStatefulWidget {
  const PoolListSearch({
    super.key,
  });
  @override
  ConsumerState<PoolListSearch> createState() => _PoolListSearchState();
}

class _PoolListSearchState extends ConsumerState<PoolListSearch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: FlutterToggleTab(
              width: 40,
              unSelectedBackgroundColors: [
                ArchethicThemeBase.purple500.withOpacity(0.5),
                ArchethicThemeBase.purple500.withOpacity(0.5),
              ],
              borderRadius: 20,
              height: 30,
              selectedIndex:
                  ref.watch(PoolListFormProvider.poolListForm).tabIndexSelected,
              selectedBackgroundColors: [
                ArchethicThemeBase.purple500,
                ArchethicThemeBase.purple500,
              ],
              selectedTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              unSelectedTextStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              labels: const [
                'Verified pools',
                'My pools',
                'Favorites',
                'Results',
              ],
              selectedLabelIndex: (index) {
                setState(() {
                  ref
                      .read(PoolListFormProvider.poolListForm.notifier)
                      .setTabIndexSelected(index);
                });
              },
              isScroll: false,
            ),
          ),
          DexButtonValidate(
            background: ArchethicThemeBase.purple500,
            controlOk: true,
            labelBtn: 'Create Pool',
            onPressed: () {
              ref
                  .read(
                    MainScreenWidgetDisplayedProviders
                        .mainScreenWidgetDisplayedProvider.notifier,
                  )
                  .setWidget(const PoolAddSheet(), ref);
            },
            fontSize: 12,
            height: 30,
          ),
          const PoolListSearchBar(),
        ],
      ),
    );
  }
}
