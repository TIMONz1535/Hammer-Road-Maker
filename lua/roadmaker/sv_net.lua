--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

util.AddNetworkString('hrm_updatematerial')
util.AddNetworkString('hrm_updatemeshs')
util.AddNetworkString('hrm_updatepoint')
util.AddNetworkString('hrm_initpoints')
util.AddNetworkString('hrm_clearpoints')
util.AddNetworkString('hrm_init')

function RoadMaker.UpdateMaterial(name)
	local key = string.sub(name, 11, -8)
	
	net.Start('hrm_updatematerial')
		net.WriteString(key)
	net.Broadcast()
end

function RoadMaker.UpdateMeshs(key, access)
	VMFGenerator.brushes = {}
	VMFGenerator.textures = {}
	VMFGenerator.multiconvexphys = {}
	
	local width = RoadMaker.Cfgs['width']:GetString()
	local height = RoadMaker.Cfgs['height']:GetString()
	local p = RoadMaker.Points
	for k, pos in ipairs(p) do
		if p[k - 1] and p[k + 2] then
			VMFGenerator:CreateLineRoad(pos, p[k + 1], width, height, VMFGenerator:GetLerpRoad(p[k - 1], pos, p[k + 1]), VMFGenerator:GetLerpRoad(pos, p[k + 1], p[k + 2]))
		elseif p[k - 1] and p[k + 1] then
			VMFGenerator:CreateLineRoad(pos, p[k + 1], width, height, VMFGenerator:GetLerpRoad(p[k - 1], pos, p[k + 1]))
		elseif p[k + 1] and p[k + 2] then
			VMFGenerator:CreateLineRoad(pos, p[k + 1], width, height, nil, VMFGenerator:GetLerpRoad(pos, p[k + 1], p[k + 2]))
		elseif p[k + 1] then
			VMFGenerator:CreateLineRoad(pos, p[k + 1], width, height)
		end
	end
	
	-- PHYSICS
	if RoadMaker.Cfgs['enablephysics']:GetBool() then
		if table.Count(VMFGenerator.multiconvexphys) == 0 then
			for k, ent in ipairs(RoadMaker.Physics) do
				if IsValid(ent) then
					ent:Remove()
					-- print(k, 'Removed full')
				end
			end
		else
			local parts = {}
			local partnum = 1
			for k, v in ipairs(VMFGenerator.multiconvexphys) do
				if math.ceil(k/16) == partnum then
					if !parts[partnum] then parts[partnum] = {} end
					table.insert(parts[partnum], v)
				else
					partnum = partnum + 1
					if !parts[partnum] then parts[partnum] = {} end
					table.insert(parts[partnum], v)
				end
			end
			
			for k, v in ipairs(parts) do
				if !IsValid(RoadMaker.Physics[k]) then
					local ent = ents.Create("roadmaker_phys")
					ent:Spawn()
					RoadMaker.Physics[k] = ent
					-- print(k, 'Spawned')
				end
				
				if access == true and isnumber(key) then
					local num = math.ceil(key*2/16)
					local prevnum = math.ceil((key - 1)*2/16)
					local prevnum2 = math.ceil((key - 2)*2/16)
					local prevnum3 = math.ceil((key + 1)*2/16)
					
					if (k == num or (prevnum3 != num and k == num + 1) or ((prevnum2 != num or prevnum != num) and k == num - 1)) and IsValid(RoadMaker.Physics[k]) then
						RoadMaker.Physics[k]:BuildPhysics(v)
						-- print(k, key, 'Rebuild')
					end
				else
					if (k == partnum or (k == partnum - 1 and #parts[partnum] == 2) or isstring(key)) and IsValid(RoadMaker.Physics[k]) then
						RoadMaker.Physics[k]:BuildPhysics(v)
						-- print(k, key, 'Rebuild')
					end
				end
			end
			
			for k, ent in ipairs(RoadMaker.Physics) do
				if k > partnum then
					if IsValid(ent) then
						ent:Remove()
						-- print(k, 'Removed')
					end
				end
			end
			
			-- print('--------------------')
		end
	else
		for k, ent in ipairs(RoadMaker.Physics) do
			if IsValid(ent) then
				ent:Remove()
				-- print(k, 'Removed full')
			end
		end
	end
	-- PHYSICS
	
	net.Start('hrm_updatemeshs')
	net.Broadcast()
end

function RoadMaker:UpdatePoint(key)
	local vec = self.Points[key] or Vector()
	
	net.Start('hrm_updatepoint')
		net.WriteUInt(key, 12)
		net.WriteVector(vec)
	net.Broadcast()
end

function RoadMaker:InitPoints(ply)
	net.Start('hrm_initpoints')
		net.WriteUInt(#self.Points, 12)
		for _, vec in ipairs(self.Points) do
			net.WriteVector(vec)
		end
	net.Send(ply)
end

hook.Add('PlayerSpawn', 'RoadMakerInit', function(ply)
-- hook.Add('PlayerInitialSpawn', 'RoadMakerInit', function(ply)
	net.Start('hrm_init')
		net.WriteUInt(table.Count(RoadMaker.Cvars), 5)
		for key in pairs(RoadMaker.Cvars) do
			net.WriteString(key)
		end
		
		net.WriteUInt(table.Count(RoadMaker.Cfgs), 5)
		for key in pairs(RoadMaker.Cfgs) do
			net.WriteString(key)
		end
	net.Send(ply)
	
	RoadMaker:InitPoints(ply)
end)
