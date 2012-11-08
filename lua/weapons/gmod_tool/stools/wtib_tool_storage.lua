local ToolClass = "wtib_tool_storage"

TOOL.Category		= "WTiberium"
TOOL.Name			= "#tool." .. ToolClass .. ".listname"
TOOL.Command		= nil
TOOL.ConfigName		= ""

TOOL.ClientConVar[ "type" ] = "0"

if ( CLIENT ) then
    language.Add( "tool." .. ToolClass .. ".name", "Storage tank Spawner" )
    language.Add( "tool." .. ToolClass .. ".listname", "Storage tank Spawner" )
    language.Add( "tool." .. ToolClass .. ".desc", "Spawns the selected storage device." )
    language.Add( "tool." .. ToolClass .. ".0", "Primary: Spawn the selected entity" )
end

local ToolOptions_Class = {}
local ToolOptions = {}

local ToolOptionsInc = 0

function WTib_StorageTool_AddStorage(class, name)
	
	ToolOptions[name] = { wtib_tool_storage_type = ToolOptionsInc }
	ToolOptions_Class[ToolOptionsInc] = class
	
	ToolOptionsInc = ToolOptionsInc + 1
	
	return ToolOptionsInc - 1
	
end

function TOOL:LeftClick(tr)
	if !tr.Hit then return false end
	
	local EntType = self:GetClientNumber( "type" )
	local Class = ToolOptions_Class[EntType]

	local ent = WTib.SpawnFunction( self:GetOwner(), tr, Class )
	
	if IsValid(ent) then
		
		undo.Create(Class)
			undo.AddEntity(ent)
			undo.SetPlayer(self:GetOwner())
			undo.SetCustomUndoText("Undone " .. ent.PrintName)
		undo.Finish()
		
		return true
		
	else
		
		return false
		
	end
	
end

function TOOL:RightClick(tr) end

function TOOL.BuildCPanel(CPanel)

	CPanel:AddControl("Header", { Text = "#Tool." .. ToolClass .. ".name", Description = "Select a storage device to spawn" })

	CPanel:AddControl("ComboBox", {Label = "Storage tank type", MenuButton = 0, Options=ToolOptions} )
	
end
