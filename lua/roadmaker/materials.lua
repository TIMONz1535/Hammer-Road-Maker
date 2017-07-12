--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

RoadMaker.mattop = Material('models/wireframe')
RoadMaker.matside = Material('models/wireframe')
RoadMaker.matbottom = Material('models/wireframe')
RoadMaker.matnodraw = Material('models/wireframe')

-- CONVARS START
CreateClientConVar('roadmaker_toptexture', 'concrete/concretefloor037a', true, false, 'Set top texture fow Road Maker. Use roadmaker_getvmf for happines.')
CreateClientConVar('roadmaker_sidetexture', 'concrete/concretewall008a', true, false, 'Set side texture fow Road Maker. Use roadmaker_getvmf for happines.')
CreateClientConVar('roadmaker_bottomtexture', 'tools/toolsnodraw', true, false, 'Set bottom texture fow Road Maker. Use roadmaker_getvmf for happines.')
CreateClientConVar('roadmaker_nodrawtexture', 'tools/toolsnodraw', true, false, 'Set nodraw texture fow Road Maker. Use roadmaker_getvmf for happines.')
CreateClientConVar('roadmaker_height', 64, true, false, 'Set height of road.')
CreateClientConVar('roadmaker_width', 512, true, false, 'Set width of road.')

-- shitty
local order = math.random(1, 100)

cvars.AddChangeCallback('roadmaker_toptexture', function(name, old, new)
	order = order + 1
	RoadMaker.mattop = CreateMaterial('RoadMaker'..order, 'UnlitGeneric', {['$basetexture'] = GetConVar(name):GetString()})
end)
cvars.AddChangeCallback('roadmaker_sidetexture', function(name, old, new)
	order = order + 1
	RoadMaker.matside = CreateMaterial('RoadMaker'..order, 'UnlitGeneric', {['$basetexture'] = GetConVar(name):GetString()})
end)
cvars.AddChangeCallback('roadmaker_bottomtexture', function(name, old, new)
	order = order + 1
	RoadMaker.matbottom = CreateMaterial('RoadMaker'..order, 'UnlitGeneric', {['$basetexture'] = GetConVar(name):GetString()})
end)
cvars.AddChangeCallback('roadmaker_nodrawtexture', function(name, old, new)
	order = order + 1
	RoadMaker.matnodraw = CreateMaterial('RoadMaker'..order, 'UnlitGeneric', {['$basetexture'] = GetConVar(name):GetString()})
end)

hook.Add('InitPostEntity', 'VMFMatUpdate', function()
	RoadMaker.mattop = CreateMaterial('RoadMaker'..order, 'UnlitGeneric', {['$basetexture'] = GetConVar('roadmaker_toptexture'):GetString()})
	order = order + 1
	RoadMaker.matside = CreateMaterial('RoadMaker'..order, 'UnlitGeneric', {['$basetexture'] = GetConVar('roadmaker_sidetexture'):GetString()})
	order = order + 1
	RoadMaker.matbottom = CreateMaterial('RoadMaker'..order, 'UnlitGeneric', {['$basetexture'] = GetConVar('roadmaker_bottomtexture'):GetString()})
	order = order + 1
	RoadMaker.matnodraw = CreateMaterial('RoadMaker'..order, 'UnlitGeneric', {['$basetexture'] = GetConVar('roadmaker_nodrawtexture'):GetString()})
end)
-- CONVARS END
