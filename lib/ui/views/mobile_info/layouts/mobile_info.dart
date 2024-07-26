import 'dart:ui';

import 'package:aedex/ui/views/mobile_info/layouts/components/mobile_info_app_bar.dart';
import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/block_info.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileInfoScreen extends ConsumerWidget {
  const MobileInfoScreen({
    super.key,
  });

  static const routerPage = '/mobileInfo';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyleDesc = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.w300);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: aedappfm.AppThemeBase.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: const MobileInfoAppBar(),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          const aedappfm.AppBackground(
            withAnimation: true,
            backgroundImage: 'assets/images/background-welcome.png',
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlockInfo(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 500,
                  info: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'aeSwap',
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: aedappfm.AppThemeBase.secondaryColor,
                                ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.mobileInfoTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Opacity(
                        opacity: AppTextStyles.kOpacityText,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.mobileInfoTxt1,
                              style: textStyleDesc,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                AppLocalizations.of(context)!.mobileInfoTxt2,
                                style: textStyleDesc,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                AppLocalizations.of(context)!.mobileInfoTxt3,
                                style: textStyleDesc,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.mobileInfoTxt4,
                              style: textStyleDesc,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.mobileInfoTxt5,
                              style: textStyleDesc,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
