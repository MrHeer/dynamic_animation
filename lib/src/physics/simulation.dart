library dynamic_animation;

import 'package:flutter/physics.dart' as physics show Simulation;

abstract class Simulation extends physics.Simulation {
  /// This method used to update [Simulation].
  Simulation update(double start, double end, double velocity);
}
