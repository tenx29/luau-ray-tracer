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

function TracedRay.new(Pixel: Vector2, Origin: Vector3, Direction: Vector3, MaxBounces: number, RaycastParams: RaycastParams, Shaders: {})
    local self = setmetatable({}, TracedRay)
    self.Pixel = Pixel
    self.Color = Color3.fromRGB(255, 0, 255)
    self.Bounces = 0
    self.InitialCollision = {
        Distance = 1;
        Normal = Vector3.new(0, 0, 0);
    }
    self.Origin = Origin
    self.Direction = Direction
    self.MaxBounces = MaxBounces
    self.RaycastParams = RaycastParams
    self.Shaders = Shaders
    return self
end

-- Trace a ray until it hits nothing or the maximum number of bounces.
function TracedRay:Trace()
    local result = workspace:Raycast(self.Origin, self.Direction, self.RaycastParams)
    if result then
        if self.Bounces == 0 then
            self.InitialCollision = {
                Distance = (result.Position - self.Origin).Magnitude / self.Direction.Magnitude;
                Normal = result.Normal;
            }
        end
        self.Bounces += 1
        if self.Bounces <= self.MaxBounces then
            for _, Shader in self.Shaders do
                self.Color = Shader:Process(self, result) or self.Color
            end
        end
    else
        self.InitialDepth = 1
        for _, Shader in self.Shaders do
            self.Color = Shader:Process(self, nil) or self.Color
        end
    end
    if self.Color == Color3.fromRGB(255, 0, 255) then
        -- Fallback color
        for _, Shader in self.Shaders do
            self.Color = Shader:Process(self, result) or self.Color
        end
    end
    return self
end

return TracedRay