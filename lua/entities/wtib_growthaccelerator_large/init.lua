AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

WTib.ApplyDupeFunctions(ENT)

ENT.MinAccelerationAmount	= 60
ENT.MaxAccelerationAmount	= 70
ENT.AccelerationDelay		= 5
ENT.InfectionChance			= 3
ENT.MaxRange				= 1024
ENT.MinRange				= 10

ENT.EffectOrigin = Vector(0,0,12)
ENT.Scale = 3

function ENT:Initialize()
	self:SetModel("models/Tiberium/large_growth_accelerator.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self.Inputs = WTib.CreateInputs(self,{"On","SetRange"})
	self.Outputs = WTib.CreateOutputs(self,{"Online","Range","MaxRange","Energy"})
	WTib.RegisterEnt(self,"Generator")
	WTib.AddResource(self,"energy",0)
	self:SetRange(self.MaxRange)
	WTib.TriggerOutput(self,"MaxRange",self.MaxRange)
end

function ENT:SpawnFunction(p,t)
	return WTib.SpawnFunction(p,t,self)
end
