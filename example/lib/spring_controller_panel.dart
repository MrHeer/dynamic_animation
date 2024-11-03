import 'package:flutter/material.dart';

class SpringControllerPanel extends StatelessWidget {
  const SpringControllerPanel({
    super.key,
    required this.mass,
    required this.stiffness,
    required this.damping,
    required this.onChange,
  });

  final double mass;
  final double stiffness;
  final double damping;
  final void Function({
    required double mass,
    required double stiffness,
    required double damping,
  }) onChange;

  void _valueChangeHandler({
    double? mass,
    double? stiffness,
    double? damping,
  }) {
    onChange(
      mass: mass ?? this.mass,
      stiffness: stiffness ?? this.stiffness,
      damping: damping ?? this.damping,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                    child: Text('mass: ${mass.toStringAsFixed(2)}'),
                  ),
                  Slider(
                    value: mass,
                    min: 1,
                    max: 100,
                    onChanged: (mass) {
                      _valueChangeHandler(mass: mass);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text('stiffness: ${stiffness.toStringAsFixed(2)}'),
                  ),
                  Slider(
                    value: stiffness,
                    min: 1,
                    max: 10,
                    onChanged: (stiffness) {
                      _valueChangeHandler(stiffness: stiffness);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text('damping: ${damping.toStringAsFixed(2)}'),
                  ),
                  Slider(
                    value: damping,
                    min: 1,
                    max: 10,
                    onChanged: (damping) {
                      _valueChangeHandler(damping: damping);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
