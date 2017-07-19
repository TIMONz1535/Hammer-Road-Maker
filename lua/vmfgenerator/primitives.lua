--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

-- function VMFGenerator:CreateWedge(v1, v2, v3, v4, v5, v6, matt, mat1, mat2, mat3, matb)
-- end

-- function VMFGenerator:CreateBox(v1, v2, v3, v4, v5, v6, v7, v8, matt, mat1, mat2, mat3, mat4, matb)
-- end

-- function VMFGenerator:CreateConvexBox(v1, v2, v3, v4, v5, v6, v7, v8, invert, matt, mat1, mat2, mat3, mat4, matb, matn)
-- end

function VMFGenerator:CreateHWedge(v1, v2, v3, height, matt, mat1, mat2, mat3, matb)
	local brush = {}
	
	table.insert(brush, self:Mesh(v1, v2, v3, matt))
	table.insert(brush, self:Side(v1, v2, height, mat1))
	table.insert(brush, self:Side(v2, v3, height, mat2))
	table.insert(brush, self:Side(v3, v1, height, mat3))
	table.insert(brush, self:Bottom(v1, v2, v3, height, matb))
	
	table.insert(self.brushes, brush)
	
	local vh = Vector(0, 0, height)
	
	table.insert(self.multiconvexphys, {v1, v2, v3, v1 - vh, v2 - vh, v3 - vh})
end

-- function VMFGenerator:CreateHBox(v1, v2, v3, v4, height, matt, mat1, mat2, mat3, mat4, matb)
-- end

function VMFGenerator:CreateConvexHBox(v1, v2, v3, v4, height, invert, matt, mat1, mat2, mat3, mat4, matb, matn)
	if invert then
		self:CreateHWedge(v1, v2, v4, height, matt, mat1, matn, mat4, matb)
		self:CreateHWedge(v2, v3, v4, height, matt, mat2, mat3, matn, matb)
	else
		self:CreateHWedge(v1, v2, v3, height, matt, mat1, mat2, matn, matb)
		self:CreateHWedge(v1, v3, v4, height, matt, matn, mat3, mat4, matb)
	end
end
