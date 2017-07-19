--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

net.Receive('hrm_updatemeshs', function()
	for key in pairs(RoadMaker.Meshs) do
		RoadMaker.Meshs[key] = {}
	end
	
	VMFGenerator.brushes = {}
	VMFGenerator.textures = {}
	VMFGenerator.multiconvexphys = {}
	
	local width = RoadMaker.Cfgs['width']:GetString()
	local height = RoadMaker.Cfgs['height']:GetString()
	local p = RoadMaker.Points
	for k, pos in ipairs(p) do
		if p[k - 1] and p[k + 2] then
			RoadMaker:CreateLineRoad(pos, p[k + 1], width, height, RoadMaker:GetLerpRoad(p[k - 1], pos, p[k + 1]), RoadMaker:GetLerpRoad(pos, p[k + 1], p[k + 2]))
			VMFGenerator:CreateLineRoad(pos, p[k + 1], width, height, VMFGenerator:GetLerpRoad(p[k - 1], pos, p[k + 1]), VMFGenerator:GetLerpRoad(pos, p[k + 1], p[k + 2]))
		elseif p[k - 1] and p[k + 1] then
			RoadMaker:CreateLineRoad(pos, p[k + 1], width, height, RoadMaker:GetLerpRoad(p[k - 1], pos, p[k + 1]))
			VMFGenerator:CreateLineRoad(pos, p[k + 1], width, height, VMFGenerator:GetLerpRoad(p[k - 1], pos, p[k + 1]))
		elseif p[k + 1] and p[k + 2] then
			RoadMaker:CreateLineRoad(pos, p[k + 1], width, height, nil, RoadMaker:GetLerpRoad(pos, p[k + 1], p[k + 2]))
			VMFGenerator:CreateLineRoad(pos, p[k + 1], width, height, nil, VMFGenerator:GetLerpRoad(pos, p[k + 1], p[k + 2]))
		elseif p[k + 1] then
			RoadMaker:CreateLineRoad(pos, p[k + 1], width, height)
			VMFGenerator:CreateLineRoad(pos, p[k + 1], width, height)
		end
	end
	
	RoadMaker:UpdateMesh('top')
	RoadMaker:UpdateMesh('side')
	RoadMaker:UpdateMesh('bottom')
	RoadMaker:UpdateMesh('nodraw')
end)

net.Receive('hrm_updatepoint', function()
	local key = net.ReadUInt(12)
	local vec = net.ReadVector()
	RoadMaker:UpdatePoint(key, vec)
end)

net.Receive('hrm_initpoints', function()
	RoadMaker.Points = {}
	
	local count = net.ReadUInt(12)
	for i = 1, count do
		local vec = net.ReadVector()
		table.insert(self.Points, vec)
	end
end)

net.Receive('hrm_clearpoints', function()
	RoadMaker.Points = {}
end)

net.Receive('hrm_updatematerial', function()
	local key = net.ReadString()
	RoadMaker:UpdateMaterial(key)
end)

net.Receive('hrm_init', function()
	local count = net.ReadUInt(5)
	for i = 1, count do
		local key = net.ReadString()
		RoadMaker:CreateMaterial(key)
	end
	
	count = net.ReadUInt(5)
	for i = 1, count do
		local key = net.ReadString()
		RoadMaker:CreateCfg(key)
	end
	print('Hammer Road Maker: Initialized')
end)
