/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/application/session/provider.dart';
import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/ui/views/farm_claim/bloc/provider.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_confirm_sheet.dart';
import 'package:aedex/ui/views/farm_claim/layouts/components/farm_claim_form_sheet.dart';
import 'package:aedex/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmClaimSheet extends ConsumerStatefulWidget {
  const FarmClaimSheet({
    required this.farmAddress,
    required this.rewardToken,
    required this.lpTokenAddress,
    required this.rewardAmount,
    super.key,
  });

  final String farmAddress;
  final DexToken rewardToken;
  final String lpTokenAddress;
  final double rewardAmount;

  static const routerPage = '/farmClaim';

  @override
  ConsumerState<FarmClaimSheet> createState() => _FarmClaimSheetState();
}

class _FarmClaimSheetState extends ConsumerState<FarmClaimSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        await ref
            .read(SessionProviders.session.notifier)
            .updateCtxInfo(context);

        ref.read(FarmClaimFormProvider.farmClaimForm.notifier)
          ..setFarmAddress(widget.farmAddress)
          ..setRewardToken(widget.rewardToken)
          ..setLpTokenAddress(widget.lpTokenAddress)
          ..setRewardAmount(widget.rewardAmount);
        final session = ref.read(SessionProviders.session);
        if (session.genesisAddress.isEmpty) {
          if (mounted) {
            context.pop();
          }
        }
      } catch (e) {
        if (mounted) {
          context.pop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep: ref.watch(FarmClaimFormProvider.farmClaimForm).processStep,
      formSheet: const FarmClaimFormSheet(),
      confirmSheet: const FarmClaimConfirmSheet(),
      bottomWidget: const aedappfm.ArchethicOracleUco(
        faqLink:
            'https://wiki.archethic.net/FAQ/dex/#how-is-the-price-of-uco-estimated',
      ),
    );
  }
}
