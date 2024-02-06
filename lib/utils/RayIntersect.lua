local intersections = {}

-- Calculate ray intersection of a part based on outer geometry (Ignore empty space in the middle of meshes or UnionOperations, for example)
intersections.GetIntersection = function(Part, Point, Direction, Params)
	-- Validate the arguments passed to the function
	local partType = typeof(Part)
	if partType == "Instance" then
		partType =  Part.ClassName
	end
	assert(typeof(Part) == "Instance" and Part:IsA("BasePart"), "invalid argument #1 to 'GetIntersection' (BasePart expected, got "..partType..")")
	assert(typeof(Point) == "Vector3", "invalid argument #2 to 'GetIntersection' (Vector3 expected, got "..typeof(Point)..")")
	assert(typeof(Direction) == "Vector3", "invalid argument #3 to 'GetIntersection' (Vector3 expected, got "..typeof(Direction)..")")
	if Params then
		assert(typeof(Params) == "RaycastParams" or nil, "invalid argument #4 to 'GetIntersection' (RaycastParams or nil expected, got "..typeof(Params)..")")
	end
	
	-- Make sure RaycastParams are set up correctly
	-- Allow the ray to only hit the given Part (or its descendants, but why would your Part have other Parts parented to it?)
	Params = Params or RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Whitelist
	Params.FilterDescendantsInstances = {Part}
	
	-- Find the end of the intersection by casting another ray from the other side of the part
	local function intersect(point)
		local result = workspace:Raycast(point, -Direction*2, Params)
		if not result then return nil end
		
		if result.Instance == Part then
			return result
		end
	end
	
	-- Calculate the intersection length
	local intersectEnd = intersect(Point + Direction*2)
	if not intersectEnd then return nil end
	local distance = (intersectEnd.Position - Point).magnitude
	
	return intersectEnd, distance
end


-- Calculate ray intersection of a part with complex geometry (Single ray can intersect a part multiple times, more performance-intensive)
intersections.GetComplexIntersection = function(Part, Point, Direction, Params, MinDistance)
	-- Validate the arguments passed to the function
	local partType = typeof(Part)
	if partType == "Instance" then
		partType =  Part.ClassName
	end
	assert(typeof(Part) == "Instance" and Part:IsA("BasePart"), "invalid argument #1 to 'GetComplexIntersection' (BasePart expected, got "..partType..")")
	assert(typeof(Point) == "Vector3", "invalid argument #2 to 'GetComplexIntersection' (Vector3 expected, got "..typeof(Point)..")")
	assert(typeof(Direction) == "Vector3", "invalid argument #3 to 'GetComplexIntersection' (Vector3 expected, got "..typeof(Direction)..")")
	if Params then
		assert(typeof(Params) == "RaycastParams" or nil, "invalid argument #4 to 'GetComplexIntersection' (RaycastParams expected, got "..typeof(Params)..")")
	end
	MinDistance = tonumber(MinDistance) or 0.25	-- Make sure MinDistance is a positive number
	MinDistance = math.abs(MinDistance)
	
	-- Make sure RaycastParams are set up correctly
	-- Allow the ray to only hit the given Part (or its descendants, but why would your Part have other Parts parented to it?)
	Params = Params or RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Whitelist
	Params.FilterDescendantsInstances = {Part}
	
	-- Find all points where the ray enters the part collision mesh
	local function getSurfaces(point, allPoints)
		if not allPoints then
			allPoints = {}
		end
		local result = workspace:Raycast(point+MinDistance*Direction.unit, Direction, Params)
		if result then
			table.insert(allPoints, result.Position)
			return getSurfaces(result.Position, allPoints)
		else
			return allPoints
		end
	end
	
	local intersectionPoints = getSurfaces(Point)
	
	-- Find the end of the intersection by casting another ray from the other side of the segment
	local function intersect(point, depth)
		depth = depth or 0
		local result = workspace:Raycast(point, -Direction*2, Params)
		if not result then return nil end

		if result.Instance == Part then
			return result
		end
	end
	
	local results = {}
	local distance = 0
	
	-- Calculate total intersection distance segment by segment and list all RaycastResults
	for i, point in pairs(intersectionPoints) do
		local segmentResult = intersect(point)
		if not segmentResult then continue end
		
		local lastPoint = intersectionPoints[i-1]
		lastPoint = lastPoint or Point
		
		distance += (segmentResult.Position - lastPoint).magnitude
		table.insert(results, segmentResult)
	end
	local lastPoint = intersectionPoints[#intersectionPoints] or Point
	local lastResult, lastDistance = intersections.GetIntersection(Part, lastPoint, Direction, Params, MinDistance)
	table.insert(results, lastResult)
	distance += lastDistance
	
	return results, distance
end


return intersections
