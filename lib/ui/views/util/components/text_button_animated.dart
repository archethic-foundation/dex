import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextButtonAnimated extends ConsumerStatefulWidget {
  const TextButtonAnimated({
    required this.text,
    super.key,
  });

  final Widget text;

  @override
  ConsumerState<TextButtonAnimated> createState() => TextButtonAnimatedState();
}

class TextButtonAnimatedState extends ConsumerState<TextButtonAnimated> {
  bool _over = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _over = true;
        });
      },
      onExit: (_) {
        setState(() {
          _over = false;
        });
      },
      child: widget.text.animate(target: _over ? 1 : 0).scaleXY(end: 1.3),
    );
  }
}
