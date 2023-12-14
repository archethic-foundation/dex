/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/main_screen/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:aedex/ui/views/util/generic/responsive.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:busy/busy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectionToWalletStatus extends ConsumerStatefulWidget {
  const ConnectionToWalletStatus({
    super.key,
  });

  @override
  ConsumerState<ConnectionToWalletStatus> createState() =>
      _ConnectionToWalletStatusState();
}

class _ConnectionToWalletStatusState
    extends ConsumerState<ConnectionToWalletStatus> {
  @override
  Widget build(BuildContext context) {
    final session = ref.watch(SessionProviders.session);

    if (session.oldNameAccount.isNotEmpty &&
        session.oldNameAccount != session.nameAccount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
            content: Text(
              AppLocalizations.of(context)!.changeCurrentAccountWarning,
              style: Theme.of(context).snackBarTheme.contentTextStyle,
            ),
            duration: const Duration(seconds: 3),
          ),
        );
        ref.read(SessionProviders.session.notifier).setOldNameAccount();
      });
    }

    if (session.isConnected == false) {
      return IconButton(
        onPressed: () {
          startBusyContext(
            () async {
              final sessionNotifier =
                  ref.watch(SessionProviders.session.notifier);
              await sessionNotifier.connectToWallet();
              if (ref.read(SessionProviders.session).error.isNotEmpty) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor:
                        Theme.of(context).snackBarTheme.backgroundColor,
                    content: Text(
                      ref.read(SessionProviders.session).error,
                      style: Theme.of(context).snackBarTheme.contentTextStyle,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            isBusyValueChanged: (isBusy) {
              ref.read(isLoadingMainScreenProvider.notifier).state = isBusy;
            },
          );
        },
        icon: Text(
          AppLocalizations.of(context)!.btn_connect_wallet,
          style: TextStyle(
            fontSize: 16,
            color: ArchethicThemeBase.blue200,
          ),
        ),
      );
    }

    if (Responsive.isDesktop(context)) {
      return Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: MenuAnchor(
          style: MenuStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          alignmentOffset: const Offset(0, 10),
          builder: (context, controller, child) {
            return FilledButton.tonal(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.user,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      session.nameAccount,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                ],
              ),
            );
          },
          menuChildren: const [
            MenuConnectionToWalletStatus(),
          ],
        ),
      );
    }

    return MenuAnchor(
      style: MenuStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      alignmentOffset: const Offset(0, 10),
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(
            Iconsax.user,
            //size: 18,
          ),
        );
      },
      menuChildren: const [
        MenuConnectionToWalletStatus(),
      ],
    );
  }
}

class MenuConnectionToWalletStatus extends ConsumerWidget {
  const MenuConnectionToWalletStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(SessionProviders.session);

    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 300),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Center(
                child: Text(
                  session.nameAccount,
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: FormatAddressLinkCopy(
                  address: session.genesisAddress,
                  typeAddress: TypeAddress.chain,
                  reduceAddress: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
