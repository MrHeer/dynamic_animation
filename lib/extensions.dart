import 'package:flutter/animation.dart';
import 'package:flutter/physics.dart';

const SpringDescription defaultSpringDescription = SpringDescription(
  mass: 30.0,
  stiffness: 1.0,
  damping: 1.0,
);

extension DynamicAnimation on AnimationController {
  /// Dynamically-updatable animate.
  TickerFuture dynamicAnimateWith({
    required double target,
    double? value,
    double? velocity,
    SpringDescription? springDescription,
  }) {
    final simulation = SpringSimulation(
      springDescription ?? defaultSpringDescription,
      value ?? this.value,
      target,
      velocity ?? this.velocity,
    );
    return animateWith(simulation);
  }
}
