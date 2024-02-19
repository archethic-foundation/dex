import 'package:aedex/application/dex_blockchain.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

enum TypeAddressLinkCopy { address, transaction, chain }

class FormatAddressLinkCopy extends ConsumerWidget {
  const FormatAddressLinkCopy({
    required this.address,
    this.reduceAddress = false,
    this.fontSize = 13,
    this.typeAddress = TypeAddressLinkCopy.address,
    this.header,
    this.tooltipCopy,
    this.tooltipLink,
    super.key,
  });

  final String address;
  final bool reduceAddress;
  final double fontSize;
  final TypeAddressLinkCopy typeAddress;
  final String? header;
  final String? tooltipCopy;
  final String? tooltipLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (header != null)
          Tooltip(
            message: address,
            child: SelectableText(
              '$header ${reduceAddress ? aedappfm.AddressUtil.reduceAddress(address) : address}',
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          )
        else
          Tooltip(
            message: address,
            child: SelectableText(
              reduceAddress
                  ? aedappfm.AddressUtil.reduceAddress(address)
                  : address,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            Clipboard.setData(
              ClipboardData(text: address),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor:
                    Theme.of(context).snackBarTheme.backgroundColor,
                content: SelectableText(
                  AppLocalizations.of(context)!.addressCopied,
                  style: Theme.of(context).snackBarTheme.contentTextStyle,
                ),
                duration: const Duration(seconds: 3),
                action: SnackBarAction(
                  label: AppLocalizations.of(context)!.ok,
                  onPressed: () {},
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: tooltipCopy == null
                ? Icon(
                    aedappfm.Iconsax.copy,
                    size: fontSize - 1,
                  )
                : Tooltip(
                    message: tooltipCopy,
                    child: Icon(
                      aedappfm.Iconsax.copy,
                      size: fontSize - 1,
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () async {
            final blockchain = await ref.read(
              DexBlockchainsProviders.getBlockchainFromEnv(
                aedappfm.EndpointUtil.getEnvironnement(),
              ).future,
            );
            if (typeAddress == TypeAddressLinkCopy.transaction) {
              await launchUrl(
                Uri.parse(
                  '${blockchain!.urlExplorerTransaction}$address',
                ),
              );
            } else {
              if (typeAddress == TypeAddressLinkCopy.address) {
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
            child: tooltipCopy == null
                ? Icon(
                    aedappfm.Iconsax.export_3,
                    size: fontSize - 1,
                  )
                : Tooltip(
                    message: tooltipLink,
                    child: Icon(
                      aedappfm.Iconsax.export_3,
                      size: fontSize - 1,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
