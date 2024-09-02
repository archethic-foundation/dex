/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/util/consent_uri.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations-aeswap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarMenuInfo extends ConsumerStatefulWidget {
  const AppBarMenuInfo({
    super.key,
  });

  @override
  ConsumerState<AppBarMenuInfo> createState() => _AppBarMenuInfoState();
}

class _AppBarMenuInfoState extends ConsumerState<AppBarMenuInfo> {
  final thumbIcon = WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  @override
  Widget build(BuildContext context) {
    final session = ref.watch(SessionProviders.session);
    final sessionNotifier = ref.watch(SessionProviders.session.notifier);

    return MenuAnchor(
      style: MenuStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.only(top: 20, right: 20),
        ),
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.all(
          Colors.transparent,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      alignmentOffset: const Offset(0, 2),
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.info_outlined),
        );
      },
      menuChildren: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: MenuItemButton(
            child: Container(
              width: 280,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Icon(
                    aedappfm.Iconsax.document_text,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.aeswap_menu_documentation,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    aedappfm.Iconsax.export_3,
                    size: 12,
                  ),
                ],
              ),
            ),
            onPressed: () async {
              await launchUrl(
                Uri.parse(
                  'https://wiki.archethic.net/participate/dex/',
                ),
              );
            },
          ),
        ),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  aedappfm.Iconsax.code_circle,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.aeswap_menu_sourceCode,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  aedappfm.Iconsax.export_3,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () async {
            await launchUrl(
              Uri.parse(
                'https://github.com/archethic-foundation/dex',
              ),
            );
          },
        ),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  aedappfm.Iconsax.message_question,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(AppLocalizations.of(context)!.aeswap_menu_faq),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  aedappfm.Iconsax.export_3,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () async {
            await launchUrl(
              Uri.parse(
                'https://wiki.archethic.net/FAQ/dex',
              ),
            );
          },
        ),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  aedappfm.Iconsax.video_play,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(AppLocalizations.of(context)!.aeswap_menu_tuto),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  aedappfm.Iconsax.export_3,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () async {
            await launchUrl(
              Uri.parse(
                'https://wiki.archethic.net/participate/dex/Guide_Usage/',
              ),
            );
          },
        ),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  aedappfm.Iconsax.shield_tick,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.aeswap_menu_privacy_policy,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  aedappfm.Iconsax.export_3,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () async {
            await launchUrl(
              Uri.parse(
                kURIPrivacyPolicy,
              ),
            );
          },
        ),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  aedappfm.Iconsax.archive_book,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.aeswap_menu_terms_of_use,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  aedappfm.Iconsax.export_3,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () async {
            await launchUrl(
              Uri.parse(
                kURITermsOfUse,
              ),
            );
          },
        ),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  aedappfm.Iconsax.reserve,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(AppLocalizations.of(context)!.aeswap_menu_report_bug),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  aedappfm.Iconsax.export_3,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () async {
            await launchUrl(
              Uri.parse(
                'https://github.com/archethic-foundation/dex/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml',
              ),
            );
          },
        ),
        if (session.isConnected)
          MenuItemButton(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Icon(
                    aedappfm.Iconsax.logout,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(AppLocalizations.of(context)!.aeswap_logout),
                ],
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ScaffoldMessenger(
                    child: Builder(
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          backgroundColor:
                              aedappfm.AppThemeBase.backgroundPopupColor,
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                          ),
                          content: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .aeswap_confirmationPopupTitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontSize: aedappfm.Responsive
                                              .fontSizeFromTextStyle(
                                            context,
                                            Theme.of(context)
                                                .textTheme
                                                .titleMedium!,
                                          ),
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .aeswap_connectionWalletDisconnectWarning,
                                    softWrap: true,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: aedappfm.Responsive
                                              .fontSizeFromTextStyle(
                                            context,
                                            Theme.of(context)
                                                .textTheme
                                                .bodyMedium!,
                                          ),
                                        ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 100,
                                  ),
                                  width: MediaQuery.of(context).size.width / 2,
                                  padding: const EdgeInsets.only(
                                    bottom: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: aedappfm.AppButton(
                                          labelBtn:
                                              AppLocalizations.of(context)!
                                                  .aeswap_no,
                                          onPressed: () async {
                                            context.pop();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: aedappfm.AppButton(
                                          labelBtn:
                                              AppLocalizations.of(context)!
                                                  .aeswap_yes,
                                          onPressed: () async {
                                            await sessionNotifier
                                                .cancelConnection();
                                            if (!context.mounted) return;
                                            context.pop();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 12,
          ),
          child: Consumer(
            builder: (context, ref, child) {
              final asyncVersionString = ref.watch(
                aedappfm.versionStringProvider(
                  aedappfm.AppLocalizations.of(context)!,
                ),
              );
              return Text(
                asyncVersionString.asData?.value ?? '',
                style: Theme.of(context).textTheme.labelSmall,
              );
            },
          ),
        ),
      ],
    );
  }
}
