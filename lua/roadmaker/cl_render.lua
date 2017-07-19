--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

RoadMaker.Materials['_wireframe'] = Material('models/wireframe')

-- For debug
-- concommand.Add("test", function()
	-- RoadMaker:CreateConvexHBox(Vector(100,0,0), Vector(0,0,0), Vector(0,100,0), Vector(100,100,50), 64, false, 'top', 'nodraw', 'side', 'nodraw', 'side', 'bottom', 'nodraw')
	-- RoadMaker:CreateConvexHBox(Vector(100,100,50), Vector(0,100,0), Vector(100,300,0), Vector(200,300,0), 64, true, 'top', 'nodraw', 'side', 'nodraw', 'side', 'bottom', 'nodraw')

	-- RoadMaker:UpdateMesh('top')
	-- RoadMaker:UpdateMesh('side')
	-- RoadMaker:UpdateMesh('bottom')
	-- RoadMaker:UpdateMesh('nodraw')
-- end)

hook.Add('PreDrawOpaqueRenderables', 'RoadMakerRender', function()
	local materials = RoadMaker.Materials
	local wireframe = materials['_wireframe']
	
	for key, meshobj in pairs(RoadMaker.MeshObjs) do
		render.SetMaterial(materials[key])
		meshobj:Draw()
		render.SetMaterial(wireframe)
		meshobj:Draw()
	end
	
	for k, pos in ipairs(RoadMaker.Points) do
		debugoverlay.Cross(pos, 10, 0.01, Color(255, 0, 0), true)
	end
end)