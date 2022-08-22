<style>
    arg {
        color: grey;
        font-style: italic;
    }
</style>

# Ray Tracer

The Ray Tracer is a class that handles emitting rays and collecting scene information into different buffers.

!!! important
    The Ray Tracer needs a **[Ray Tracing Camera](./ray-tracing-camera.md)** to be able to render a scene.

<br>

## Creating a Ray Tracer
---

### [RayTracer](ray-tracer.md) RayTracer.new([RayTracingCamera](ray-tracing-camera.md) <arg>camera</arg>, [int](https://developer.roblox.com/en-us/articles/Numbers) <arg>maxBounces? [=1]</arg>, [table](https://developer.roblox.com/en-us/articles/Table)<[Shader](shader.md)> <arg>shaders?</arg>, [table](https://developer.roblox.com/en-us/articles/Table)<[PostProcessingShader](shader.md)> <arg>postProcessingShaders?</arg>, [RaycastParams](https://create.roblox.com/docs/reference/engine/datatypes/RaycastParams) <arg>raycastParams?</arg>)

Creates a new RayTracer. <arg>camera</arg> is the camera that will be used to render the scene. <arg>maxBounces?</arg> is the maximum number of bounces that will be performed. If <arg>maxBounces</arg> is not provided, 1 will be used. <arg>shaders?</arg> is a table of shaders that will be used to render the scene. <arg>postProcessingShaders?</arg> is a table of post-processing shaders that will be used to render the scene. <arg>raycastParams?</arg> is the raycast parameters that will be used to raycast the scene.

<br>

## Properties
---

### [RayTracingCamera](ray-tracing-camera.md) Camera
The RayTracingCamera that is used to render the scene.

---

### [int](https://developer.roblox.com/en-us/articles/Numbers) MaxBounces
The maximum number of bounces that will be performed. Defaults to 1.

---

### [table](https://developer.roblox.com/en-us/articles/Table)<[Shader](shader.md)> Shaders
The shaders that will be used to render the scene. Defaults to an empty table.

---

### [table](https://developer.roblox.com/en-us/articles/Table)<[PostProcessingShader](shader.md)> PostProcessingShaders
The post-processing shaders that will be used to render the scene. Defaults to an empty table. Post-processing shaders are applied after the scene is rendered.

---

### [dict](https://developer.roblox.com/en-us/articles/Table#dictionaries) {[2D table](https://developer.roblox.com/en-us/articles/Table)<[Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3)> <arg>Color</arg>, [2D table](https://developer.roblox.com/en-us/articles/Table)<[float](https://developer.roblox.com/en-us/articles/Numbers)> <arg>Depth</arg>, [2D table](https://developer.roblox.com/en-us/articles/Table)<[Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3)> <arg>Normal</arg>} Buffers
The buffers that will be used to render the scene. Each buffer is a 2D table where the first index is the x-coordinate and the second index is the y-coordinate. Buffers are usually accessed by post-processing shaders.

<br>

## Methods
---

### [void](#void-raytracerclearbuffers) ClearBuffers()
Clears all buffers of the RayTracer.

---

### [2D table](https://developer.roblox.com/en-us/articles/Table)<[Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3)> Render()
Clears all buffers and renders the scene. Returns the color buffer after the render is complete.
!!! note
    Post-processing shaders are not applied in this method. To apply post-processing shaders, use the **[PostProcess](#postprocess)** method after the initial render is complete.

---

### [dict](https://developer.roblox.com/en-us/articles/Table#dictionaries) PostProcess(<arg>...</arg>)
Applies post-processing shaders to the scene. <arg>...</arg> is any number of arguments passed to the post-processing shaders. Returns all buffers after the post-processing shaders are applied.

---

### [Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3) GetPixel([int](https://developer.roblox.com/en-us/articles/Numbers) <arg>x</arg>, [int](https://developer.roblox.com/en-us/articles/Numbers) <arg>y</arg>)
Gets the color of the pixel at <arg>x</arg>, <arg>y</arg> from the color buffer.

---

### [void](#void-raytracersetpixelinthttpsdeveloperrobloxcomen-usarticlesnumbers-argxarg-inthttpsdeveloperrobloxcomen-usarticlesnumbers-argyarg-color3httpscreaterobloxcomdocsreferenceenginedatatypescolor3-argcolorarg) SetPixel([int](https://developer.roblox.com/en-us/articles/Numbers) <arg>x</arg>, [int](https://developer.roblox.com/en-us/articles/Numbers) <arg>y</arg>, [Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3) <arg>color</arg>)
Sets the color of the pixel at <arg>x</arg>, <arg>y</arg> in the color buffer.

---

### [Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3) VisualizeNormal([Vector3](https://developer.roblox.com/en-us/articles/Numbers) <arg>normal</arg>)
Visualizes a unit vector <arg>normal</arg> as a color.