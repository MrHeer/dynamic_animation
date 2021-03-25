library dynamic_animation;

import 'package:flutter/physics.dart' as physics
    show SpringSimulation, SpringDescription;

import 'simulation.dart';

class SpringSimulation extends physics.SpringSimulation implements Simulation {
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
