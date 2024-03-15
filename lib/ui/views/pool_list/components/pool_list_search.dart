import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/pool_add/layouts/pool_add_sheet.dart';
import 'package:aedex/ui/views/pool_list/bloc/provider.dart';
import 'package:aedex/ui/views/pool_list/components/pool_list_search_bar.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
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
    return aedappfm.Responsive.isDesktop(context)
        ? Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTabs(),
                _addPool(context),
                const PoolListSearchBar(),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Column(
              children: [
                _getTabs(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const PoolListSearchBar(),
                    _addPool(context),
                  ],
                ),
              ],
            ),
          );
  }

  Widget _addPool(BuildContext context) {
    return aedappfm.ButtonValidate(
      background: aedappfm.ArchethicThemeBase.purple500,
      controlOk: true,
      labelBtn: aedappfm.Responsive.isDesktop(context) ? 'Create Pool' : '+',
      onPressed: () {
        context.go(PoolAddSheet.routerPage);
      },
      fontSize: aedappfm.Responsive.fontSizeFromValue(
        context,
        desktopValue: 12,
      ),
      height: 30,
      isConnected: ref.watch(SessionProviders.session).isConnected,
      displayWalletConnectOnPressed: () async {
        final sessionNotifier = ref.read(SessionProviders.session.notifier);
        await sessionNotifier.connectToWallet();

        final session = ref.read(SessionProviders.session);
        if (session.error.isNotEmpty) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
              content: SelectableText(
                session.error,
                style: Theme.of(context).snackBarTheme.contentTextStyle,
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          if (!context.mounted) return;
          context.go(
            '/',
          );
        }
      },
    );
  }

  Widget _getTabs() {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: FlutterToggleTab(
        begin: Alignment.center,
        end: Alignment.center,
        width: aedappfm.Responsive.isDesktop(context) ? 40 : 95,
        unSelectedBackgroundColors: [
          aedappfm.ArchethicThemeBase.purple500.withOpacity(0.5),
          aedappfm.ArchethicThemeBase.purple500.withOpacity(0.5),
        ],
        borderRadius: 20,
        height: 30,
        selectedIndex:
            ref.watch(PoolListFormProvider.poolListForm).tabIndexSelected.index,
        selectedBackgroundColors: [
          aedappfm.ArchethicThemeBase.purple500,
          aedappfm.ArchethicThemeBase.purple500,
        ],
        selectedTextStyle: TextStyle(
          color: Colors.white,
          fontSize:
              aedappfm.Responsive.fontSizeFromValue(context, desktopValue: 12),
          fontWeight: FontWeight.w400,
        ),
        unSelectedTextStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize:
              aedappfm.Responsive.fontSizeFromValue(context, desktopValue: 12),
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
    );
  }
}
