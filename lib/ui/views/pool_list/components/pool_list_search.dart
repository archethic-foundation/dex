import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/components/pool_list_search_bar.dart';
import 'package:aedex/ui/views/util/components/dex_btn_validate.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:go_router/go_router.dart';

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
                aedappfm.ArchethicThemeBase.purple500.withOpacity(0.5),
                aedappfm.ArchethicThemeBase.purple500.withOpacity(0.5),
              ],
              borderRadius: 20,
              height: 30,
              selectedIndex: ref
                  .watch(PoolListFormProvider.poolListForm)
                  .tabIndexSelected
                  .index,
              selectedBackgroundColors: [
                aedappfm.ArchethicThemeBase.purple500,
                aedappfm.ArchethicThemeBase.purple500,
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
              icons: const [
                aedappfm.Iconsax.verify,
                aedappfm.Iconsax.receipt,
                aedappfm.Iconsax.star,
                aedappfm.Iconsax.search_zoom_in,
              ],
              iconSize: 12,
              selectedLabelIndex: (index) {
                setState(() {
                  ref
                      .read(PoolListFormProvider.poolListForm.notifier)
                      .setTabIndexSelected(PoolsListTab.values[index]);
                  ref.invalidate(PoolListFormProvider.poolsToDisplay);
                });
              },
              isScroll: false,
            ),
          ),
          DexButtonValidate(
            background: aedappfm.ArchethicThemeBase.purple500,
            controlOk: true,
            labelBtn: 'Create Pool',
            onPressed: () {
              ref
                  .read(
                    navigationIndexMainScreenProvider.notifier,
                  )
                  .state = 1;
              context.go(
                PoolAddSheet.routerPage,
                extra: <String, dynamic>{},
              );
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
