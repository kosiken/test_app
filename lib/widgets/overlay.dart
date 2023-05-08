

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:test_app/debug.dart';

class StaggerAnimation extends StatelessWidget {
  final Size size;
  final Widget? child;

  StaggerAnimation({super.key, required this.controller,  required this.size, this.child})
      :

        // Each animation defined here transforms its value during the subset
        // of the controller's duration defined by the animation's interval.
        // For example the opacity animation transforms its value during
        // the first 10% of the controller's duration.

        opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          
          CurvedAnimation(
            parent: controller,
            
            curve: const Interval(
                0.150,
              0.26,
              curve: Curves.ease,
            ),
          ),
        ),

        height = Tween<double>(begin: size.height, end: 0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
                 0.0,
              0.350,
            
              curve: Curves.ease,
            ),
          ),
        );

  final Animation<double> controller;
  final Animation<double> opacity;

  final Animation<double> height;


  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Positioned(
      bottom: 0 - height.value,
      width: size.width,
      child: Opacity(
        opacity: opacity.value,
        child: Container(
        height: size.height,
        padding: EdgeInsets.symmetric(
          vertical: 0,
        ),
        color: Colors.white,
        child: child,
      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
        return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
      child: child,
    );
  }
}

class AppOverlay extends StatefulWidget {
   AppOverlay({super.key, required this.show, required this.size, this.child});
  final Widget? child;
  final bool show;
  final Size size;

  // AnimationController? controller;


  @override
  // ignore: no_logic_in_create_state
  State<AppOverlay> createState() => AppOverlayState();
}

class AppOverlayState extends State<AppOverlay>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> playAnimation() async {
    Debug.log('here');
    try {
      await _controller.forward().orCancel;
      
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

 
  Future<void> reverseAnimation() async {
    Debug.log('here');
    try {
      await _controller.reverse().orCancel;
      
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0; // 1.0 is normal animation speed.
    return StaggerAnimation(controller: _controller, size: widget.size, child: widget.child,);
  }
}

