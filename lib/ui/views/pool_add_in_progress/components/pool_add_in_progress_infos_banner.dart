/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/pool_add/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/failure_message.dart';
import 'package:aedex/ui/views/util/components/info_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolAddInProgressInfosBanner extends ConsumerWidget {
  const PoolAddInProgressInfosBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poolAdd = ref.watch(PoolAddFormProvider.poolAddForm);

    if (poolAdd.failure != null) {
      return InfoBanner(
        FailureMessage(
          context: context,
          failure: poolAdd.failure,
        ).getMessage(),
        InfoBannerType.error,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (poolAdd.walletConfirmation == true) {
      return InfoBanner(
        AppLocalizations.of(context)!.poolAddInProgressConfirmAEWallet,
        InfoBannerType.request,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (poolAdd.failure == null && poolAdd.isProcessInProgress == false) {
      return InfoBanner(
        AppLocalizations.of(context)!.poolAddSuccessInfo,
        InfoBannerType.success,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    return InfoBanner(
      AppLocalizations.of(context)!.poolAddProcessInProgress,
      InfoBannerType.request,
      width: MediaQuery.of(context).size.width * 0.9,
      waitAnimation: true,
    );
  }
}
