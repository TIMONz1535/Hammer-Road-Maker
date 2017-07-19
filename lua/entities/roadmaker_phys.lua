AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Type = "anim"

ENT.PhysgunDisabled = true
ENT.DisableDuplicator = true

function ENT:Initialize()
	self:SetModel('models/props_junk/watermelon01.mdl')
	self:SetPos(Vector(0, 0, 0))
	self:SetNoDraw(true)
end

-- Fake syncronization
-- function ENT:CalcAbsolutePosition()
	-- local phys = self:GetPhysicsObject()
	
	-- if IsValid( phys ) then
		-- phys:SetPos( self:GetPos() )
		-- phys:SetAngles(	self:GetAngles() )
		
		-- phys:EnableMotion( false )	-- Turn off prediction
	-- end
-- end

if CLIENT then return end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

function ENT:PhysicsUpdate(phys)
	phys:EnableMotion(false)
end

function ENT:BuildPhysics(meshes)
	self:PhysicsInitMultiConvex(meshes)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:EnableCustomCollisions(true)
	self:MakePhysicsObjectAShadow(false, false)
	
	local phys = self:GetPhysicsObject()
	
	if IsValid(phys) then
		phys:SetMass(50000)
		phys:SetMaterial('concrete')
		phys:EnableMotion(false)
	end
end
