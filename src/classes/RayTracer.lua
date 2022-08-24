local TracedRay = require(script.Parent.TracedRay)

local RayTracer = {}
RayTracer.__index = RayTracer

-- Create a new raytracer
-- @param Camera: The camera to use for the raytracer
-- @param MaxBounces: The maximum number of bounces to perform
-- @param Shaders: The shaders to use for the raytracer
-- @param PostProcessingShaders: The post-processing shaders to use for the raytracer. These are applied after the shaders in order based on their index.
-- @param RaycastParams: The raycast parameters to use for the raytracer
function RayTracer.new(Camera: RayTracingCamera, MaxBounces: number?, Shaders: {Shader}?, PostProcessingShaders: {PostProcessingShader}?, RaycastParams: RaycastParams?)
    local self = setmetatable({}, RayTracer)
    self.Camera = Camera
    self.MaxBounces = MaxBounces or 10
    self.Shaders = Shaders or {}
    self.PostProcessingShaders = PostProcessingShaders or {}
    self.RaycastParams = RaycastParams
    self.Buffers = {
        Color = {};
        Depth = {};
        Normal = {};
    }
    return self
end

-- Clear all buffers
function RayTracer:ClearBuffers()
    for _, buffer in pairs(self.Buffers) do
        buffer = {}
    end
end

-- Add a buffer to the raytracer
function RayTracer:AddBuffer(BufferName: string)
    self.Buffers[BufferName] = {}
end

-- Remove a buffer from the raytracer
function RayTracer:RemoveBuffer(BufferName: string)
    self.Buffers[BufferName] = nil
end

-- Visualise the normal buffer
function RayTracer:VisualizeNormal(normal: Vector3): Color3
    return Color3.new((normal.X+1)/2, (normal.Y+1)/2, (normal.Z+1)/2)
end

-- Render the entire frame
function RayTracer:Render(...): {{Color3}}
    self:ClearBuffers()
    for x = 1, self.Camera.Resolution.X do
        for _, buffer in self.Buffers do
            buffer[x] = {}
        end
        for y = 1, self.Camera.Resolution.Y do
            local Pixel = Vector2.new(x, y)
            local Origin, Direction = self.Camera:GetRay(Pixel)

            local Ray = TracedRay.new(Pixel, Origin, Direction * (self.Camera.FarPlane - self.Camera.NearPlane), self.MaxBounces, nil, self.Shaders)
            local result = Ray:Trace(...)

            for buffer, value in pairs(result.Out) do
                self.Buffers[buffer][x][y] = value
            end
        end
    end
    return self.Buffers.Color
end

-- Postprocess the image
function RayTracer:PostProcess(...): {}
    for _, PostProcessingShader in self.PostProcessingShaders do
        self.Buffers = PostProcessingShader:Process(self, ...) or self.Buffers
    end
    return self.Buffers
end

-- Set a single pixel in the color buffer
-- @param X: The x coordinate of the pixel
-- @param Y: The y coordinate of the pixel
-- @param Color: The color to set the pixel to
function RayTracer:SetPixel(x, y, Color: Color3)
    self.Buffers.Color[x][y] = Color
end

-- Get a single pixel from the color buffer
-- @param X: The x coordinate of the pixel to get
-- @param Y: The y coordinate of the pixel to get
function RayTracer:GetPixel(x, y): Color3
    if not self.Buffers[x] then
        return nil
    end
    return self.Buffers.Color[x][y]
end

return RayTracer
