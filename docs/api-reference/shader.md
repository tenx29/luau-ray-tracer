<style>
    arg {
        color: grey;
        font-style: italic;
    }
</style>

# Shader

A Shader is an object that is used to modify the behavior of a ray. It is applied to the ray when it is traced. Each shader is applied to a ray in the order they are in the ray's shader table. Because a shader is applied to each ray individually, they cannot be used to modify the adjacent pixels.

<br>

## Creating a Shader
---

### [Shader](./shader.md) Shader.new([function](https://create.roblox.com/docs/scripting/luau/functions) <arg>shaderFunction</arg>, [table](https://developer.roblox.com/en-us/articles/Table) <arg>attributes?</arg>)

Creates a new Shader. <arg>shaderFunction</arg> is the function to call when the shader is applied. <arg>attributes</arg> is a table of attributes to pass to the shader.

<br>

## Properties
---

### [function](https://create.roblox.com/docs/scripting/luau/functions) Function
The function to call when the shader is applied.

!!! note
    The shader function is expected to return an **[Out](traced-ray.md#dict-out)** dictionary. If the shader function returns nothing, the ray will keep its current output.

    For backwards compatibility, the shader can also return a Color3. Note that **[TracedRay.Color](traced-ray.md#color3-color)** is deprecated and will be removed in a future version.

---

### [table](https://developer.roblox.com/en-us/articles/Table) Attributes
Optional user-defined attributes to pass to the shader.

<br>

## Methods
---

### [dict](https://developer.roblox.com/en-us/articles/Table#dictionaries) Process([TracedRay](traced-ray.md) <arg>tracedRay</arg>, [RaycastResult](https://create.roblox.com/docs/reference/engine/datatypes/RaycastResult) <arg>raycastResult</arg>, <arg>...</arg>)

Process the shader on the ray. <arg>tracedRay</arg> is the ray that is being processed. <arg>raycastResult</arg> is the result of the raycast. <arg>...</arg> is any additional arguments passed to the shader. The dictionary returned by the shader is expected to match the format of **[Ray.Out](traced-ray.md)**.

!!! warning
    **[Ray.Out](traced-ray.md)** should never contain values for non-existent buffers.

---

### [TracedRay](./traced-ray.md) Continue([TracedRay](./traced-ray.md) <arg>tracedRay</arg>, [RaycastResult](https://create.roblox.com/docs/reference/engine/datatypes/RaycastResult) <arg>raycastResult</arg>)

Continues the ray after it has been processed by the shader. <arg>tracedRay</arg> is the ray that is being processed. <arg>raycastResult</arg> is the result of the raycast.
!!! note
    This method will continue the ray in the same direction as the ray's previous direction. For more fine control over how the ray is continued, create a new **[TracedRay](traced-ray.md)** manually in a shader.

---

### [TracedRay](./traced-ray.md) Reflect([TracedRay](./traced-ray.md) <arg>tracedRay</arg>, [RaycastResult](https://create.roblox.com/docs/reference/engine/datatypes/RaycastResult) <arg>raycastResult</arg>, [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>normal</arg>)

Reflects the ray. <arg>tracedRay</arg> is the ray that is being processed. <arg>raycastResult</arg> is the result of the raycast. <arg>normal</arg> is the normal of the surface the ray hit.

---

### [TracedRay](./traced-ray.md) Refract([TracedRay](./traced-ray.md) <arg>tracedRay</arg>, [RaycastResult](https://create.roblox.com/docs/reference/engine/datatypes/RaycastResult) <arg>raycastResult</arg>, [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>normal</arg>, [number](https://create.roblox.com/docs/reference/engine/datatypes/number) <arg>indexOfRefraction</arg>)])

Refracts the ray. <arg>tracedRay</arg> is the ray that is being processed. <arg>raycastResult</arg> is the result of the raycast. <arg>normal</arg> is the normal of the surface the ray hit. <arg>indexOfRefraction</arg> is the index of refraction of the material the ray hit.

---

### [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3), [float](https://create.roblox.com/docs/reference/engine/datatypes/float) SimpleIntersect([Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>origin</arg>, [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>direction</arg>, [Instance](https://create.roblox.com/docs/reference/engine/datatypes/Instance) <arg>object</arg>)

Calculates the intersection end point and length of a ray through an object based on its outermost geometry. <arg>origin</arg> is the origin of the ray. <arg>direction</arg> is the direction of the ray.

---

### [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3), [float](https://create.roblox.com/docs/reference/engine/datatypes/float) ComplexIntersect([Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>origin</arg>, [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>direction</arg>, [Instance](https://create.roblox.com/docs/reference/engine/datatypes/Instance) <arg>object</arg>)

Calculates the first intersection end point and length of a ray through an object based on its true geometry. <arg>origin</arg> is the origin of the ray. <arg>direction</arg> is the direction of the ray. This method is more accurate than **[SimpleIntersect](#vector3-float-simpleintersectvector3-origin-vector3-direction-instance-object)** but is slower.

---

### [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) Color3ToVector3([Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3) <arg>color</arg>)

Converts a Color3 to a Vector3 to make math operations easier.

!!! important
    Shaders are expected to return a Color3. If you convert a Color3 to a Vector3, remember to convert it back to a Color3 when returning a value.

---

### [Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3) Vector3ToColor3([Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>vector</arg>, [boolean](https://developer.roblox.com/en-us/articles/Boolean) <arg>clamp? [=false]</arg>)

Converts a Vector3 to a Color3. If <arg>clamp</arg> is true, the vector will be clamped to the range [0, 1].

---

### [Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3) NumberToColor3([number](https://create.roblox.com/docs/reference/engine/datatypes/number) <arg>number</arg>)

Converts a number to a greyscale Color3.