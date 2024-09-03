import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:aedex/ui/views/util/components/block_info.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:aedex/l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MobileInfoScreen extends ConsumerWidget {
  const MobileInfoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyleDesc = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.w300);
    return BlockInfo(
      width: MediaQuery.of(context).size.width - 30,
      height: MediaQuery.of(context).size.height - 30,
      info: ColoredBox(
        color: Colors.transparent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'aeSwap',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: aedappfm.AppThemeBase.secondaryColor,
                        ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.aeswap_mobileInfoTitle,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.aeswap_mobileInfoTxt1,
                          style: textStyleDesc,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            AppLocalizations.of(context)!.aeswap_mobileInfoTxt2,
                            style: textStyleDesc,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            AppLocalizations.of(context)!.aeswap_mobileInfoTxt3,
                            style: textStyleDesc,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.aeswap_mobileInfoTxt4,
                          style: textStyleDesc,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.aeswap_mobileInfoTxt5,
                          style: textStyleDesc,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              aedappfm.AppButton(
                backgroundGradient: LinearGradient(
                  colors: [
                    aedappfm.ArchethicThemeBase.blue400,
                    aedappfm.ArchethicThemeBase.blue600,
                  ],
                ),
                labelBtn: AppLocalizations.of(context)!.aeswap_btn_close,
                onPressed: () async {
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
