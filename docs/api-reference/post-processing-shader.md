<style>
    arg {
        color: grey;
        font-style: italic;
    }
</style>

# Post Processing Shader

A PostProcessingShader is a shader that is applied to the screen after the scene is rendered. Post-processing shaders cannot be used to modify Traced Rays, but they can be used to modify all Ray Tracer buffers. Post-processing shaders have access to all pixels in every buffer at once, and can modify them in any way they want.

<br>

## Creating a Post Processing Shader
---

### [Shader](./shader.md) Shader.new([function](https://create.roblox.com/docs/scripting/luau/functions) <arg>shaderFunction</arg>, [table](https://developer.roblox.com/en-us/articles/Table) <arg>attributes?</arg>)

Creates a new Post Processing Shader. <arg>shaderFunction</arg> is the function to call when the shader is applied. <arg>attributes</arg> is a table of attributes to pass to the shader.

<br>

## Properties
---

### [function](https://create.roblox.com/docs/scripting/luau/functions) Function
The function to call when the shader is applied.

!!! note
    The shader function is expected to return nil or all buffers in a dictionary.

---

### [table](https://developer.roblox.com/en-us/articles/Table) Attributes
Optional user-defined attributes to pass to the shader.

<br>

## Methods
---

### [dict](https://developer.roblox.com/en-us/articles/Table#dictionaries) Process([RayTracer](ray-tracer.md) <arg>rayTracer</arg>, <arg>...</arg>)

Processes the shader. <arg>rayTracer</arg> is the Ray Tracer that is emitting the rays. <arg>...</arg> is a list of optional arguments to pass to the shader.

!!! note
    The shader function is expected to return nil or all buffers in a dictionary.

---

### [table](https://developer.roblox.com/en-us/articles/Table)<[Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2)> GetAdjacentPixels([Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2) <arg>pixel</arg>, [Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2) <arg>resolution</arg>, [int](https://create.roblox.com/docs/reference/types#number) <arg>radius</arg>)

Returns a list of adjacent pixel coordinates to <arg>pixel</arg>. <arg>resolution</arg> is the resolution of the buffer. <arg>radius</arg> is the radius of the search.

!!! note
    The shape of the search area is always a square.

---

### [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) Color3ToVector3([Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3) <arg>color</arg>)

Converts a Color3 to a Vector3 to make math operations easier.

---

### [Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3) Vector3ToColor3([Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) <arg>vector</arg>, [boolean](https://developer.roblox.com/en-us/articles/Boolean) <arg>clamp? [=false]</arg>)

Converts a Vector3 to a Color3. If <arg>clamp</arg> is true, the vector will be clamped to the range [0, 1].

---

### [Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3) NumberToColor3([number](https://create.roblox.com/docs/reference/engine/datatypes/number) <arg>number</arg>)

Converts a number to a greyscale Color3.