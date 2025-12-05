A basic first person controller for use in Godot 4.

This example makes use of physics interpolation for jitter free camera movement regardless of the physics tick rate.

Physics interpolation can be enabled or disabled in project_settings > general > physics > common > physics_interpolation.

If you disable physics interpolation in the demo project, you will see how much objects appear to jitter when moving and looking around. You can especially see it if you set the physics tick rate to something low like 10/s.

In terms of using the first person controller, any models/meshes that should rotate should be children of "Actor". Any objects/meshes that should follow the view should be children of "Head".
