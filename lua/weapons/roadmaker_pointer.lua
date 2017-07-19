--[[
	Copyright © 2017 TIMON_Z1535
	http://steamcommunity.com/id/TIMON_Z1535/
--]]

SWEP.PrintName = 'Road Maker Pointer'
SWEP.Category = 'Hammer Road Maker'
SWEP.Instructions = 'R: Change mode\nMouse1: Create or move point to cursor\nMouse2: Remove last or select nearest point'
SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ''
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ''

SWEP.ViewModel = 'models/weapons/v_pistol.mdl'
SWEP.WorldModel = 'models/weapons/w_pistol.mdl'

if CLIENT then return end

function SWEP:Initialize()
	self.IsCreator = true
	self.Select = 0
end

function SWEP:Dirtymake(key, access)
	RoadMaker:UpdatePoint(key)
	RoadMaker.UpdateMeshs(key, access)
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 0.1)
	
	local vec = util.TraceLine({
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector()*10000,
		filter = function(ent) if (ent:GetClass() == "roadmaker_phys") then return false end end
	}).HitPos
	
	if self.IsCreator then
		vec.x = math.Round(vec.x/8)*8
		vec.y = math.Round(vec.y/8)*8
		vec.z = math.Round(vec.z/8)*8
		
		table.insert(RoadMaker.Points, vec + Vector(0,0,32))
		self:Dirtymake(#RoadMaker.Points)
	elseif self.Select != 0 and RoadMaker.Points[self.Select] then
		vec.x = math.Round(vec.x/8)*8
		vec.y = math.Round(vec.y/8)*8
		vec.z = math.Round(vec.z/8)*8
		
		RoadMaker.Points[self.Select] = vec + Vector(0,0,32)
		self:Dirtymake(self.Select, true)
	end
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + 0.1)
	
	self.Select = 0
	
	if self.IsCreator then
		local key = #RoadMaker.Points
		RoadMaker.Points[key] = nil
		self.Owner:EmitSound('buttons/button18.wav')
		self:Dirtymake(key)
	else
		local mindist = 500000
		local key = 0
		local vec = util.TraceLine({
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector()*10000,
			filter = function(ent) if (ent:GetClass() == "roadmaker_phys") then return false end end
		}).HitPos
		
		for k, pos in ipairs(RoadMaker.Points) do
			local dist = vec:DistToSqr(pos)
			
			if (dist < mindist) then
				mindist = dist
				key = k
			end
		end
		
		if key != 0 then
			self.Select = key
			debugoverlay.Sphere(RoadMaker.Points[key], 50, 1, Color(0, 255, 0), true)
			self.Owner:EmitSound('buttons/button14.wav')
		end
	end
end

-- For debug
-- function SWEP:Think()
	-- for k, pos in ipairs(RoadMaker.Points) do
		-- debugoverlay.Cross(pos + Vector(0,0,20), 10, 0.03, Color(0, 255, 255), true)
	-- end
	
	-- for k, v in ipairs(VMFGenerator.multiconvexphys) do
		-- for k2, pos in ipairs(v) do
			-- debugoverlay.Cross(pos, 10, 0.03, Color(0, 255, 0), true)
		-- end
	-- end
-- end

function SWEP:Reload()
	if self.NextReload and self.NextReload > CurTime() then return end
	self.NextReload = CurTime() + 0.5

	self.IsCreator = !self.IsCreator
	
	if self.IsCreator then
		self.Owner:ChatPrint('Mode: Creator')
	else
		self.Owner:ChatPrint('Mode: Positioner')
	end
end
