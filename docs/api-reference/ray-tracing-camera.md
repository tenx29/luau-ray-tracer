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
### [RayTracingCamera](./ray-tracing-camera.md) RayTracingCamera.new([Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2) <arg>resolution</arg>, [float](https://developer.roblox.com/en-us/articles/Numbers) <arg>fieldOfView</arg>, [float](https://developer.roblox.com/en-us/articles/Numbers) <arg>nearPlane</arg>, [float](https://developer.roblox.com/en-us/articles/Numbers) <arg>farPlane</arg>, [CFrame](https://create.roblox.com/docs/reference/engine/datatypes/CFrame) <arg>CFrame</arg>, [string](https://developer.roblox.com/en-us/articles/String) <arg>projection [="perspective"]</arg>, [float](https://developer.roblox.com/en-us/articles/Numbers) <arg>orthographicSize? [=1]</arg>)

Creates a new RayTracingCamera. <arg>resolution</arg> is the camera viewport's size in pixels. <arg>fieldOfView</arg> is the camera's field of view in radians. <arg>nearPlane</arg> is the distance from the camera to the near plane. <arg>farPlane</arg> is the distance from the camera to the far plane. <arg>CFrame</arg> is the camera's position and orientation. <arg>projection</arg> is the projection type, either "perspective" or "orthographic". <arg>orthographicSize</arg> is the size of the orthographic projection in studs, which is applied only if <arg>projection</arg> is "orthographic".

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

!!! note
    FieldOfView is applied only if **[Projection](#string-projection)** is "perspective".

---

### [float](https://developer.roblox.com/en-us/articles/Numbers) FarPlane
The distance to the far plane.

---

### [CFrame](https://create.roblox.com/docs/reference/engine/datatypes/CFrame) CFrame
The camera's position and orientation.

---

### [string](https://developer.roblox.com/en-us/articles/String) Projection
The [projection type](https://en.wikipedia.org/wiki/3D_projection), either "perspective" or "orthographic".

!!! note
    Orthographic projection ignores the field of view and only uses **[OrthographicSize](#float-orthographicsize)**. Perspective projection uses the field of view to calculate the camera's view frustum.

---

### [float](https://developer.roblox.com/en-us/articles/Numbers) OrthographicSize
The size of the orthographic projection in studs, which is applied only if <arg>projection</arg> is "orthographic".

!!! note
    OrthographicSize is applied only if **[Projection](#string-projection)** is "orthographic".

<br>

## Methods
---

### [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) GetFarPlaneSize()
Returns the size of the far plane in studs.

---

### [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) GetNearPlaneSize()
Returns the size of the near plane in studs.

---

### [CFrame](https://create.roblox.com/docs/reference/engine/datatypes/CFrame) GetNearPlaneCFrame()
Returns the CFrame (position and orientation) of the camera's near plane.

---

### [CFrame](https://create.roblox.com/docs/reference/engine/datatypes/CFrame) GetFarPlaneCFrame()
Returns the CFrame of the camera's far plane.

---

### [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>origin</arg>, [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>direction</arg> GetRay([Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2) <arg>pixel</arg>)
Returns the origin and direction of the ray that passes through the given pixel.