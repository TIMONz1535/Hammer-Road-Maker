--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

if !VMFGenerator then VMFGenerator = {} end

-- For format generator.
VMFGenerator.brushes = {}
VMFGenerator.faces = {}
VMFGenerator.textures = {}

-- For visualization.
VMFGenerator.meshestop = {}
VMFGenerator.meshesside = {}
VMFGenerator.meshesbottom = {}
VMFGenerator.meshesnodraw = {}

-- Currently only for hammer, is not displayed. You can delete.
-- function VMFGenerator:CreateBox(vert1, vert2, vert3, vert4, mat)
	-- local height = Vector(0, 0, GetConVar('roadmaker_height'):GetInt())
	-- table.insert(self.faces, {vert1, vert2, vert3, mat})
	-- self:InsertSideHammer(vert1, vert2, mat)
	-- self:InsertSideHammer(vert2, vert3, mat)
	-- self:InsertSideHammer(vert3, vert4, mat)
	-- self:InsertSideHammer(vert4, vert1, mat)
	-- table.insert(self.faces, {vert3 - height, vert2 - height, vert1 - height, mat})
	-- table.insert(self.brushes, self.faces)
	-- self.faces = {}
-- end

function VMFGenerator:InsertSideMesh(vert1, vert2, ispart, meshes)
	local height = Vector(0, 0, GetConVar('roadmaker_height'):GetInt())
	table.insert(meshes, {vert2, vert1, vert1 - height, ispart = ispart})
	table.insert(meshes, {vert1 - height, vert2 - height, vert2, ispart = !ispart})
end

function VMFGenerator:InsertSideHammer(vert1, vert2, mat)
	local height = Vector(0, 0, GetConVar('roadmaker_height'):GetInt())
	table.insert(self.faces, {vert2, vert1, vert1 - height, mat = mat})
end

function VMFGenerator:CreateWedge(vert1, vert2, vert3, ispart, isrotate)
	local height = Vector(0, 0, GetConVar('roadmaker_height'):GetInt())
	-- HAMMER START
	local mat1 = GetConVar('roadmaker_nodrawtexture'):GetString()
	local mat2 = GetConVar('roadmaker_sidetexture'):GetString()
	local mat3 = mat1
	
	-- Mix up materials.
	if isrotate then
		mat3 = mat2
		mat2 = mat1
	end

	table.insert(self.faces, {vert1, vert2, vert3, mat = GetConVar('roadmaker_toptexture'):GetString()})
	self:InsertSideHammer(vert1, vert2, mat1)
	self:InsertSideHammer(vert2, vert3, mat2)
	self:InsertSideHammer(vert3, vert1, mat3)
	table.insert(self.faces, {vert3 - height, vert2 - height, vert1 - height, mat = GetConVar('roadmaker_bottomtexture'):GetString()})
	table.insert(self.brushes, self.faces)
	self.faces = {}
	-- HAMMER END
	
	local meshes1 = self.meshesnodraw
	local meshes2 = self.meshesside
	local meshes3 = meshes1
	
	-- Mix up materials.
	if isrotate then
		meshes3 = meshes2
		meshes2 = meshes1
	end
	
	table.insert(self.meshestop, {vert1, vert2, vert3, ispart = ispart, isrotate = isrotate})
	self:InsertSideMesh(vert1, vert2, nil, meshes1)
	self:InsertSideMesh(vert2, vert3, nil, meshes2)
	self:InsertSideMesh(vert3, vert1, nil, meshes3)
	table.insert(self.meshesbottom, {vert2 - height, vert1 - height, vert3 - height, ispart = ispart, isrotate = !isrotate})
end

function VMFGenerator:CreateConvexBox(vert1, vert2, vert3, vert4, invert)
	if invert then
		self:CreateWedge(vert1, vert2, vert4, true, true)
		self:CreateWedge(vert3, vert4, vert2, nil, true)
	else
		self:CreateWedge(vert1, vert2, vert3, true)
		self:CreateWedge(vert3, vert4, vert1)
	end
end
