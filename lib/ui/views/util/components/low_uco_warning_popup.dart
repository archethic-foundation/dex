import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:go_router/go_router.dart';

const kLowUCOWarningValue = 5;

class LowUCOWarningPopup {
  static Future<bool?> getDialog(
    BuildContext context,
  ) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return ScaffoldMessenger(
          child: Builder(
            builder: (context) {
              return AlertDialog(
                insetPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                backgroundColor: aedappfm.AppThemeBase.backgroundPopupColor,
                contentPadding: const EdgeInsets.only(
                  top: 10,
                ),
                content: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          AppLocalizations.of(context)!.lowUCOWarningPopupTitle,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                fontSize:
                                    aedappfm.Responsive.fontSizeFromTextStyle(
                                  context,
                                  Theme.of(context).textTheme.titleMedium!,
                                ),
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          AppLocalizations.of(context)!.lowUCOWarningPopupDesc,
                          softWrap: true,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize:
                                    aedappfm.Responsive.fontSizeFromTextStyle(
                                  context,
                                  Theme.of(context).textTheme.bodyMedium!,
                                ),
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        constraints: const BoxConstraints(
                          minWidth: 100,
                        ),
                        width: 300,
                        padding: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: aedappfm.AppButton(
                                labelBtn: AppLocalizations.of(context)!.no,
                                onPressed: () async {
                                  context.pop(false);
                                },
                              ),
                            ),
                            Expanded(
                              child: aedappfm.AppButton(
                                labelBtn: AppLocalizations.of(context)!.yes,
                                onPressed: () async {
                                  context.pop(true);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
