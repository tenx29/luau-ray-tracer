<style>
    arg {
        color: grey;
        font-style: italic;
    }
</style>

# Traced Ray

A TracedRay is a ray that has been traced through a scene. The TracedRay handles the ray's position and orientation, as well as runs any shader effects on the ray.

!!! warning
    This class is not meant to be used directly.

<br>


## Constructor
---

### [TracedRay](./traced-ray.md) TracedRay.new([Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>origin</arg>, [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>direction</arg>, [int](https://developer.roblox.com/en-us/articles/Numbers) <arg>maxBounces</arg>, [RaycastParams](https://create.roblox.com/docs/reference/engine/datatypes/RaycastParams) <arg>raycastParams</arg>, [table](https://create.roblox.com/docs/reference/engine/datatypes/table)<[Shader](shader.md)> <arg>shaders</arg>)

Creates a new TracedRay. <arg>maxBounces</arg> is the maximum number of bounces the ray can make. <arg>raycastParams</arg> is the raycast parameters to use when tracing the ray. <arg>shaders</arg> is a table of shader effects to apply to the ray.


<br>

## Properties
---

### [Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2) Pixel
The viewport pixel the ray originates from.

---

### [Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3) Color
The color of the ray.

---

### [int](https://developer.roblox.com/en-us/articles/Numbers) Bounces
The number of bounces the ray has undergone.

---

### [dict](https://developer.roblox.com/en-us/articles/Table#dictionaries) {[float](https://developer.roblox.com/en-us/articles/Numbers) <arg>Distance</arg>, [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>Normal</arg>} InitialCollision
The first collision the ray has undergone.

---

### [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) Origin
The origin of the ray.

---

### [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) Direction
The direction of the ray.

---

### [int](https://developer.roblox.com/en-us/articles/Numbers) MaxBounces
The maximum number of bounces the ray can undergo.

---

### [RaycastParams](https://create.roblox.com/docs/reference/engine/datatypes/RaycastParams) RaycastParams
The raycast parameters used to trace the ray.

---

### [table](https://developer.roblox.com/en-us/articles/Tables)<[Shader](shader.md)> Shaders
The shaders that the ray can run.

<br>

## Methods
---

### [TracedRay]() Trace()
Traces the ray and runs any shader effects when the ray terminates. Returns the TracedRay object itself.