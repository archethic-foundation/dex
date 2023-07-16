import 'dart:convert';

import 'package:aedex/model/dex_token.dart';
import 'package:aedex/ui/themes/theme_base.dart';
import 'package:aedex/ui/views/token_selection/components/token_list.dart';
import 'package:aedex/ui/views/token_selection/components/token_selection_close_btn.dart';
import 'package:aedex/ui/views/token_selection/components/token_selection_common_bases.dart';
import 'package:aedex/ui/views/token_selection/components/token_selection_search_bar.dart';
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
        return ScaffoldMessenger(
          child: Builder(
            builder: (context) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: AlertDialog(
                  backgroundColor: ThemeBase.backgroundPopupColor,
                  content: Container(
                    width: 600,
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 30,
                      right: 30,
                    ),
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
                                gradient: ThemeBase.gradient,
                              ),
                            ),
                          ),
                        ),
                        const TokenList(),
                        const TokenSelectionCloseBtn(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
