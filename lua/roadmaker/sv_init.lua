--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

RoadMaker.Physics = {}

include('sv_net.lua')

function RoadMaker:CreateCfg(key, def)
	local name = 'roadmaker_'..key
	local flags = {FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_NOTIFY}
	
	self.Cfgs[key] = CreateConVar(name, def, flags, 'Set '..key..' of the road.')
	cvars.AddChangeCallback(name, self.UpdateMeshs)
end

RoadMaker:CreateCfg('width', 512)
RoadMaker:CreateCfg('height', 64)
RoadMaker:CreateCfg('enablephysics', 0)

function RoadMaker:CreateMaterial(key, def)
	local name = 'roadmaker_'..key..'texture'
	local flags = {FCVAR_ARCHIVE, FCVAR_REPLICATED}
	
	self.Cvars[key] = CreateConVar(name, def, flags, 'Set '..key..' texture of the road.')
	cvars.AddChangeCallback(name, self.UpdateMaterial)
end

RoadMaker:CreateMaterial('top', 'concrete/concretefloor037a')
RoadMaker:CreateMaterial('side', 'concrete/concretewall008a')
RoadMaker:CreateMaterial('bottom', 'tools/toolsnodraw')
RoadMaker:CreateMaterial('nodraw', 'tools/toolsnodraw')
