/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aedex/ui/views/swap/bloc/provider.dart';
import 'package:aedex/ui/views/util/components/icon_button_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapSettingsExpertMode extends ConsumerStatefulWidget {
  const SwapSettingsExpertMode({
    super.key,
  });

  @override
  SwapSettingsExpertModeState createState() => SwapSettingsExpertModeState();
}

class SwapSettingsExpertModeState
    extends ConsumerState<SwapSettingsExpertMode> {
  bool? expertMode;

  @override
  void initState() {
    final swap = ref.read(SwapFormProvider.swapForm);
    expertMode = swap.expertMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final swapNotifier = ref.watch(SwapFormProvider.swapForm.notifier);
    final thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );

    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.swap_settings_expert_mode,
                  style: Theme.of(context)
                      .textTheme
                      .apply(
                        displayColor: Theme.of(context).colorScheme.onSurface,
                      )
                      .labelMedium,
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: IconButtonAnimated(
                    icon: Icon(
                      Icons.help,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {},
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Switch(
              thumbIcon: thumbIcon,
              value: expertMode ?? false,
              onChanged: (value) {
                swapNotifier.setExpertMode(value);
                setState(
                  () {
                    expertMode = value;
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
