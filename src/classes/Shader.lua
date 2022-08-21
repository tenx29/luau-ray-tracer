local RayIntersect = require(script.Parent.Parent.utils.RayIntersect)
local TracedRay = require(script.Parent.TracedRay)

export type Shader = {
    Function: (Ray: TracedRay, Hit: RaycastResult, any...) -> Color3 | number,
    Attributes: {},
    Reflect: (Ray: TracedRay, Hit: RaycastResult, Normal: Vector3) -> TracedRay,
    Refract: (Ray: TracedRay, Hit: RaycastResult, Normal: Vector3, RefractiveIndex: number) -> TracedRay,
    SimpleIntersect: (Ray: TracedRay, Hit: RaycastResult) -> TracedRay,
    ComplexIntersect: (Ray: TracedRay, Hit: RaycastResult) -> TracedRay,
    Continue: (Ray: TracedRay, Hit: RaycastResult) -> TracedRay,
    Process: (Ray: TracedRay, Hit: RaycastResult) -> Color3 | number,
}

local Shader = {}
Shader.__index = Shader

function Shader.new(Function: Function, Attributes: {[string]: any})
    local self = setmetatable({}, Shader)
    self.Function = Function
    self.Attributes = Attributes
    return self
end

-- Helper function to create a reflected ray.
function Shader:Reflect(Ray: TracedRay, Hit: RaycastResult, Normal: Vector3)
    local Direction = Ray.Direction
    local Dot = Direction:Dot(Normal)
    local Reflected = Direction - (Normal * 2 * Dot)
    return TracedRay.new(Ray.Pixel, Hit.Position, Reflected, Ray.MaxBounces-Ray.Bounces, Ray.RaycastParams, Ray.Shaders):Trace()
end

-- Helper function to create a refracted ray.
function Shader:Refract(Ray: TracedRay, Hit: RaycastResult, Normal: Vector3, RefractiveIndex: number)
    local Direction = Ray.Direction
    local Dot = Direction:Dot(Normal)
    local RefractiveIndexRatio = RefractiveIndex / 1.0
    local CosTheta = math.sqrt(1 - (RefractiveIndexRatio * RefractiveIndexRatio) * (1 - (Dot * Dot)))
    local Refracted = RefractiveIndexRatio * Direction + (Normal * (RefractiveIndexRatio * Dot - CosTheta))
    return TracedRay.new(Ray.Pixel, Hit.Position, Refracted, Ray.MaxBounces-Ray.Bounces, Ray.RaycastParams, Ray.Shaders):Trace()
end

-- Helper function to determine intersection end point and length with simple geometry.
function Shader:SimpleIntersect(Origin: Vector3, Direction: Vector3, Object: Instance)
    return RayIntersect.GetIntersection(Origin, Direction, Object)
end

-- Helper function to determine intersection end point and length with complex geometry.
function Shader:ComplexIntersect(Origin: Vector3, Direction: Vector3, Object: Instance)
    local endPoints, totalLength = RayIntersect.GetComplexIntersection(Origin, Direction, Object)
    return endPoints[1], (Origin-endPoints[1]).Magnitude
end


-- Helper function to continue a ray.
function Shader:Continue(Ray: TracedRay, Hit: RaycastResult)
    return TracedRay.new(Ray.Pixel, Hit.Position, Ray.Direction, Ray.MaxBounces, Ray.RaycastParams, Ray.Shaders):Trace()
end

-- Process the vertex shader
function Shader:Process(Ray: TracedRay, Hit: RaycastResult, ...)
    if not self.Function then return end
    return self.Function(Ray, Hit, ...)
end

return Shader