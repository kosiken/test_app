import 'package:flutter/material.dart';
import 'package:test_app/debug.dart';

typedef OnClick = void Function();

class OpacityFeedback extends StatefulWidget {
  final Widget child;
  final bool disabled;
  final OnClick? onClick;
  const OpacityFeedback({super.key, required this.child, this.disabled = false,  this.onClick});


  @override
  State<OpacityFeedback> createState() => _OpacityFeedbackState();
}

class _OpacityFeedbackState extends State<OpacityFeedback> {
  double opacity= 1.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              onTapDown: (TapDownDetails details) {
                opacity = 0.4;
                Debug.log('tap op');
                setState(() {});

              },
              onTapCancel: () {
                opacity = 1.0;
                setState(() {});
              },
              onTapUp: (d) {
                opacity = 1.0;
                setState(() {});
              },
              
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: opacity,
                child: widget.child,
              ),
              
                 onTap: () {
        if (!widget.disabled && widget.onClick != null) widget.onClick!();
      },
            );
  }
}