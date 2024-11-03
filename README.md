# Dynamic Animation

The `dynamicTo` function is an extension method for `AnimationController`. It initiates a spring-based animation, transitioning from the current state (determined by `from` and `velocity`) to a specified `target` value.

## Parameters

- `target` (double, required): Defines the destination value.
- `from` (double, optional): Represents the starting value. If not provided, defaults to the `AnimationController`'s current value.
- `velocity` (double, optional): Indicates the starting speed. Defaults to the `AnimationController`'s current velocity.
- `springDescription` (SpringDescription, optional): Characterizes the spring-like behavior. Defaults to `defaultSpringDescription`.
- `tolerance` (Tolerance, optional): Determines the acceptable deviation. Defaults to `Tolerance.defaultTolerance`.

In summary, `dynamicTo` provides a convenient way to create spring animations on an `AnimationController`, allowing for easy target specification and optional customization of starting state and spring behavior parameters.
