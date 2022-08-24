-- Resolution is the dimensions of the viewport in pixels as a Vector2.
-- Field of view is the angle between the top and bottom of the viewport in radians as a number.
-- Near plane is the distance to the near clipping plane.
-- Far plane is the distance to the far clipping plane.
-- CFrame is the position and orientation of the camera.

export type RayTracingCamera = {
    Resolution: Vector2;
    FieldOfView: number;
    NearPlane: number;
    FarPlane: number;
    CFrame: CFrame;
    Projection: 'perspective' | 'orthographic';
    OrthographicSize: number;
}

local RayTracingCamera = {}
RayTracingCamera.__index = RayTracingCamera

function RayTracingCamera.new(resolution: Vector2, fieldOfView: number, nearPlane: number, farPlane: number, cFrame: CFrame, projection: 'perspective' | 'orthographic' | nil, orthographicSize: number?)
    local self = setmetatable({}, RayTracingCamera)
    self.Resolution = resolution
    self.FieldOfView = fieldOfView
    self.NearPlane = nearPlane
    self.FarPlane = farPlane
    self.CFrame = cFrame
    self.Projection = projection or 'perspective'
    self.OrthographicSize = orthographicSize or 1
    return self
end


-- Calculate the size of the far clip plane in studs.
-- @return [T:Vector3] The size of the far clip plane in studs.
function RayTracingCamera:GetFarPlaneSize()
    local aspectRatio = self.Resolution.X / self.Resolution.Y
    if self.Projection == 'perspective' then
        local halfFov = self.FieldOfView / 2
        local farPlaneSize = 2 * math.tan(halfFov) * self.FarPlane
        return Vector3.new(farPlaneSize * aspectRatio, farPlaneSize, 0)
    else
        return Vector3.new(self.OrthographicSize * aspectRatio, self.OrthographicSize, 0)
    end
end

-- Calculate the far clip plane's CFrame.
-- @return [T:CFrame] The far clip plane's CFrame.
function RayTracingCamera:GetFarPlaneCFrame()
    local size = self:GetFarPlaneSize()
    return self.CFrame * CFrame.new(0, 0, -self.FarPlane)
end


-- Calculate the size of the near clip plane in studs.
function RayTracingCamera:GetNearPlaneSize()
    if self.Projection == 'perspective' then
        local aspectRatio = self.Resolution.X / self.Resolution.Y
        local halfFov = self.FieldOfView / 2
        local nearPlaneSize = math.tan(halfFov) * self.NearPlane
        return Vector3.new(nearPlaneSize * aspectRatio, nearPlaneSize, 0)
    else
        return self:GetFarPlaneSize()
    end
end


-- Calculate the near clip plane's CFrame.
function RayTracingCamera:GetNearPlaneCFrame()
    local size = self:GetNearPlaneSize()
    return self.CFrame * CFrame.new(0, 0, -self.NearPlane)
end

-- Get the initial raycast information for a pixel.
-- @param pixel [T:Vector2] The pixel to get the ray for.
-- @return [T:Ray] The pixel's ray.
function RayTracingCamera:GetRay(pixel: Vector2): {Origin: Vector3, Direction: Vector3}
    assert(pixel.X >= 0 and pixel.X <= self.Resolution.X, "Pixel X value out of bounds.")
    assert(pixel.Y >= 0 and pixel.Y <= self.Resolution.Y, "Pixel Y value out of bounds.")
    
    local nearPlaneCFrame = self:GetNearPlaneCFrame()
    local nearPlaneSize = self:GetNearPlaneSize()
    local farPlaneCFrame = self:GetFarPlaneCFrame()
    local farPlaneSize = self:GetFarPlaneSize()

    -- Calculate the pixel's position on the near clip plane.
    local nearPixel = Vector3.new(
        pixel.X / self.Resolution.X * self:GetNearPlaneSize().X - nearPlaneSize.X / 2,
        (1 - pixel.Y / self.Resolution.Y) * self:GetNearPlaneSize().Y - nearPlaneSize.Y / 2,
        0
    )
    local absoluteNear = nearPlaneCFrame.Position + nearPlaneCFrame:VectorToWorldSpace(nearPixel)

    -- Calculate the pixel's position on the far clip plane.
    local farPixel = Vector3.new(
        pixel.X / self.Resolution.X * self:GetFarPlaneSize().X - farPlaneSize.X / 2,
        (1 - pixel.Y / self.Resolution.Y) * self:GetFarPlaneSize().Y - farPlaneSize.Y / 2,
        0
    )
    local absoluteFar = farPlaneCFrame.Position + farPlaneCFrame:VectorToWorldSpace(farPixel)

    -- Calculate the pixel's direction.
    return absoluteNear, (absoluteFar - absoluteNear).Unit
end


-- Get the unit vector pointing in the direction of a single pixel's ray.
-- Pixel is a Vector2, with maximum values determined by the resolution.
-- Top left pixel is (0, 0), bottom right pixel is (resolution.X - 1, resolution.Y - 1).
-- @param pixel [T:Vector2] The pixel to get the ray for.
-- @return [T:Vector3] The unit vector pointing in the direction of the pixel's ray.
function RayTracingCamera:GetPixelDirection(pixel: Vector2): Vector3
    assert(pixel.X >= 0 and pixel.X <= self.Resolution.X, "Pixel X value out of bounds.")
    assert(pixel.Y >= 0 and pixel.Y <= self.Resolution.Y, "Pixel Y value out of bounds.")
    local _, direction = self:GetRay(pixel)
    return direction
end


return RayTracingCamera