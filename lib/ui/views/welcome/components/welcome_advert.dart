import 'package:aedex/ui/themes/theme_base.dart';
import 'package:aedex/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class WelcomeAdvert extends StatelessWidget {
  const WelcomeAdvert({
    required this.welcomeArgTitle,
    required this.welcomeArgDesc,
    super.key,
  });

  final String welcomeArgTitle;
  final String welcomeArgDesc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.background.withOpacity(1),
            Theme.of(context).colorScheme.background.withOpacity(0.3),
          ],
          stops: const [0, 1],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        border: GradientBoxBorder(
          gradient: ThemeBase.gradientMainScreen,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ArchethicScrollbar(
        child: SizedBox(
          child: Column(
            children: [
              Text(
                welcomeArgTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                welcomeArgDesc,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
