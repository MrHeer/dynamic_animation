import 'package:flutter/physics.dart' as physics show Simulation, Tolerance;

/// The base class for all simulations.
///
/// A simulation models an object, in a one-dimensional space, on which particular
/// forces are being applied, and exposes:
///
///  * The object's position, [x]
///  * The object's velocity, [dx]
///  * Whether the simulation is "done", [isDone]
///
/// A simulation is generally "done" if the object has, to a given [tolerance],
/// come to a complete rest.
///
/// The [x], [dx], and [isDone] functions take a time argument which specifies
/// the time for which they are to be evaluated. In principle, simulations can
/// be stateless, and thus can be queried with arbitrary times. In practice,
/// however, some simulations are not, and calling any of these functions will
/// advance the simulation to the given time.
///
/// As a general rule, therefore, a simulation should only be queried using
/// times that are equal to or greater than all times previously used for that
/// simulation.
///
/// Simulations do not specify units for distance, velocity, and time. Client
/// should establish a convention and use that convention consistently with all
/// related objects.
abstract class Simulation extends physics.Simulation {
  /// Initializes the [tolerance] field for subclasses.
  Simulation({tolerance = physics.Tolerance.defaultTolerance});

  /// This method used to update this [Simulation] with `start`, `end` and `velocity`.
  void update({double? start, double? end, double? velocity});

  /// This method used to update this [Simulation].
  void updateSimulation();
}
