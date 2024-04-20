import 'package:aedex/application/farm/dex_farm.dart';
import 'package:aedex/ui/views/farm_list/components/farm_list_item.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_list.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmListSheet extends ConsumerStatefulWidget {
  const FarmListSheet({
    super.key,
  });

  static const routerPage = '/farmList';
  @override
  ConsumerState<FarmListSheet> createState() => _FarmListSheetState();
}

class _FarmListSheetState extends ConsumerState<FarmListSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.farm;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenList(
      body: _body(context, ref),
    );
  }
}

Widget _body(BuildContext context, WidgetRef ref) {
  final asyncFarms = ref.watch(
    DexFarmProviders.getFarmList,
  );

  return Center(
    child: Padding(
      padding: EdgeInsets.only(
        top: aedappfm.Responsive.isDesktop(context) ||
                aedappfm.Responsive.isTablet(context)
            ? 100
            : 0,
        bottom: aedappfm.Responsive.isDesktop(context) ||
                aedappfm.Responsive.isTablet(context)
            ? 40
            : 0,
      ),
      child: asyncFarms.when(
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        error: (error, stacktrace) => const aedappfm.Loading(),
        loading: aedappfm.Loading.new,
        data: (farms) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width >= 1500
                ? 3
                : aedappfm.Responsive.isDesktop(context) ||
                        aedappfm.Responsive.isTablet(context)
                    ? 2
                    : 1,
            mainAxisExtent: 640,
            crossAxisSpacing: 30,
            mainAxisSpacing: 10,
          ),
          padding: EdgeInsets.only(
            left: aedappfm.Responsive.isDesktop(context) ||
                    aedappfm.Responsive.isTablet(context)
                ? 50
                : 5,
            right: aedappfm.Responsive.isDesktop(context) ||
                    aedappfm.Responsive.isTablet(context)
                ? 50
                : 5,
          ),
          itemCount: farms.length,
          itemBuilder: (context, index) {
            final farm = farms[index];
            return FarmListItem(
              key: Key(farm.farmAddress),
              farm: farm,
            );
          },
        ),
      ),
    ),
  );
}
