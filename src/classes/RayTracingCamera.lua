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
}

local RayTracingCamera = {}
RayTracingCamera.__index = RayTracingCamera

function RayTracingCamera.new(resolution: Vector2, fieldOfView: number, farPlane: number, cFrame: CFrame)
    local self = setmetatable({}, RayTracingCamera)
    self.Resolution = resolution
    self.FieldOfView = fieldOfView
    self.FarPlane = farPlane
    self.CFrame = cFrame
    return self
end

-- Get the unit vector pointing in the direction of a single pixel's ray.
-- Pixel is a Vector2, with maximum values determined by the resolution.
-- Top left pixel is (0, 0), bottom right pixel is (resolution.X - 1, resolution.Y - 1).
-- @param pixel [T:Vector2] The pixel to get the ray for.
-- @return [T:Vector3] The unit vector pointing in the direction of the pixel's ray.
function RayTracingCamera:GetPixelDirection(pixel: Vector2)
    assert(pixel.X >= 0 and pixel.X <= self.Resolution.X, "Pixel X value out of bounds.")
    assert(pixel.Y >= 0 and pixel.Y <= self.Resolution.Y, "Pixel Y value out of bounds.")

    -- Calculate the vertical field of view.
    local horizontalFieldOfView = self.FieldOfView * (self.Resolution.X / self.Resolution.Y)
    
    -- Calculate the pixel's horizontal angle.
    local horizontalAngle = ((pixel.X / self.Resolution.X) * horizontalFieldOfView) - (horizontalFieldOfView / 2)
    -- Calculate the pixel's vertical angle.
    local verticalAngle = ((pixel.Y / self.Resolution.Y) * self.FieldOfView) - (self.FieldOfView / 2)

    -- Calculate the pixel vector.
    local pixelVector = CFrame.Angles(verticalAngle, -horizontalAngle, 0).LookVector
    
    return pixelVector
end

-- Get the initial raycast information for a pixel.
-- @param pixel [T:Vector2] The pixel to get the ray for.
-- @return [T:Ray] The pixel's ray.
function RayTracingCamera:GetInitialRay(pixel: Vector2)
    local pixelVector = self:GetRay(pixel)
    local pixelPosition = self.CFrame.Position + pixelVector * self.NearPlane
    return {
        Origin = pixelPosition,
        Direction = pixelVector*self.FarPlane
    }
end

return RayTracingCamera