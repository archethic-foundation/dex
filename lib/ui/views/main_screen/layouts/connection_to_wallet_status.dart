/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/notification.dart';
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/application/session/state.dart';
import 'package:aedex/ui/views/notifications/layouts/tasks_notification_widget.dart';
import 'package:aedex/ui/views/swap/layouts/swap_sheet.dart';
import 'package:aedex/ui/views/util/components/format_address_link_copy.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    final session = ref.watch(sessionNotifierProvider).value ?? const Session();

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
        ref.read(sessionNotifierProvider.notifier).setOldNameAccount(session);
        context.go(SwapSheet.routerPage);
      });
    }

    if (session.isConnected == false) {
      return InkWell(
        onTap: () async {
          ref
            ..invalidate(sessionNotifierProvider)
            ..read(sessionNotifierProvider);
          if ((ref.read(sessionNotifierProvider).value ?? const Session())
              .error
              .isNotEmpty) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor:
                    Theme.of(context).snackBarTheme.backgroundColor,
                content: SelectableText(
                  (ref.read(sessionNotifierProvider).value ?? const Session())
                      .error,
                  style: Theme.of(context).snackBarTheme.contentTextStyle,
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) =>
              aedappfm.AppThemeBase.gradientWelcomeTxt.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            AppLocalizations.of(context)!.btn_connect_wallet,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    final runningTasksCount = ref.watch(
      NotificationProviders.runningTasks
          .select((value) => value.valueOrNull?.length ?? 0),
    );

    if (runningTasksCount > 0) {
      return Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RunningTasksNotificationWidget(),
          ],
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
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          IconButton(
            icon: const Icon(aedappfm.Iconsax.logout),
            iconSize: 18,
            onPressed: () async {
              await ref
                  .read(sessionNotifierProvider.notifier)
                  .cancelConnection();
            },
          ),
          const SizedBox(
            width: 4,
          ),
        ],
      ),
    );
  }
}
