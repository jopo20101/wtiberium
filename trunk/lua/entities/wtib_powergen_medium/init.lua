AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

WTib.ApplyDupeFunctions(ENT)

util.PrecacheSound("apc_engine_start")
util.PrecacheSound("apc_engine_stop")

ENT.NextSupply = 0

function ENT:Initialize()
	self:SetModel("models/Tiberium/large_tiberium_reactor.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self.Inputs = WTib.CreateInputs(self,{"On","Boost"})
	self.Outputs = WTib.CreateOutputs(self,{"Online","Chemicals","Boosting"})
	WTib.AddResource(self,"ChemicalTiberium",0)
	WTib.AddResource(self,"LiquidTiberium",0)
	WTib.AddResource(self,"energy",0)
	WTib.RegisterEnt(self,"Generator")
end

function ENT:SpawnFunction(p,t)
	return WTib.SpawnFunction(p,t,143,self)
end

function ENT:Think()
	self.dt.Chemicals = WTib.GetResourceAmount(self,"TiberiumChemicals")
	if self.dt.Online and self.NextSupply <= CurTime() then
		if self.dt.Chemicals >= 50 then
			WTib.ConsumeResource("TiberiumChemicals",50)
			WTib.SupplyResource(self,"energy",300)
			if self.dt.Boosting and WTib.GetResourceAmount(self,"LiquidTiberium") >= 10 then
				WTib.SupplyResource(self,"energy",500)
				WTib.ConsumeResource("LiquidTiberium",10)
			end
		else
			self:TurnOff()
		end
		self.NextSupply = CurTime()+1
	end
	self.dt.Chemicals = WTib.GetResourceAmount(self,"TiberiumChemicals")
	WTib.TriggerOutput(self,"Chemicals",self.dt.Chemicals)
	WTib.TriggerOutput(self,"Boosting",tonumber(self.dt.Boosting))
end

function ENT:OnRestore()
	WTib.Restored(self)
end

function ENT:Use(ply)
	if self.dt.Online then
		self:TurnOff()
	else
		self:TurnOn()
	end
end

function ENT:TurnOn()
	if WTib.GetResourceAmount(self,self:GetTypeString()) <= 1 then return end
	if !self.dt.Online then
		self:EmitSound("apc_engine_start")
	end
	self.dt.Online = true
	WTib.TriggerOutput(self,"Online",1)
end

function ENT:OnRemove()
	self:TurnOff()
end

function ENT:TurnOff()
	self:StopSound("apc_engine_start")
	if self.dt.Online then
		self:EmitSound("apc_engine_stop")
	end
	self.dt.Online = false
	WTib.TriggerOutput(self,"Online",0)
end

function ENT:TriggerInput(name,val)
	if name == "On" then
		if val == 0 then
			self:TurnOff()
		else
			self:TurnOn()
		end
	elseif name == "Boost" then
		self.dt.Boosting = tobool(val)
	end
end
