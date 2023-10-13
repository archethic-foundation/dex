import 'dart:convert';

import 'package:aedex/model/dex_token.dart';
import 'package:aedex/ui/themes/dex_theme_base.dart';
import 'package:aedex/ui/views/token_selection/components/token_list.dart';
import 'package:aedex/ui/views/token_selection/components/token_selection_common_bases.dart';
import 'package:aedex/ui/views/token_selection/components/token_selection_search_bar.dart';
import 'package:aedex/ui/views/util/components/popup_template.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:aedex/util/endpoint_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TokenSelectionPopup {
  static Future<DexToken?> getDialog(
    BuildContext context,
  ) async {
    final jsonContent = await rootBundle
        .loadString('lib/domain/repositories/common_bases.json');

    final jsonData = jsonDecode(jsonContent);

    final currentEnvironment = EndpointUtil.getEnvironnement();
    final tokens = jsonData['tokens'][currentEnvironment] as List<dynamic>;

    return showDialog<DexToken>(
      context: context,
      builder: (context) {
        return PopupTemplate(
          popupContent: LayoutBuilder(
            builder: (context, constraint) {
              return ArchethicScrollbar(
                child: Container(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const TokenSelectionSearchBar(),
                        TokenSelectionCommonBases(tokens: tokens),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: SizedBox(
                            width: 600,
                            height: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: DexThemeBase.gradient,
                              ),
                            ),
                          ),
                        ),
                        const TokenList(),
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
