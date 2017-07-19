--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

RoadMaker.Meshs = {}

include('cl_util.lua')
include('cl_primitives.lua')
include('cl_roads.lua')

RoadMaker.Materials = {}
RoadMaker.MeshObjs = {}
RoadMaker.begin = false

include('cl_render.lua')

function RoadMaker:CreateCfg(key)
	local name = 'roadmaker_'..key
	local cvar = GetConVar_Internal(name)
	
	self.Cfgs[key] = cvar
end

function RoadMaker:CreateMaterial(key)
	local name = 'roadmaker_'..key..'texture'
	local cvar = GetConVar_Internal(name)
	local texture = cvar:GetString()
	
	self.Cvars[key] = cvar
	self.Materials[key] = CreateMaterial('hrm_'..key, 'UnlitGeneric', {['$basetexture'] = texture})
	self.Meshs[key] = {}
end

function RoadMaker:UpdateMaterial(key)
	local texture = self.Cvars[key]:GetString()
	
	self.Materials[key]:SetTexture('$basetexture', texture)
end

function RoadMaker:UpdatePoint(key, vec)
	if vec == Vector() then
		self.Points[key] = nil
	else
		self.Points[key] = vec
	end
end

function RoadMaker:UpdateMesh(key)
	local meshcount = #self.Meshs[key]
	
	if meshcount == 0 then
		if self.MeshObjs[key] then self.MeshObjs[key]:Destroy() end
		self.MeshObjs[key] = nil
		return
	end
	
	if self.MeshObjs[key] then self.MeshObjs[key]:Destroy() end
	self.MeshObjs[key] = Mesh()
	
	if self.begin then mesh.End() end
	
	self.begin = true
	
	mesh.Begin(self.MeshObjs[key], MATERIAL_TRIANGLES, meshcount)
		for _, verts in ipairs(self.Meshs[key]) do
			local ispart = verts.ispart
			local isrotate = verts.isrotate
			
			for k, v in ipairs(verts) do
				mesh.Position(v)
				
				if ispart then
					if isrotate then
						if k == 1 then mesh.TexCoord(0, -1, 0) elseif k == 2 then mesh.TexCoord(0, -1, -1) else mesh.TexCoord(0, 0, 0) end
					else
						if k == 1 then mesh.TexCoord(0, 0, 1) elseif k == 2 then mesh.TexCoord(0, -1, 1) else mesh.TexCoord(0, 0, 0) end
					end
				else
					if isrotate then
						if k == 1 then mesh.TexCoord(0, 1, 1) elseif k == 2 then mesh.TexCoord(0, 0, 0) else mesh.TexCoord(0, 1, 0) end
					else
						if k == 1 then mesh.TexCoord(0, 0, 0) elseif k == 2 then mesh.TexCoord(0, 0, -1) else mesh.TexCoord(0, 1, -1) end
					end
				end
				
				mesh.AdvanceVertex()
			end
		end
	mesh.End()
	
	self.begin = false
end

include('cl_net.lua')
