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

function SWEP:Initialize()
	if CLIENT then
		self.IsCreator = true
		self.Select = 0
	end
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 0.1)
	self:CallOnClient('PrimaryAttack')
	
	if CLIENT then
		if self.IsCreator then
			local vec = self.Owner:GetEyeTrace().HitPos
			vec.x = math.Round(vec.x/8)*8
			vec.y = math.Round(vec.y/8)*8
			vec.z = math.Round(vec.z/8)*8
			
			table.insert(RoadMaker.points, vec + Vector(0,0,32))
		elseif self.Select != 0 and RoadMaker.points[self.Select] then
			local vec = self.Owner:GetEyeTrace().HitPos
			vec.x = math.Round(vec.x/8)*8
			vec.y = math.Round(vec.y/8)*8
			vec.z = math.Round(vec.z/8)*8
			
			RoadMaker.points[self.Select] = vec + Vector(0,0,32)
		end
		
		RunConsoleCommand('roadmaker_updatemesh')
	end
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + 0.1)
	self:CallOnClient('SecondaryAttack')
	
	if CLIENT then
		self.Select = 0
		
		if self.IsCreator then
			RoadMaker.points[#RoadMaker.points] = nil
			RunConsoleCommand('roadmaker_updatemesh')
			self:EmitSound('buttons/button18.wav')
		else
			local mindist = 500000
			local key = 0
			local trpos = self.Owner:GetEyeTrace().HitPos
			
			for k, pos in ipairs(RoadMaker.points) do
				local dist = trpos:DistToSqr(pos)
				
				if (dist < mindist) then
					mindist = dist
					key = k
				end
			end
			
			if key != 0 then
				self.Select = key
				debugoverlay.Sphere(RoadMaker.points[key], 50, 1, Color(0, 255, 0), true)
				self:EmitSound('buttons/button14.wav')
			end
		end
	end
end

function SWEP:Reload()
	if self.NextReload and self.NextReload > CurTime() then return end
	self.NextReload = CurTime() + 0.5
	
	self:CallOnClient('Reload')
	
	if CLIENT then
		self.IsCreator = !self.IsCreator
		
		if self.IsCreator then
			self.Owner:ChatPrint('Mode: Creator')
		else
			self.Owner:ChatPrint('Mode: Positioner')
		end
	end
end
