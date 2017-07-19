--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
	
	==================================================
	VMF Generator
	==================================================
	Public alpha 1.1
	
	Supports materials for all brush sides.
	Temporary storage of points for road physics.
	Improvement of internal libraries.
	==================================================
--]]

if !VMFGenerator then VMFGenerator = {} end

VMFGenerator.brushes = {}
VMFGenerator.textures = {}
VMFGenerator.multiconvexphys = {}

include('util.lua')
include('primitives.lua')
include('roads.lua')
include('format.lua')
