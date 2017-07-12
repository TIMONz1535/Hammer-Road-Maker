--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
	
	==================================================
	Hammer Road Maker
	==================================================
	Public alpha version: 1.0
	
	Includes a VMF Generator library.
	I was in a hurry when I made this version.
	Therefore, it may contain a significant amount of shitty coding.
	
	Available primitives of VMF Generator:
		- Convex Box
		- Wedge
		- Box (not exist)
	
	==================================================
--]]

if !RoadMaker then RoadMaker = {} end

RoadMaker.points = {}
RoadMaker.begin = false

concommand.Add('roadmaker_clear', function()
	RoadMaker.points = {}
	RunConsoleCommand('roadmaker_updatemesh')
end)

-- At the moment, we do not need this
-- RoadMaker.meshtop = Mesh()
-- RoadMaker.meshside = Mesh()
-- RoadMaker.meshbottom = Mesh()
-- RoadMaker.meshnodraw = Mesh()

include('vmfgenerator/brush.lua')
include('vmfgenerator/road.lua')
include('vmfgenerator/format.lua')

include('roadmaker/materials.lua')
include('roadmaker/render.lua')
include('roadmaker/visualizer.lua')
