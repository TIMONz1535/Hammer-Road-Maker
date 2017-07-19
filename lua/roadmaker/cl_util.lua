--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

function RoadMaker:Mesh(v1, v2, v3, ispart, isrotate)
	return {v1, v2, v3, ispart = ispart, isrotate = isrotate}
end

function RoadMaker:Side(v1, v2, height, ispart, isrotate)
	local vh = Vector(0, 0, height)
	
	-- return self:Mesh(v2, v1, v1 - vh, ispart, !isrotate)
	-- return self:Mesh(v1, v1 - vh, v2, ispart, !isrotate)
	return self:Mesh(v1 - vh, v2, v1, ispart, !isrotate)
end

function RoadMaker:Side2(v1, v2, height, ispart, isrotate)
	local vh = Vector(0, 0, height)
	
	-- return self:Mesh(v1 - vh, v2 - vh, v2, ispart, isrotate)
	return self:Mesh(v2 - vh, v2, v1 - vh, !ispart, !isrotate)
	-- return self:Mesh(v2, v1 - vh, v2 - vh, !ispart, isrotate)
end

function RoadMaker:Bottom(v1, v2, v3, height, ispart, isrotate)
	local vh = Vector(0, 0, height)
	
	return self:Mesh(v1 - vh, v3 - vh, v2 - vh, ispart, isrotate)
end
