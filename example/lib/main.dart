import 'package:flutter/material.dart' hide AnimationController, Simulation;
import 'package:flutter/physics.dart' hide Simulation, SpringSimulation;

import 'package:dynamic_animation/animation.dart';
import 'package:dynamic_animation/physics.dart';

main() {
  runApp(MaterialApp(home: DynamicAnimationDemo()));
}

class DynamicAnimationDemo extends StatefulWidget {
  @override
  _DynamicAnimationDemoState createState() => _DynamicAnimationDemoState();
}

class _DynamicAnimationDemoState extends State<DynamicAnimationDemo>
    with TickerProviderStateMixin {
  double _mass = 30.0;
  double _stiffness = 1.0;
  double _damping = 1.0;
  bool _init = false;
  late double _x;
  late double _y;
  late SpringDescription _spring;
  late SpringSimulation _simulationX;
  late SpringSimulation _simulationY;
  late final AnimationController _controllerX;
  late final AnimationController _controllerY;

  void _runAnimation(double x, double y) {
    _controllerX.dynamicAnimateWith(target: x, simulation: _simulationX);
    _controllerY.dynamicAnimateWith(target: y, simulation: _simulationY);
  }

  void _updateSpring({double? mass, double? stiffness, double? damping}) {
    setState(() {
      _mass = mass ?? _mass;
      _stiffness = stiffness ?? _stiffness;
      _damping = damping ?? _damping;
      _spring = SpringDescription(
          mass: _mass, stiffness: _stiffness, damping: _damping);
      _simulationX.updateSpring(_spring);
      _simulationY.updateSpring(_spring);
      _controllerX.dynamicAnimateWith(simulation: _simulationX);
      _controllerY.dynamicAnimateWith(simulation: _simulationY);
    });
  }

  @override
  void initState() {
    super.initState();
    _spring = SpringDescription(
        mass: _mass, stiffness: _stiffness, damping: _damping);
    _simulationX = SpringSimulation(_spring, 0, 1, 0);
    _simulationY = SpringSimulation(_spring, 0, 1, 0);
    _controllerX = AnimationController.unbounded(vsync: this);
    _controllerY = AnimationController.unbounded(vsync: this);

    _controllerX.addListener(() {
      setState(() {
        _x = _controllerX.value;
      });
    });

    _controllerY.addListener(() {
      setState(() {
        _y = _controllerY.value;
      });
    });
  }

  @override
  void dispose() {
    _controllerX.dispose();
    _controllerY.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_init) {
      final size = MediaQuery.of(context).size;
      _x = size.width / 2;
      _y = size.height / 2;
      _controllerX.value = _x;
      _controllerY.value = _y;
      _init = true;
    }
    return Container(
        child: Stack(
      children: [
        GestureDetector(
          onTapDown: (details) {
            _runAnimation(details.localPosition.dx, details.localPosition.dy);
          },
        ),
        Positioned(
          left: _x - 64,
          top: _y - 64,
          child: GestureDetector(
            onPanStart: (details) {
              _controllerX.stop();
              _controllerY.stop();
            },
            onPanUpdate: (details) {
              setState(() {
                _x += details.delta.dx;
                _y += details.delta.dy;
              });
            },
            onPanEnd: (details) {
              double dx = details.velocity.pixelsPerSecond.dx / 10;
              double dy = details.velocity.pixelsPerSecond.dy / 10;
              _controllerX.dynamicAnimateWith(
                  value: _x,
                  target: _x + dx,
                  velocity: dx,
                  simulation: _simulationX);
              _controllerY.dynamicAnimateWith(
                  value: _y,
                  target: _y + dy,
                  velocity: dy,
                  simulation: _simulationY);
            },
            child: FlutterLogo(
              size: 128,
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Card(
            margin: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text('mass: ' + _mass.toStringAsFixed(2)),
                      ),
                      Slider(
                        value: _mass,
                        min: 1,
                        max: 100,
                        onChanged: (value) {
                          _updateSpring(mass: value);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 100,
                          child: Text(
                              'stiffness: ' + _stiffness.toStringAsFixed(2))),
                      Slider(
                        value: _stiffness,
                        min: 1,
                        max: 10,
                        onChanged: (value) {
                          _updateSpring(stiffness: value);
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 100,
                          child:
                              Text('damping: ' + _damping.toStringAsFixed(2))),
                      Slider(
                        value: _damping,
                        min: 1,
                        max: 10,
                        onChanged: (value) {
                          _updateSpring(damping: value);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
