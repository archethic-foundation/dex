import 'dart:ui';

import 'package:aedex/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class BrowserPopup extends ConsumerWidget {
  const BrowserPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent.withAlpha(120),
      body: AlertDialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              margin: const EdgeInsets.only(
                top: 30,
                right: 15,
                left: 8,
              ),
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                color: aedappfm.AppThemeBase.sheetBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: aedappfm.AppThemeBase.sheetBorder,
                ),
              ),
              child: aedappfm.ArchethicScrollbar(
                thumbVisibility: aedappfm.Responsive.isDesktop(context) ||
                    aedappfm.Responsive.isTablet(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!.warning,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.titleMedium!,
                            ),
                          ),
                    ),
                    const SizedBox(height: 20),
                    Linkify(
                      text: AppLocalizations.of(context)!
                          .failureIncompatibleBrowser,
                      textAlign: TextAlign.left,
                      options: const LinkifyOptions(
                        humanize: false,
                      ),
                      style: AppTextStyles.bodyMedium(context),
                      linkStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                            decoration: TextDecoration.underline,
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodyMedium!,
                            ),
                          ),
                      onOpen: (link) async {
                        final uri = Uri.parse(link.url);
                        if (!await canLaunchUrl(uri)) return;

                        await launchUrl(uri);
                      },
                    ),
                    const SizedBox(height: 40),
                    aedappfm.AppButton(
                      labelBtn: AppLocalizations.of(context)!.btn_understand,
                      onPressed: () async {
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
