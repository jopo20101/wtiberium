include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	WTib.Render(self)
end

function ENT:WTib_GetTooltip()
	return self.PrintName.."\nLiquid Tiberium : "..math.Round(tostring(self:GetLiquidTiberiumAmount()))
end
language.Add(WTib.GetClass(ENT), ENT.PrintName)
