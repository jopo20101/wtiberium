include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	WTib_Render(self)
end

function ENT:WTib_GetTooltip()
	local On = "Off"
	if self:GetNWBool("Online") then
		On = "On"
	end
	return self.PrintName.." ("..On..")\nTarget Found : "..tostring(self:GetNWBool("HasTarget")).."\nEnergy : "..math.Round(tostring(self:GetNWInt("energy",0)))
end

function ENT:Think()
	if CurTime() >= (self.NextRBUpdate or 0) then
		self.NextRBUpdate = CurTime()+2
		WTib_UpdateRenderBounds(self)
	end
end
language.Add("wtib_radar",ENT.PrintName)