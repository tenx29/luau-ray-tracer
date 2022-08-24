export type TracedRay = {
    Pixel: Vector2;
    Color: Color3;
    Bounces: number;
    Origin: Vector3;
    Direction: Vector3;
    MaxBounces: number;
    RaycastParams: RaycastParams;
    Shaders: {};
}

local TracedRay = {}
TracedRay.__index = TracedRay

function TracedRay.new(Pixel: Vector2, Origin: Vector3, Direction: Vector3, MaxBounces: number, RaycastParams: RaycastParams, Shaders: {}, Out: {}?)
    local self = setmetatable({}, TracedRay)
    self.Pixel = Pixel
    self.Color = Color3.fromRGB(255, 0, 255)
    self.Bounces = 0
    self.Origin = Origin
    self.Direction = Direction
    self.MaxBounces = MaxBounces
    self.RaycastParams = RaycastParams
    self.Shaders = Shaders

    self.Out = Out or {
        Color = Color3.new(1, 0, 1);
        Depth = 1;
        Normal = Vector3.new(0, 0, 0);
    }

    -- Create a shallow copy of the out defaults to avoid modifying them.
    self.OutDefaults = {}

    for k, v in pairs(self.Out) do
        self.OutDefaults[k] = v
    end

    return self
end

function applyShaderResult(self, result)
    if typeof(result) == "Color3" then
        self.Color = result
        self.Out.Color = result
    elseif result then
        self.Out = result
        if result.Color then
            self.Color = result.Color
        end
    end
end

-- Trace a ray until it hits nothing or the maximum number of bounces.
function TracedRay:Trace(...)
    local result = workspace:Raycast(self.Origin, self.Direction, self.RaycastParams)
    if result then
        self.Bounces += 1
        if self.Bounces <= self.MaxBounces then
            for _, Shader in self.Shaders do
                applyShaderResult(self, Shader:Process(self, result, ...))
            end
        end

        -- Add depth and normal to output. These cannot be overwritten by shaders.
        self.Out.Depth = (result.Position - self.Origin).Magnitude / self.Direction.Magnitude
        self.Out.Normal = result.Normal
    else
        for _, Shader in self.Shaders do
            applyShaderResult(self, Shader:Process(self, result, ...))
        end
    end
    if self.Color == Color3.fromRGB(255, 0, 255) then
        -- Fallback color
        for _, Shader in self.Shaders do
            applyShaderResult(self, Shader:Process(self, result, ...))
        end
    end

    return self
end

return TracedRay