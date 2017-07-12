--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

function VMFGenerator:GetLerpRoad(startpos, midpos, endpos)
	local toend1 = midpos - startpos
	local ang1 = toend1:Angle()
	local right1 = ang1:Right()
	
	local toend2 = endpos - midpos
	local ang2 = toend2:Angle()
	local right2 = ang2:Right()
	
	return LerpVector(0.5, right1, right2)
end

local prevangle = 0

function VMFGenerator:CreateLineRoad(startpos, endpos, width, rightstart, rightend)
	local toend = endpos - startpos
	local ang = toend:Angle()
	local right = ang:Right()
	
	table.insert(self.textures, {ang.y, toend:Length(), ang})
	table.insert(self.textures, {ang.y, toend:Length(), ang})
	
	local rightstart = rightstart or right
	local rightend = rightend or right
	local offset = width/2
	
	local vert1 = startpos + rightstart*offset
	local vert2 = startpos - rightstart*offset
	local vert3 = endpos - rightend*offset
	local vert4 = endpos + rightend*offset
	
	vert1.x = math.Round(vert1.x)
	vert1.y = math.Round(vert1.y)
	vert1.z = math.Round(vert1.z)
	
	vert2.x = math.Round(vert2.x)
	vert2.y = math.Round(vert2.y)
	vert2.z = math.Round(vert2.z)
	
	vert3.x = math.Round(vert3.x)
	vert3.y = math.Round(vert3.y)
	vert3.z = math.Round(vert3.z)
	
	vert4.x = math.Round(vert4.x)
	vert4.y = math.Round(vert4.y)
	vert4.z = math.Round(vert4.z)
	
	if prevangle > ang.y then
		self:CreateConvexBox(vert1, vert2, vert3, vert4)
	else
		self:CreateConvexBox(vert1, vert2, vert3, vert4, true)
	end
	
	prevangle = ang.y
	
	return right
end
