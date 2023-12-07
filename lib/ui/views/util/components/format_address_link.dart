import 'package:aedex/application/dex_blockchain.dart';
import 'package:aedex/ui/views/util/iconsax.dart';
import 'package:aedex/util/endpoint_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

enum TypeAddress { address, transaction, chain }

class FormatAddressLink extends ConsumerWidget {
  const FormatAddressLink({
    required this.address,
    this.iconSize = 12,
    this.typeAddress = TypeAddress.address,
    this.tooltipLink,
    super.key,
  });

  final String address;
  final TypeAddress typeAddress;
  final double iconSize;
  final String? tooltipLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        final blockchain = await ref.read(
          DexBlockchainsProviders.getBlockchainFromEnv(
            EndpointUtil.getEnvironnement(),
          ).future,
        );
        if (typeAddress == TypeAddress.transaction) {
          await launchUrl(
            Uri.parse(
              '${blockchain!.urlExplorerTransaction}$address',
            ),
          );
        } else {
          if (typeAddress == TypeAddress.address) {
            await launchUrl(
              Uri.parse(
                '${blockchain!.urlExplorerAddress}$address',
              ),
            );
          } else {
            await launchUrl(
              Uri.parse(
                '${blockchain!.urlExplorerChain}$address',
              ),
            );
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: tooltipLink == null
            ? Icon(
                Iconsax.export_3,
                size: iconSize,
              )
            : Tooltip(
                message: tooltipLink,
                child: Icon(
                  Iconsax.export_3,
                  size: iconSize,
                ),
              ),
      ),
    );
  }
}
