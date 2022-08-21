local Raytracer = require(script.Parent.Raytracer) :: any

export type PostProcessingShader = {
    Function: (Raytracer: Raytracer, any...) -> {
        Color: Color3,
        Depth: number,
        Normal: Color3,
    },
    Attributes: {},
    GetAdjacentPixels: (Pixel: Vector2, Radius: number) -> {
        [number]: Vector2,
    },
    Process: (Raytracer: Raytracer, any...) -> {
        Color: Color3,
        Depth: number,
        Normal: Color3,
    },
}

local PostProcessingShader = {}
PostProcessingShader.__index = PostProcessingShader

function PostProcessingShader.new(Function: (Raytracer: Raytracer, any...) -> {Color: Color3, Depth: number, Normal: Color3}, Attributes: {})
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

function PostProcessingShader:Process(Raytracer: Raytracer, ...)
    return self.Function(Raytracer, ...)
end

return PostProcessingShader