/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/preferences.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/version.dart';
import 'package:aedex/ui/views/main_screen/layouts/connection_to_wallet_status.dart';
import 'package:aedex/ui/views/main_screen/layouts/header.dart';
import 'package:aedex/ui/views/main_screen/layouts/privacy_popup.dart';
import 'package:aedex/util/custom_logs.dart';
import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarMainScreen extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const AppBarMainScreen({
    super.key,
    required this.onAEMenuTapped,
  });

  final Function() onAEMenuTapped;
  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  ConsumerState<AppBarMainScreen> createState() => _AppBarMainScreenState();
}

class _AppBarMainScreenState extends ConsumerState<AppBarMainScreen> {
  final thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  @override
  Widget build(BuildContext context) {
    final session = ref.watch(SessionProviders.session);
    final sessionNotifier = ref.watch(SessionProviders.session.notifier);

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Header(),
        leadingWidth: MediaQuery.of(context).size.width,
        actions: [
          const ConnectionToWalletStatus(),
          const SizedBox(
            width: 10,
          ),
          MenuAnchor(
            style: MenuStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.black),
              shape: MaterialStateProperty.all(
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
              MenuItemButton(
                child: Padding(
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
                        AppLocalizations.of(context)!.menu_documentation,
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
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                      'https://wiki.archethic.net',
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
                        aedappfm.Iconsax.code_circle,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppLocalizations.of(context)!.menu_sourceCode,
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
                onPressed: () {
                  launchUrl(
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
                      Text(AppLocalizations.of(context)!.menu_faq),
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
                onPressed: () {
                  launchUrl(
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
                      Text(AppLocalizations.of(context)!.menu_tuto),
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
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                      'https://wiki.archethic.net/participate/dex/usage/aeSwap',
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
                        aedappfm.Iconsax.menu_board,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.menu_logs_activated,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          FutureBuilder<bool>(
                            future: ref
                                .watch(
                                  PreferencesProviders.preferencesRepository,
                                )
                                .isLogsActived(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SizedBox(
                                  height: 20,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Switch(
                                      thumbIcon: thumbIcon,
                                      value: snapshot.data!,
                                      onChanged: (value) {
                                        ref
                                            .read(
                                              PreferencesProviders
                                                  .preferencesRepository,
                                            )
                                            .setLogsActived(value);
                                        sl.get<LogManager>().logsActived =
                                            value;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            child: const Icon(
                              Icons.help_outline_outlined,
                              size: 14,
                            ),
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const PrivacyPopup();
                                  },
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                      'https://www.archethic.net/privacy-policy-dex',
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
                        AppLocalizations.of(context)!.menu_privacy_policy,
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
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                      'https://www.archethic.net/privacy-policy-dex',
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
                        Text(AppLocalizations.of(context)!.logout),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .confirmationPopupTitle,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .connectionWalletDisconnectWarning,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(
                                          bottom: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () async {
                                                context.pop();
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .no,
                                              ),
                                            ),
                                            aedappfm.AppButton(
                                              labelBtn:
                                                  AppLocalizations.of(context)!
                                                      .yes,
                                              onPressed: () async {
                                                await sessionNotifier
                                                    .cancelConnection();
                                                if (!context.mounted) return;
                                                context.pop();
                                              },
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
                      versionStringProvider(
                        AppLocalizations.of(context)!,
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
          ),
          const SizedBox(
            width: 8,
          ),
          IconButton(
            icon: const Icon(aedappfm.Iconsax.element_3),
            onPressed: widget.onAEMenuTapped,
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
