import 'package:aedex/ui/views/util/components/block_info.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmBlockBridgeBanner extends ConsumerWidget {
  const FarmBlockBridgeBanner({
    required this.width,
    required this.height,
    super.key,
  });

  final double width;
  final double height;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final styleBannerText = Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
            context,
            Theme.of(context).textTheme.headlineSmall!,
          ),
        );

    return BlockInfo(
      blockInfoColor: BlockInfoColor.purple,
      info: Row(
        children: [
          Wrap(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Now you can ', style: styleBannerText),
                    TextSpan(
                      text: 'bridge',
                      style: styleBannerText.copyWith(
                        color: aedappfm.AppThemeBase.secondaryColor,
                      ),
                    ),
                    TextSpan(
                      text: ' your UCO or wETH\nfrom Polygon (PoS) to ',
                      style: styleBannerText,
                    ),
                    TextSpan(
                      text: 'Archethic Blockchain',
                      style: styleBannerText.copyWith(
                        color: aedappfm.AppThemeBase.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 150,
            height: 35,
            child: aedappfm.AppButton(
              labelBtn: 'Try now',
              fontSize: 14,
              onPressed: () async {
                await launchUrl(
                  Uri.parse(
                    (Uri.base
                            .toString()
                            .toLowerCase()
                            .contains('dex.archethic'))
                        ? 'https://bridge.archethic.net'
                        : 'https://bridge.testnet.archethic.net',
                  ),
                );
              },
            ),
          ),
        ],
      ),
      width: width,
      height: height,
      backgroundWidget: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/coin-img.png',
            ),
            alignment: Alignment.centerRight,
            opacity: 0.2,
          ),
        ),
      ),
    );
  }
}
