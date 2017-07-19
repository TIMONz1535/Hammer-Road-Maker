--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

-- function RoadMaker:CreateWedge(v1, v2, v3, v4, v5, v6, matt, mat1, mat2, mat3, matb)
-- end

-- function RoadMaker:CreateBox(v1, v2, v3, v4, v5, v6, v7, v8, matt, mat1, mat2, mat3, mat4, matb)
-- end

-- function RoadMaker:CreateConvexBox(v1, v2, v3, v4, v5, v6, v7, v8, invert, matt, mat1, mat2, mat3, mat4, matb, matn)
-- end

function RoadMaker:CreateHWedge(v1, v2, v3, height, matt, mat1, mat2, mat3, matb, ispart, isrotate)
	table.insert(self.Meshs[matt], self:Mesh(v1, v2, v3, ispart, isrotate))
	table.insert(self.Meshs[mat1], self:Side(v1, v2, height))
	table.insert(self.Meshs[mat1], self:Side2(v1, v2, height))
	table.insert(self.Meshs[mat2], self:Side(v2, v3, height))
	table.insert(self.Meshs[mat2], self:Side2(v2, v3, height))
	table.insert(self.Meshs[mat3], self:Side(v3, v1, height))
	table.insert(self.Meshs[mat3], self:Side2(v3, v1, height))
	table.insert(self.Meshs[matb], self:Bottom(v1, v2, v3, height, ispart, !isrotate))
end

-- function RoadMaker:CreateHBox(v1, v2, v3, v4, height, matt, mat1, mat2, mat3, mat4, matb)
-- end

function RoadMaker:CreateConvexHBox(v1, v2, v3, v4, height, invert, matt, mat1, mat2, mat3, mat4, matb, matn)
	if invert then
		self:CreateHWedge(v1, v2, v4, height, matt, mat1, matn, mat4, matb, true)
		self:CreateHWedge(v2, v3, v4, height, matt, mat2, mat3, matn, matb)
	else
		self:CreateHWedge(v2, v3, v1, height, matt, mat2, matn, matn, matb, true, true)
		-- self:CreateHWedge(v3, v1, v2, height, matt, mat2, matn, matn, matb, true, true)
		-- self:CreateHWedge(v1, v2, v3, height, matt, mat2, matn, matn, matb, true, true)
		self:CreateHWedge(v1, v3, v4, height, matt, matn, mat3, mat4, matb, nil, true)
	end
end
