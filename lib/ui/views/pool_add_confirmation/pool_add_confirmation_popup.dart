/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/pool_add_confirmation/components/pool_add_confirmation_infos.dart';
import 'package:aedex/ui/views/util/components/popup_template.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';

class PoolAddConfirmationPopup {
  static Future<void> getDialog(
    BuildContext context,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return PopupTemplate(
          popupContent: LayoutBuilder(
            builder: (context, constraint) {
              return ArchethicScrollbar(
                child: Container(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: const IntrinsicHeight(
                    child: Column(
                      children: [
                        PoolAddConfirmationInfos(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          popupTitle: '',
          popupHeight: 400,
        );
      },
    );
  }
}
