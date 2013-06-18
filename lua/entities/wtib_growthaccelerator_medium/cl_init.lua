include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	WTib.Render(self)
end

function ENT:WTib_GetTooltip()
	local on = "Off"
	if self:GetOnline() then
		on = "On"
	end
	return self.PrintName.." ("..on..")\nRange : "..tostring(self:GetRange()).."\nEnergy : "..math.Round(tostring(self:GetEnergy()))
end
language.Add(WTib.GetClass(ENT), ENT.PrintName)
