import 'package:flutter/material.dart';
import 'package:dynamic_animation/extensions.dart';

main() {
  runApp(MaterialApp(home: DynamicAnimationDemo()));
}

const _logoSize = 128.0;

class DynamicAnimationDemo extends StatefulWidget {
  @override
  _DynamicAnimationDemoState createState() => _DynamicAnimationDemoState();
}

class _DynamicAnimationDemoState extends State<DynamicAnimationDemo>
    with TickerProviderStateMixin {
  var _mass = 30.0;
  var _stiffness = 1.0;
  var _damping = 1.0;
  var _init = false;
  late final _controllerX = AnimationController.unbounded(vsync: this);
  late final _controllerY = AnimationController.unbounded(vsync: this);

  get _spring => SpringDescription(
        mass: _mass,
        stiffness: _stiffness,
        damping: _damping,
      );

  void _runAnimation({
    required Offset target,
    Offset? value,
    Offset? velocity,
  }) {
    _controllerX.dynamicAnimateWith(
      target: target.dx,
      value: value?.dx,
      velocity: velocity?.dx,
      springDescription: _spring,
    );
    _controllerY.dynamicAnimateWith(
      target: target.dy,
      value: value?.dy,
      velocity: velocity?.dy,
      springDescription: _spring,
    );
  }

  void _updateSpringProps({
    double? mass,
    double? stiffness,
    double? damping,
  }) {
    setState(() {
      _mass = mass ?? _mass;
      _stiffness = stiffness ?? _stiffness;
      _damping = damping ?? _damping;
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
      _controllerX.value = size.width / 2;
      _controllerY.value = size.height / 2;
      _init = true;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              GestureDetector(
                onTapDown: (details) {
                  _runAnimation(target: details.localPosition);
                },
              ),
              AnimatedBuilder(
                animation: Listenable.merge([_controllerX, _controllerY]),
                child: const FlutterLogo(size: _logoSize),
                builder: (context, child) => Positioned(
                  left: _controllerX.value - _logoSize / 2,
                  top: _controllerY.value - _logoSize / 2,
                  child: child!,
                ),
              ),
              _SpringController(
                mass: _mass,
                stiffness: _stiffness,
                damping: _damping,
                onChange: _updateSpringProps,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpringController extends StatelessWidget {
  const _SpringController({
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
                    child: Text('mass: ' + mass.toStringAsFixed(2)),
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
                      child:
                          Text('stiffness: ' + stiffness.toStringAsFixed(2))),
                  Slider(
                    value: stiffness,
                    min: 1,
                    max: 10,
                    onChanged: (stiffness) {
                      _valueChangeHandler(stiffness: stiffness);
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 100,
                      child: Text('damping: ' + damping.toStringAsFixed(2))),
                  Slider(
                    value: damping,
                    min: 1,
                    max: 10,
                    onChanged: (damping) {
                      _valueChangeHandler(damping: damping);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
