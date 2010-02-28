include('shared.lua')

ENT.RenderGroup = RENDERGROUP_BOTH
ENT.LightSize = 0
ENT.LastSize = 0

function ENT:Draw()
	local Speed = 0.0001
	if self.LastSize <= 0.2 then
		Speed = 0.0004
	end
	local Size = math.Approach(self.LastSize,0.5+(self:GetCrystalSize()/2),Speed)
	if Size < self.LastSize then
		Size = self.LastSize
	else
		self.LastSize = Size
	end
	self:SetModelScale(Vector(Size,Size,Size))
	self:DrawModel()
end

function ENT:Think()
	self:CreateDLight()
	self:NextThink(CurTime()+1)
	return true
end

function ENT:CreateDLight()
	if (WTib.DynamicLight and !WTib.DynamicLight:GetBool()) or false then return end
	local dlight = DynamicLight(self:EntIndex())
	if dlight then
		self.LightSize = math.Approach(self.LightSize,math.Clamp((((self:GetTiberiumAmount()/self:GetColorDevider()) or 100)+5)*WTib.DynamicLightSize:GetInt(),0,300),2)
		local r,g,b,a = self:GetColor()
		dlight.Pos = self:LocalToWorld(self:OBBCenter())
		dlight.r = r
		dlight.g = g
		dlight.b = b
		dlight.Brightness = 1
		dlight.Size = self.LightSize
		dlight.Decay = self.LightSize*5
		dlight.DieTime = CurTime()+1
	end
end
language.Add(string.Replace(ENT.Folder,"entities/",""),ENT.PrintName)
