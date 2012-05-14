
WTib = WTib or {}

WTib.DynamicLight = CreateClientConVar("wtib_dynamiclight",1,true,false)
WTib.DynamicLightSize = CreateClientConVar("wtib_dynamiclightsize",1,true,false)

WTib.UseToolTips = CreateClientConVar("wtib_usetooltips",1,true,false)
WTib.ToolTipsRange = CreateClientConVar("wtib_tooltipsrange",512,true,false)
WTib.UseOldToolTips = CreateClientConVar("wtib_useoldtooltips",1,true,false)

function WTib.ToolTipDraw()
	if !WTib.UseToolTips:GetBool() then return end
	local tr = LocalPlayer():GetEyeTrace()
	if tr.Hit and tr.Entity and tr.Entity.WTib_GetTooltip and EyePos():Distance(tr.Entity:GetPos()) < WTib.ToolTipsRange:GetInt() then
		
		local p = tr.HitPos
		if WTib.UseOldToolTips:GetBool() then
			p = tr.Entity:GetPos()
		end
		
		local tip = ""
		local status, err = pcall(function() tip = tr.Entity:WTib_GetTooltip() end)
		if !status then tip = err end
		
		AddWorldTip(tr.Entity:EntIndex(),tip,0.5,p,self)
	end
end
hook.Add("HUDPaint","WTib.ToolTipDraw",WTib.ToolTipDraw)

function WTib.RemovePanelControls(panel)
	// Bleg, don't like it
	panel.btnClose:SetVisible(false)
	panel.btnMaxim:SetVisible(false)
	panel.btnMinim:SetVisible(false)
end

function WTib.AddClientMenu()
	spawnmenu.AddToolCategory("Options","WTiberium Options","WTiberium Options")
	spawnmenu.AddToolMenuOption("Options","WTiberium Options","WTibAdminOptions","Administrative Options","","",WTib.PopulateAdminOptions)
end
hook.Add("AddToolMenuTabs", "WTib.AddClientMenu", WTib.AddClientMenu)

function WTib.PopulateAdminOptions(Panel)
	Panel:ClearControls()

	if LocalPlayer():IsAdmin() then

		Panel:Button("Remove all Tiberium", "wtib_removealltiberium")
		local Sldr = Panel:NumSlider("Max tiberium field size:", "wtib_defaultmaxfieldsize", 10, 300, 0)
			Sldr:SetToolTip("This option specifies how many crystals a field can have, Default : 50")
			PrintTable(Sldr:GetTable())
		
		Panel:NumSlider("Tiberium infection chance:", "wtib_infectionchance", 0, 50, 0):SetToolTip("This option specifies how big the infection by Tiberium chance is, Default : 3")
		
		// Because the sliders set the values to 0 when they load
		timer.Simple(0.1, function()
			RunConsoleCommand("wtib_defaultmaxfieldsize", 50)
			RunConsoleCommand("wtib_infectionchance", 3)
		end)
	else
		Panel:AddControl("Label",{Text="This panel is only available for admins"})
	end
	
end
