import 'dart:ui';

import 'package:aedex/application/preferences.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyPopup extends ConsumerWidget {
  const PrivacyPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent.withAlpha(120),
      body: AlertDialog(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SelectableText(
                      'Information - Testnet',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodyMedium!,
                            ),
                          ),
                    ),
                    const SizedBox(height: 40),
                    SelectableText(
                      'During the testnet phase, Archethic collects logs, both functional and technical, to analyze anomalies in the Apps operation.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodyMedium!,
                            ),
                          ),
                    ),
                    const SizedBox(height: 20),
                    SelectableText(
                      'These logs may contain information related to the transactions performed but do not in any way allow us to alter or interfere with the transactions. These logs do not contain sensitive information such as seed or private keys.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.bodyMedium!,
                            ),
                          ),
                    ),
                    const SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text:
                                'You can disable or activate logs when you want in the info menu ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.bodyMedium!,
                                  ),
                                ),
                          ),
                          const WidgetSpan(
                            child: Icon(
                              Icons.info_outlined,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    aedappfm.AppButton(
                      fontSize: aedappfm.Responsive.fontSizeFromValue(
                        context,
                        desktopValue: 16,
                      ),
                      labelBtn: AppLocalizations.of(context)!.btn_understand,
                      onPressed: () async {
                        await ref
                            .read(
                              PreferencesProviders.preferencesRepository,
                            )
                            .setFirstConnection(false);
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
