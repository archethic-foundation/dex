/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
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
            content: SelectableText(
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
        onPressed: () async {
          final sessionNotifier = ref.watch(SessionProviders.session.notifier);
          await sessionNotifier.connectToWallet();
          if (ref.read(SessionProviders.session).error.isNotEmpty) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor:
                    Theme.of(context).snackBarTheme.backgroundColor,
                content: SelectableText(
                  ref.read(SessionProviders.session).error,
                  style: Theme.of(context).snackBarTheme.contentTextStyle,
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        icon: aedappfm.GradientText(
          AppLocalizations.of(context)!.btn_connect_wallet,
          gradient: aedappfm.AppThemeBase.gradientWelcomeTxt,
          style: const TextStyle(
            fontSize: 8,
          ),
          selectable: false,
        ),
      );
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            aedappfm.Iconsax.user,
            size: 18,
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  session.nameAccount,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Flexible(
                child: FormatAddressLinkCopy(
                  address: session.genesisAddress.toUpperCase(),
                  typeAddress: TypeAddressLinkCopy.chain,
                  reduceAddress: true,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 4,
          ),
        ],
      ),
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
                child: SelectableText(
                  session.nameAccount,
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: FormatAddressLinkCopy(
                  address: session.genesisAddress,
                  typeAddress: TypeAddressLinkCopy.chain,
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
