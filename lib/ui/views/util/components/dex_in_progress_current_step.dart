import 'package:flutter/material.dart';

class DexInProgressCurrentStep extends StatelessWidget {
  const DexInProgressCurrentStep({
    required this.steplabel,
    super.key,
  });

  final String steplabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        steplabel,
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}
