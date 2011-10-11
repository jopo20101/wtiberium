AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

WTib.ApplyDupeFunctions(ENT)

function ENT:Initialize()
	self:SetModel("models/Tiberium/tiberium_missile_launcher.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self.Inputs = WTib.CreateInputs(self,{"Fire","Lock","LockDelay","X","Y","Z"})
	self.Outputs = WTib.CreateOutputs(self,{"Can Fire"})
end

function ENT:SpawnFunction(p,t)
	return WTib.SpawnFunction(p,t,13,self)
end

function ENT:Think()
	self.dt.Loaded = ValidEntity(self.Missile)
	local num = 0
	if self.dt.Loaded then num = 1 end
	WTib.TriggerOutput(self,"Can Fire",num)
end

function ENT:Use(ply)
	if WTib.IsValid(ply) then return end
	self:LaunchMissile()
end

function ENT:TriggerInput(name,val)
	if name == "Fire" then
		if tobool(val) then
			self:LaunchMissile()
		end
	elseif name == "Lock" then
		self.Locked = tobool(val)
	elseif name == "LockDelay" then
		self.LockDelay = val
	elseif name == "X" then
		self.CoX = val
	elseif name == "Y" then
		self.CoY = val
	elseif name == "Z" then
		self.CoZ = val
	end
end

function ENT:LaunchMissile()
	if WTib.IsValid(self.Missile) then
		self.Missile:Launch(self.WDSO)
		self.Missile = nil
	end
end

function ENT:Touch(ent)
	if ent.WTib_IsMissile and !self.dt.Loaded and ent:CanBeMounted() then
		ent:LoadToLauncher(self)
		self.Missile = ent
	end
end

function ENT:OnRestore()
	WTib.Restored(self)
end
