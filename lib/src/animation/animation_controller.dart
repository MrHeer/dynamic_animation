import 'package:flutter/animation.dart' as animation;
import 'package:flutter/physics.dart' as physics;
import 'package:flutter/scheduler.dart';

import 'package:dynamic_animation/physics.dart';

const physics.SpringDescription defaultSpringDescription =
    physics.SpringDescription(
  mass: 30.0,
  stiffness: 1.0,
  damping: 1.0,
);

/// A controller for an animation.
///
/// This class lets you perform tasks such as:
///
/// * Play an animation [forward] or in [reverse], or [stop] an animation.
/// * Set the animation to a specific [value].
/// * Define the [upperBound] and [lowerBound] values of an animation.
/// * Create a [fling] animation effect using a physics simulation.
///
/// By default, an [AnimationController] linearly produces values that range
/// from 0.0 to 1.0, during a given duration. The animation controller generates
/// a new value whenever the device running your app is ready to display a new
/// frame (typically, this rate is around 60 values per second).
class AnimationController extends animation.AnimationController {
  /// Creates an animation controller.
  ///
  /// * `value` is the initial value of the animation. If defaults to the lower
  ///   bound.
  ///
  /// * [duration] is the length of time this animation should last.
  ///
  /// * [debugLabel] is a string to help identify this animation during
  ///   debugging (used by [toString]).
  ///
  /// * [lowerBound] is the smallest value this animation can obtain and the
  ///   value at which this animation is deemed to be dismissed. It cannot be
  ///   null.
  ///
  /// * [upperBound] is the largest value this animation can obtain and the
  ///   value at which this animation is deemed to be completed. It cannot be
  ///   null.
  ///
  /// * `vsync` is the [TickerProvider] for the current context. It can be
  ///   changed by calling [resync]. It is required and must not be null. See
  ///   [TickerProvider] for advice on obtaining a ticker provider.
  AnimationController({
    double? value,
    Duration? duration,
    Duration? reverseDuration,
    String? debugLabel,
    double lowerBound = 0.0,
    double upperBound = 1.0,
    animation.AnimationBehavior animationBehavior =
        animation.AnimationBehavior.normal,
    required TickerProvider vsync,
  }) : super(
            value: value,
            duration: duration,
            reverseDuration: reverseDuration,
            debugLabel: debugLabel,
            lowerBound: lowerBound,
            upperBound: upperBound,
            animationBehavior: animationBehavior,
            vsync: vsync);

  /// Creates an animation controller with no upper or lower bound for its
  /// value.
  ///
  /// * [value] is the initial value of the animation.
  ///
  /// * [duration] is the length of time this animation should last.
  ///
  /// * [debugLabel] is a string to help identify this animation during
  ///   debugging (used by [toString]).
  ///
  /// * `vsync` is the [TickerProvider] for the current context. It can be
  ///   changed by calling [resync]. It is required and must not be null. See
  ///   [TickerProvider] for advice on obtaining a ticker provider.
  ///
  /// This constructor is most useful for animations that will be driven using a
  /// physics simulation, especially when the physics simulation has no
  /// pre-determined bounds.
  AnimationController.unbounded({
    double value = 0.0,
    Duration? duration,
    Duration? reverseDuration,
    String? debugLabel,
    animation.AnimationBehavior animationBehavior =
        animation.AnimationBehavior.preserve,
    required TickerProvider vsync,
  }) : super.unbounded(
            value: value,
            duration: duration,
            reverseDuration: reverseDuration,
            debugLabel: debugLabel,
            animationBehavior: animationBehavior,
            vsync: vsync);

  /// Dynamically-updatable animate.
  TickerFuture dynamicAnimateWith(
      {double? value,
      double? target,
      double? velocity,
      Simulation? simulation}) {
    final _simulation =
        simulation ?? SpringSimulation(defaultSpringDescription, 0, 1, 0);
    _simulation.update(
        start: value ?? this.value,
        end: target,
        velocity: velocity ?? this.velocity);
    return animateWith(_simulation);
  }
}
