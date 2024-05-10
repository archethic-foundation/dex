import 'dart:async';

import 'package:aedex/ui/views/pool_list/components/pool_list_item.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolRefreshIcon extends ConsumerStatefulWidget {
  const PoolRefreshIcon({
    required this.poolAddress,
    super.key,
  });

  final String poolAddress;

  @override
  ConsumerState<PoolRefreshIcon> createState() => _PoolRefreshIconState();
}

class _PoolRefreshIconState extends ConsumerState<PoolRefreshIcon> {
  bool? isRefreshSuccess;

  @override
  void initState() {
    super.initState();
    isRefreshSuccess = false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (isRefreshSuccess != null && isRefreshSuccess == true) return;
        setState(
          () {
            isRefreshSuccess = true;
          },
        );

        unawaited(
          context.findAncestorStateOfType<PoolListItemState>()?.reload(),
        );

        await Future.delayed(const Duration(seconds: 3));
        setState(
          () {
            isRefreshSuccess = false;
          },
        );
      },
      child: Tooltip(
        message: AppLocalizations.of(context)!.poolRefreshIconTooltip,
        child: SizedBox(
          height: 40,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: aedappfm.ArchethicThemeBase.brightPurpleHoverBorder
                    .withOpacity(1),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            color: isRefreshSuccess != null && isRefreshSuccess == true
                ? aedappfm.ArchethicThemeBase.systemPositive600
                : aedappfm.ArchethicThemeBase.brightPurpleHoverBackground
                    .withOpacity(1),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              child: Icon(
                isRefreshSuccess != null && isRefreshSuccess == true
                    ? Icons.check
                    : aedappfm.Iconsax.refresh,
                size: 16,
                color: isRefreshSuccess != null && isRefreshSuccess == true
                    ? Colors.white
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
