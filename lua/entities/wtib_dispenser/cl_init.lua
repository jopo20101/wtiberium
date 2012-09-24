include('shared.lua')
include('menu.lua')

local Color_White = Color(255,255,255,255)
local ScreenVect = Vector(9,-15,24)
local ScreenAng = Angle(0,90,90)

function ENT:Draw()

	self:DrawModel()
	
	cam.Start3D2D(self:LocalToWorld(ScreenVect),self:LocalToWorldAngles(ScreenAng),0.15)
		self:Draw3D2D()
	cam.End3D2D()
	
	WTib.Render(self)
	
end

function ENT:Draw3D2D()

	// Black background
	surface.SetDrawColor(0,0,0,255)
	surface.DrawRect(0,0,90,90)

	// The percentage completed
	local Text = "Idle"
	local CurProj = "None"
	if self.dt.IsBuilding then
	
		Text = "Working, "..self.dt.PercentageComplete.."%"
		CurProj = ""
		
		for k,v in pairs(string.Explode("",WTib.Dispenser.GetObjectByID(self.dt.BuildingID).Name)) do
			CurProj = CurProj .. v
			if (k % 18) == 0 then CurProj = CurProj .. "\n" end
		end
		
	end
	
	draw.DrawText(Text,"Trebuchet18",1,4,Color_White, ALIGN_LEFT)
	draw.DrawText("Current Project :\n" .. CurProj,"Trebuchet18",1,20,Color_White, ALIGN_LEFT)
	
end

function ENT:WTib_GetTooltip()

	local B = self.dt.IsBuilding and "Yes" or "No"
	return self.PrintName.."\nBuilding : "..B.."\nPercentage Complete : "..self.dt.PercentageComplete.."%"
	
end

language.Add(WTib.GetClass(ENT),ENT.PrintName)
