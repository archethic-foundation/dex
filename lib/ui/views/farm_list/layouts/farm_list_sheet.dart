import 'package:aedex/ui/views/farm_list/bloc/provider.dart';
import 'package:aedex/ui/views/farm_list/layouts/components/farm_list_item.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_list.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
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
    Future(() async {
      await ref.read(FarmListFormProvider.farmListForm.notifier).getFarmsList(
            cancelToken: UniqueKey().toString(),
          );
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

@override
Widget _body(BuildContext context, WidgetRef ref) {
  final asyncFarms =
      ref.watch(FarmListFormProvider.farmListForm).farmsToDisplay;

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
        error: (error, stackTrace) => aedappfm.ErrorMessage(
          failure: aedappfm.Failure.fromError(error),
          failureMessage: FailureMessage(
            context: context,
            failure: aedappfm.Failure.fromError(error),
          ).getMessage(),
        ),
        loading: () {
          return const Stack(
            alignment: Alignment.centerLeft,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          );
        },
        data: (farms) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width >= 1500
                ? 3
                : aedappfm.Responsive.isDesktop(context)
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
