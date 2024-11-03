import 'package:example/spring_controller_panel.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_animation/extensions.dart';

main() {
  runApp(const MaterialApp(home: DynamicAnimationDemo()));
}

const _logoSize = 128.0;

class DynamicAnimationDemo extends StatefulWidget {
  const DynamicAnimationDemo({super.key});

  @override
  State createState() => _DynamicAnimationDemoState();
}

class _DynamicAnimationDemoState extends State<DynamicAnimationDemo>
    with TickerProviderStateMixin {
  var _mass = 30.0;
  var _stiffness = 1.0;
  var _damping = 1.0;
  late final _controllerX = AnimationController.unbounded(vsync: this);
  late final _controllerY = AnimationController.unbounded(vsync: this);

  get _spring => SpringDescription(
        mass: _mass,
        stiffness: _stiffness,
        damping: _damping,
      );

  void _animateTo(
    Offset target,
  ) {
    _controllerX.dynamicTo(
      target.dx,
      springDescription: _spring,
    );
    _controllerY.dynamicTo(
      target.dy,
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
  void didChangeDependencies() {
    final size = MediaQuery.of(context).size;
    _controllerX.value = size.width / 2;
    _controllerY.value = size.height / 2;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              GestureDetector(
                onTapDown: (details) {
                  _animateTo(details.localPosition);
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
              SpringControllerPanel(
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
