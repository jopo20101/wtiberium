ENT.Type			= "anim"
ENT.Base			= "wtib_tiberium_base"
ENT.PrintName		= "Tiberium Green"
ENT.Author			= "kialtia/WarriorXK"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.Spawnable		= false
ENT.AdminSpawnable	= true
ENT.Category		= "Tiberium"
ENT.IsTiberium		= true

ENT.Damage_Explode_RequiredDamage	= 0
ENT.Damage_ExplosionDelay			= 0
ENT.Damage_Explode_Damage			= 0
ENT.Damage_Explode_Size				= 0
ENT.Damage_Explosive				= false

ENT.Reproduce_TiberiumRequired	= 1000
ENT.Reproduce_TiberiumDrained	= 300
ENT.Reproduce_MaxProduces		= 5
ENT.Reproduce_Delay				= 30

ENT.TiberiumStartAmount	= 400
ENT.MaxTiberiumAmount	= 2000
ENT.TiberiumColor		= Color(0,255,0,0)
ENT.ClassToSpawn		= "wtib_tiberium_green"
ENT.Models =	{
					"models/tiberium/tiberium_crystal1.mdl",
					"models/tiberium/tiberium_crystal3.mdl"
				}

ENT.Growth_Addition	= 30
ENT.Growth_Delay	= 7.5

ENT.DecalSize	= 1
ENT.Decal		= ""

ENT.RenderMode  = RENDERMODE_TRANSALPHA

list.Set("WTib_Tools_Crystals", ENT.PrintName, { wtib_tool_crystals_type = WTib.GetClass(ENT) })
