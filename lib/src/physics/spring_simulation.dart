import 'package:flutter/foundation.dart';
import 'package:flutter/physics.dart' as physics
    show SpringSimulation, SpringDescription, SpringType, Tolerance;

import 'simulation.dart';

/// A spring simulation.
///
/// Models a particle attached to a spring that follows Hooke's law.
class SpringSimulation extends Simulation {
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
      double velocity,
      {physics.Tolerance tolerance = physics.Tolerance.defaultTolerance})
      : _spring = spring,
        _startPosition = start,
        _endPosition = end,
        _velocity = velocity,
        super(tolerance: tolerance) {
    updateSimulation();
  }

  late physics.SpringSimulation _simulation;
  late physics.SpringDescription _spring;
  late double _startPosition;
  late double _endPosition;
  late double _velocity;

  /// The kind of spring being simulated, for debugging purposes.
  ///
  /// This is derived from the [SpringDescription] provided to the [new
  /// SpringSimulation] constructor.
  physics.SpringType get type => _simulation.type;

  @override
  double x(double time) => _simulation.x(time);

  @override
  double dx(double time) => _simulation.dx(time);

  @override
  bool isDone(double time) => _simulation.isDone(time);

  @override
  void update({double? start, double? end, double? velocity}) {
    _startPosition = start ?? _startPosition;
    _endPosition = end ?? _endPosition;
    _velocity = velocity ?? _velocity;
    updateSimulation();
  }

  // update [SpringSimulation] with `spring`
  void updateSpring(physics.SpringDescription spring) {
    _spring = spring;
    updateSimulation();
  }

  @override
  void updateSimulation() {
    _simulation = physics.SpringSimulation(
        _spring, _startPosition, _endPosition, _velocity);
  }

  @override
  String toString() =>
      '${objectRuntimeType(this, 'SpringSimulation')}(end: $_endPosition, $type)';
}
