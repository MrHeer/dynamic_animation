import 'package:flutter/physics.dart' as physics
    show SpringSimulation, SpringDescription;

import 'simulation.dart';

/// A spring simulation.
///
/// Models a particle attached to a spring that follows Hooke's law.
class SpringSimulation extends physics.SpringSimulation implements Simulation {
  /// Creates a spring simulation from the provided spring description, start
  /// distance, end distance, and initial velocity.
  ///
  /// The units for the start and end distance arguments are arbitrary, but must
  /// be consistent with the units used for other lengths in the system.
  ///
  /// The units for the velocity are L/T, where L is the aforementioned
  /// arbitrary unit of length, and T is the time unit used for driving the
  /// [SpringSimulation].
  SpringSimulation(physics.SpringDescription spring, double start, double end,
      double velocity)
      : _spring = spring,
        super(spring, start, end, velocity);

  final physics.SpringDescription _spring;

  @override
  Simulation update(double start, double end, double velocity) {
    return SpringSimulation(_spring, start, end, velocity);
  }
}
