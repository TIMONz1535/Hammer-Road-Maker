--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
	
	==================================================
	Hammer Road Maker
	==================================================
	Public alpha 1.1
	
	Supports client/server communications.
	Added a dynamic physics model for the road.
	Improvement of internal libraries.
	Includes a VMF Generator library.
	==================================================
--]]

if SERVER then
	AddCSLuaFile('vmfgenerator/init.lua')
	AddCSLuaFile('vmfgenerator/util.lua')
	AddCSLuaFile('vmfgenerator/primitives.lua')
	AddCSLuaFile('vmfgenerator/roads.lua')
	AddCSLuaFile('vmfgenerator/format.lua')
end

include('vmfgenerator/init.lua')

-- And now the Road Maker
if !RoadMaker then RoadMaker = {} end

RoadMaker.Cfgs = {}
RoadMaker.Cvars = {}
RoadMaker.Points = {}

if SERVER then
	AddCSLuaFile('roadmaker/cl_init.lua')
	AddCSLuaFile('roadmaker/cl_util.lua')
	AddCSLuaFile('roadmaker/cl_primitives.lua')
	AddCSLuaFile('roadmaker/cl_roads.lua')
	AddCSLuaFile('roadmaker/cl_render.lua')
	AddCSLuaFile('roadmaker/cl_net.lua')
	include('roadmaker/sv_init.lua')
	
	concommand.Add('roadmaker_clear', function()
		RoadMaker.Points = {}
		
		net.Start('hrm_clearpoints')
		net.Broadcast()
		
		RoadMaker.UpdateMeshs()
	end)
else
	include('roadmaker/cl_init.lua')
end
