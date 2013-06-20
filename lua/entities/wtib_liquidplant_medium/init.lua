AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

WTib.ApplyDupeFunctions(ENT)

ENT.NextLiquid = 0

function ENT:Initialize()

	self:SetModel("models/tiberium/chemical_plant.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	
	self.Inputs = WTib.CreateInputs(self,{"On"})
	self.Outputs = WTib.CreateOutputs(self,{"Online","Energy","RawTiberium","LiquidTiberium"})
	
	WTib.RegisterEnt(self,"Generator")
	WTib.AddResource(self,"LiquidTiberium",0)
	WTib.AddResource(self,"RawTiberium",0)
	WTib.AddResource(self,"energy",0)
	
end

function ENT:SpawnFunction(p,t)
	return WTib.SpawnFunction(p,t,self)
end

function ENT:Think()

	local Energy = WTib.GetResourceAmount(self,"energy")
	local RawTiberium = WTib.GetResourceAmount(self,"RawTiberium")
	
	if self.NextLiquid <= CurTime() and self:GetIsOnline() then
	
		local Drain = math.Clamp(RawTiberium,0,150)
		local EDrain = math.ceil(Drain*3)
		
		if Drain > 0 and RawTiberium >= Drain and Energy >= EDrain then
		
			WTib.ConsumeResource(self,"energy",EDrain)
			WTib.ConsumeResource(self,"RawTiberium",Drain)
			WTib.SupplyResource(self,"LiquidTiberium",Drain/10)
			
			Energy = Energy - EDrain
			RawTiberium = RawTiberium - Drain
			
		else
		
			self:TurnOff()
			
		end
		
		self.NextLiquid = CurTime()+1
		
	end
	
	WTib.TriggerOutput(self,"Energy", Energy)
	WTib.TriggerOutput(self,"LiquidTiberium", WTib.GetResourceAmount(self,"LiquidTiberium"))
	WTib.TriggerOutput(self,"RawTiberium", RawTiberium)
	
	self:SetEnergyAmount(Energy)
	self:SetRawTiberiumAmount(RawTiberium)
	
end

function ENT:OnRestore()
	WTib.Restored(self)
end

function ENT:Use(ply)

	if self:GetIsOnline() then
	
		self:TurnOff()
		
	else
	
		self:TurnOn()
		
	end
	
end

function ENT:TurnOn()

	if WTib.GetResourceAmount(self,"energy") <= 1 then return end
	
	if !self:GetIsOnline() then
		self:EmitSound("apc_engine_start")
	end
	
	self:SetIsOnline(true)
	WTib.TriggerOutput(self,"Online",1)
	
end

function ENT:OnRemove()
	self:TurnOff()
end

function ENT:TurnOff()

	self:StopSound("apc_engine_start")
	
	if self:GetIsOnline() then
		self:EmitSound("apc_engine_stop")
	end
	
	self:SetIsOnline(false)
	WTib.TriggerOutput(self,"Online",0)
	
end

function ENT:TriggerInput(name,val)

	if name == "On" then
	
		if val == 0 then
			self:TurnOff()
		else
			self:TurnOn()
		end
		
	end
	
end
