local RayTracer = require(script.Parent.RayTracer) :: any

export type PostProcessingShader = {
    Function: (RayTracer: RayTracer, any...) -> {
        Color: Color3,
        Depth: number,
        Normal: Color3,
    },
    Attributes: {},
    GetAdjacentPixels: (Pixel: Vector2, Radius: number) -> {
        [number]: Vector2,
    },
    Process: (RayTracer: RayTracer, any...) -> {
        Color: Color3,
        Depth: number,
        Normal: Color3,
    },
}

local PostProcessingShader = {}
PostProcessingShader.__index = PostProcessingShader

function PostProcessingShader.new(Function: (RayTracer: RayTracer, any...) -> {Color: Color3, Depth: number, Normal: Color3}, Attributes: {})
    local self = setmetatable({}, PostProcessingShader)
    self.Function = Function
    self.Attributes = Attributes
    return self
end

-- Helper function to get adjacent pixels for a given pixels with radius.
function PostProcessingShader:GetAdjacentPixels(Pixel: Vector2, Resolution: Vector2, Radius: number)
    local Pixels = {}
    for x = -Radius, Radius do
        for y = -Radius, Radius do
            if x ~= 0 or y ~= 0 then
                -- Check if the pixel is within the bounds of the image.
                local PixelPosition = Vector2.new(Pixel.X + x, Pixel.Y + y)
                if PixelPosition.X > 0 and PixelPosition.X <= Resolution.X and PixelPosition.Y > 0 and PixelPosition.Y <= Resolution.Y then
                    table.insert(Pixels, PixelPosition)
                end
            end
        end
    end
    return Pixels
end

-- Convert a Color3 to a Vector3.
function PostProcessingShader:Color3ToVector3(Color: Color3)
    return Vector3.new(Color.R, Color.G, Color.B)
end

-- Convert a Vector3 to a Color3.
function PostProcessingShader:Vector3ToColor3(Vector: Vector3, Clamp: boolean?)
    if Clamp then
        return Color3.new(math.clamp(Vector.X, 0, 1), math.clamp(Vector.Y, 0, 1), math.clamp(Vector.Z, 0, 1))
    else
        return Color3.new(Vector.X, Vector.Y, Vector.Z)
    end
end

-- Convert a number to a Color3.
function PostProcessingShader:NumberToColor3(Number: number)
    return Color3.new(Number, Number, Number)
end

function PostProcessingShader:Process(RayTracer: RayTracer, ...)
    if not self.Function then return end
    return self.Function(RayTracer, ...)
end

return PostProcessingShader