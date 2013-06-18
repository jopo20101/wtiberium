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
	return self.PrintName.." ("..on..")\nEnergy : "..math.Round(tostring(self:GetEnergy())).."\nRaw Tiberium : "..math.Round(tostring(self:GetRawTiberium()))
end
language.Add(WTib.GetClass(ENT), ENT.PrintName)
