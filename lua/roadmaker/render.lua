--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

local function MeshRender(meshobj, mat)
	render.SetMaterial(mat)
	meshobj:Draw()
	render.SetMaterial(Material('models/wireframe'))
	meshobj:Draw()
end

hook.Add('PreDrawOpaqueRenderables', 'VMFGenerator', function()
	if RoadMaker.meshtop then MeshRender(RoadMaker.meshtop, RoadMaker.mattop) end
	if RoadMaker.meshside then MeshRender(RoadMaker.meshside, RoadMaker.matside) end
	if RoadMaker.meshbottom then MeshRender(RoadMaker.meshbottom, RoadMaker.matbottom) end
	if RoadMaker.meshnodraw then MeshRender(RoadMaker.meshnodraw, RoadMaker.matnodraw) end

	-- debugoverlay is a fps eater
	local offset = 0
	for k, pos in ipairs(RoadMaker.points) do
		debugoverlay.Cross(pos, 10, 0.01, Color(255, 0, 0), true)
		
		-- k = k*2 - 1
		-- if VMFGenerator.textures[k] then
			-- offset = offset + VMFGenerator.textures[k][2]
			-- debugoverlay.Text(pos, k..' / '..VMFGenerator.textures[k][1]..' / '..offset, 0.01, Color(255, 255, 255), true)
		-- end
	end
end)
