include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	WTib.Render(self)
end

function ENT:WTib_GetTooltip()
	return self.PrintName.."\nWarhead : "..tostring(self:GetWarheadTable().Name)
end

function ENT:Think()
	self:NextThink(CurTime()+1)
	return true
end
language.Add(WTib.GetClass(ENT),ENT.PrintName)
killicon.Add("wtib_missile_projectile","killicons/wtib_missile_killicon",Color( 255, 80, 0, 255 ))
