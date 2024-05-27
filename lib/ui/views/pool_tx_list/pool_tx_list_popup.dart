import 'package:aedex/domain/models/dex_pool.dart';
import 'package:aedex/ui/views/pool_tx_list/components/pool_tx_list.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';

class PoolTxListPopup {
  static Future<void> getDialog(
    BuildContext context,
    DexPool pool,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return aedappfm.PopupTemplate(
          popupContent: LayoutBuilder(
            builder: (context, constraint) {
              return aedappfm.ArchethicScrollbar(
                thumbVisibility: false,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                child: Container(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        PoolTxList(pool: pool),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          popupTitle: '',
          popupHeight: 500,
        );
      },
    );
  }
}
