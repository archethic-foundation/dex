import 'dart:ui';

import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/util/components/popup_close_button.dart';
import 'package:flutter/material.dart';

class PopupTemplate extends StatelessWidget {
  const PopupTemplate({
    super.key,
    required this.popupContent,
    required this.popupTitle,
    required this.popupHeight,
    this.warningCloseLabel = '',
    this.warningCloseFunction,
  });

  final Widget popupContent;
  final String popupTitle;
  final double popupHeight;
  final String warningCloseLabel;
  final Function? warningCloseFunction;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent.withAlpha(120),
            body: AlertDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 30, right: 15, left: 8),
                        padding: const EdgeInsets.all(20),
                        height: popupHeight,
                        width: DexThemeBase.sizeBoxComponentWidth,
                        decoration: BoxDecoration(
                          color: DexThemeBase.sheetBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: DexThemeBase.sheetBorder,
                          ),
                        ),
                        child: popupContent,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: SelectionArea(
                              child: Text(
                                popupTitle,
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              decoration: BoxDecoration(
                                gradient: DexThemeBase.gradient,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: PopupCloseButton(
                      warningCloseLabel: warningCloseLabel,
                      warningCloseFunction: warningCloseFunction,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
