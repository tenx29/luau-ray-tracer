<style>
    arg {
        color: grey;
        font-style: italic;
    }
</style>

# Ray Tracing Camera

The RayTracingCamera is a special camera class that can be used to render a scene using ray tracing. The camera provides the necessary functions to render a scene using ray tracing.

!!! warning
    RayTracingCamera can not be used as a normal camera.

<br>

## Creating a RayTracingCamera
---
### [RayTracingCamera](./ray-tracing-camera.md) RayTracingCamera.new([Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2) <arg>resolution</arg>, [float](https://developer.roblox.com/en-us/articles/Numbers) <arg>fieldOfView</arg>, [float](https://developer.roblox.com/en-us/articles/Numbers) <arg>farPlane</arg>, [CFrame](https://create.roblox.com/docs/reference/engine/datatypes/CFrame) <arg>CFrame</arg> )

Creates a new RayTracingCamera. <arg>resolution</arg> is the camera viewport's size in pixels. <arg>fieldOfView</arg> is the camera's field of view in radians. <arg>farPlane</arg> is the distance to the far plane. <arg>CFrame</arg> is the camera's position and orientation.

!!! important
    The RayTracingCamera acts as the origin point for the rays. This means that the camera's position and orientation must be set before the camera is used to render a scene.

!!! note
    The camera does not do any rendering itself. It only provides the necessary functions to render a scene using ray tracing. Images can be rendered using the **[Raytracer](./ray-tracer.md)** class.

<br>

## Properties
---

### [Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2) Resolution
The resolution of the camera viewport in pixels.

---

### [float](https://developer.roblox.com/en-us/articles/Numbers) FieldOfView
The camera's field of view in radians.

---

### [float](https://developer.roblox.com/en-us/articles/Numbers) FarPlane
The distance to the far plane.

---

### [CFRame](https://create.roblox.com/docs/reference/engine/datatypes/CFrame) CFrame
The camera's position and orientation.

<br>

## Methods
---

### [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) GetPixelDirection([Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2) <arg>pixel</arg>)
Returns the direction of the ray that goes through the given pixel.

### {[Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>origin</arg>, [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>direction</arg>} GetInitialRay([Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2) <arg>pixel</arg>)
Returns the origin and direction of the ray that goes through the given pixel.