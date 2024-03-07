import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';

class DexArchethicOracleUco extends StatelessWidget {
  const DexArchethicOracleUco({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const aedappfm.ArchethicOracleUco(
      faqLink:
          ' https://wiki.archethic.net/FAQ/dex/#how-is-the-price-of-uco-estimated',
    );
  }
}
