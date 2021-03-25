/// The Flutter dynamic animation system.
///
/// To use, import `package:dynamic_animation/animation.dart`.
///
/// This library provides basic building blocks for implementing animations in
/// Flutter. Other layers of the framework use these building blocks to provide
/// advanced animation support for applications. For example, the widget library
/// includes [ImplicitlyAnimatedWidget]s and [AnimatedWidget]s that make it easy
/// to animate certain properties of a [Widget]. If those animated widgets are
/// not sufficient for a given use case, the basic building blocks provided by
/// this library can be used to implement custom animated effects.
library animation;

export 'src/animation/animation_controller.dart';
