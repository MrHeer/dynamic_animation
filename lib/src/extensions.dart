import 'package:flutter/animation.dart';
import 'package:flutter/physics.dart';

const SpringDescription defaultSpringDescription = SpringDescription(
  mass: 30.0,
  stiffness: 1.0,
  damping: 1.0,
);

extension DynamicAnimation on AnimationController {
  /// Starts an spring animation from current [from] and [velocity] to the [target].
  TickerFuture dynamicTo(
    double target, {
    double? from,
    double? velocity,
    SpringDescription springDescription = defaultSpringDescription,
    Tolerance tolerance = Tolerance.defaultTolerance,
  }) {
    final simulation = SpringSimulation(
      springDescription,
      from ?? value,
      target,
      velocity ?? this.velocity,
      tolerance: tolerance,
    );
    return animateWith(simulation);
  }
}
