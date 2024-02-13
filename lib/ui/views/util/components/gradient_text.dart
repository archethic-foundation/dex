import 'package:aedex/ui/views/util/components/scale_size.dart';
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
    this.selectable = true,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: selectable
          ? SelectableText(
              text,
              style: style,
              textScaleFactor: ScaleSize.textScaleFactor(context),
            )
          : Text(
              text,
              style: style,
              textScaleFactor: ScaleSize.textScaleFactor(context),
            ),
    );
  }
}
