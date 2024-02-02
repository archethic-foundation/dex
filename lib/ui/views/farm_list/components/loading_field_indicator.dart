import 'package:flutter/material.dart';

class LoadingFieldIndicatorStyle {
  const LoadingFieldIndicatorStyle({
    required this.color,
    required this.dimension,
    required this.strokeWidth,
  });

  final Color? color;
  final double dimension;
  final double strokeWidth;
}

class LoadingFieldIndicator extends StatelessWidget {
  const LoadingFieldIndicator({
    super.key,
    this.style,
    this.padding,
  });

  final LoadingFieldIndicatorStyle? style;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(3),
      child: SizedBox(
        width:
            style?.dimension ?? Theme.of(context).textTheme.bodyLarge!.fontSize,
        height:
            style?.dimension ?? Theme.of(context).textTheme.bodyLarge!.fontSize,
        child: CircularProgressIndicator(
          strokeWidth: style?.strokeWidth ?? 0.5,
          color: style?.color ?? Colors.white,
        ),
      ),
    );
  }
}
