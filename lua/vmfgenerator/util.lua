--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

function VMFGenerator:Mesh(v1, v2, v3, mat)
	return {v1, v2, v3, mat = mat}
end

function VMFGenerator:Side(v1, v2, height, mat)
	local vh = Vector(0, 0, height)
	
	return self:Mesh(v1, v1 - vh, v2, mat)
end

function VMFGenerator:Bottom(v1, v2, v3, height, mat)
	local vh = Vector(0, 0, height)
	
	return self:Mesh(v1 - vh, v3 - vh, v2 - vh, mat)
end
