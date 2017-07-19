--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

concommand.Add('roadmaker_getvmf', function()
	local width = RoadMaker.Cfgs['width']:GetString()
	local offset = 0
	local vmf = 'world\n{'
	
	for brk, faces in ipairs(VMFGenerator.brushes) do
		vmf = vmf..'\n\tsolid\n\t{'
		
		for fk, verts in ipairs(faces) do
			local mat = RoadMaker.Cvars[verts.mat]:GetString()
			vmf = vmf..'\n\t\tside\n\t\t{\n\t\t\t"plane" "'
			
			local start = true
			for _, pos in ipairs(verts) do
				if start then
					start = false
					vmf = vmf..'('..pos.x..' '..pos.y..' '..pos.z..')'
				else
					vmf = vmf..' ('..pos.x..' '..pos.y..' '..pos.z..')'
				end
			end
			
			vmf = vmf..'"'
			
			if fk == 1 then
				if brk%2 == 1 then
					offset = offset + VMFGenerator.textures[brk][2]
					
					while offset - width > 0 do
						offset = offset - width
					end
				end
				
				local ang = VMFGenerator.textures[brk][1] - 90
				
				vmf = vmf..'\n\t\t\t"uaxis" "[1 0 0 0] 1"'
				vmf = vmf..'\n\t\t\t"vaxis" "[0 -1 0 '..math.Round(offset)..'] 1"'
				vmf = vmf..'\n\t\t\t"rotation" "'..math.Round(math.NormalizeAngle(ang))..'"'
				vmf = vmf..'\n\t\t\t"material" "'..mat..'"\n\t\t}'
			else
				vmf = vmf..'\n\t\t\t"uaxis" "[1 0 0 0] 1"'
				vmf = vmf..'\n\t\t\t"vaxis" "[0 -1 0 0] 1"'
				vmf = vmf..'\n\t\t\t"material" "'..mat..'"\n\t\t}'
			end
		end
		
		vmf = vmf..'\n\t}'
	end

	vmf = vmf..'\n}'
	file.Write('vmfgenerator.vmf.txt', vmf)
end)
