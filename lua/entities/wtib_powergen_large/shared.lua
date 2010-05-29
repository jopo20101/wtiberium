ENT.Type			= "anim"
ENT.Base			= "wtib_powergen_medium"
ENT.PrintName		= "Large Powerplant"
ENT.Author			= "kevkev/Warrior xXx"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.Category		= "Tiberium"

function ENT:SetupDataTables()
	self:DTVar("Int",0,"Boosting")
	self:DTVar("Int",1,"Chemicals")
	self:DTVar("Bool",0,"Online")
end

WTib.Factory.AddObject({
	Name = ENT.PrintName,
	Class = WTib.GetClass(ENT),
	Model = "models/Tiberium/large_tiberium_reactor.mdl",
	PercentDelay = 0.70,
	Information =	{
						ENT.PrintName,
						"\nUses Tiberium chemicals to generate Energy. Can be fueled with Liquid Tiberium for an increased output."
					},
	CreateEnt = function(factory,angles,pos,id)
		local ent = ents.Create(WTib.Factory.GetObjectByID(id).Class)
		ent:SetPos(pos)
		ent:SetAngles(angles)
		ent:Spawn()
		ent:Activate()
		ent:SetModel(WTib.Factory.GetObjectByID(id).Model)
		return ent
	end
})
