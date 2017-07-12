--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

function RoadMaker:GenerateMesh(meshobj, meshes)
	local meshcount = #meshes
	if meshcount == 0 then return end
	
	-- if meshobj then meshobj:Destroy() end
	-- meshobj = Mesh()

	if self.begin then mesh.End() end
	self.begin = true
	mesh.Begin(meshobj, MATERIAL_TRIANGLES, meshcount)
	for _, verts in ipairs(meshes) do
		local ispart = verts.ispart
		local isrotate = verts.isrotate
		
		for k, pos in ipairs(verts) do
			mesh.Position(pos)
			
			if ispart then
				if isrotate then
					if k == 1 then mesh.TexCoord(0, 1, 0) elseif k == 2 then mesh.TexCoord(0, 0, 0) else mesh.TexCoord(0, 1, -1) end
				else
					if k == 1 then mesh.TexCoord(0, 0, 0) elseif k == 2 then mesh.TexCoord(0, -1, 0) else mesh.TexCoord(0, -1, -1) end
				end
			else
				if isrotate then
					if k == 1 then mesh.TexCoord(0, -1, 0) elseif k == 2 then mesh.TexCoord(0, 0, 0) else mesh.TexCoord(0, -1, 1) end
				else
					if k == 1 then mesh.TexCoord(0, 0, 0) elseif k == 2 then mesh.TexCoord(0, 1, 0) else mesh.TexCoord(0, 1, 1) end
				end
			end
			
			mesh.AdvanceVertex()
		end
	end
	mesh.End()
	self.begin = false
end

concommand.Add('roadmaker_updatemesh', function()
	if !VMFGenerator then ErrorNoHalt('Road Maker does not work without a VMF Generator') end
	
	-- Reset states
	-- COPY PASTE
	RoadMaker.meshtop = Mesh()
	RoadMaker.meshside = Mesh()
	RoadMaker.meshbottom = Mesh()
	RoadMaker.meshnodraw = Mesh()
	
	-- For format generator.
	VMFGenerator.brushes = {}
	VMFGenerator.faces = {}
	VMFGenerator.textures = {}

	-- For visualization.
	VMFGenerator.meshestop = {}
	VMFGenerator.meshesside = {}
	VMFGenerator.meshesbottom = {}
	VMFGenerator.meshesnodraw = {}
	-- COPY PASTE
	
	local width = GetConVar('roadmaker_width'):GetInt()
	local p = RoadMaker.points
	for k, pos in ipairs(p) do
		if p[k - 1] and p[k + 2] then
			VMFGenerator:CreateLineRoad(pos, p[k + 1], width, VMFGenerator:GetLerpRoad(p[k - 1], pos, p[k + 1]), VMFGenerator:GetLerpRoad(pos, p[k + 1], p[k + 2]))
		elseif p[k - 1] and p[k + 1] then
			VMFGenerator:CreateLineRoad(pos, p[k + 1], width, VMFGenerator:GetLerpRoad(p[k - 1], pos, p[k + 1]))
		elseif p[k + 1] and p[k + 2] then
			VMFGenerator:CreateLineRoad(pos, p[k + 1], width, nil, VMFGenerator:GetLerpRoad(pos, p[k + 1], p[k + 2]))
		elseif p[k + 1] then
			VMFGenerator:CreateLineRoad(pos, p[k + 1], width)
		end
	end
	
	-- VMFGenerator:CreateConvexBox(Vector(100,0,0), Vector(0,0,0), Vector(0,100,0), Vector(100,100,50))
	-- VMFGenerator:CreateConvexBox(Vector(100,100,50), Vector(0,100,0), Vector(100,300,0), Vector(200,300,0), true)
	
	RoadMaker:GenerateMesh(RoadMaker.meshtop, VMFGenerator.meshestop)
	RoadMaker:GenerateMesh(RoadMaker.meshside, VMFGenerator.meshesside)
	RoadMaker:GenerateMesh(RoadMaker.meshbottom, VMFGenerator.meshesbottom)
	RoadMaker:GenerateMesh(RoadMaker.meshnodraw, VMFGenerator.meshesnodraw)
end)
