PLUGIN.name = "NPC Relations"
PLUGIN.author = "D3ADL0RD"
PLUGIN.desc = ":shrug:"

if (SERVER) then
	local combineNPCClass = {
		"npc_metropolice",
		"npc_strider",
		"npc_combine_s",
		"npc_helicopter",
		"npc_manhack",
		"npc_rollermine",
		"npc_clawscanner",
		"npc_turret_ceiling",
		"npc_combinedropship",
		"npc_stalker",
		"npc_combinegunship",
		"npc_combine_camera",
		"npc_turret_floor",
		"npc_cscanner",
		"npc_turret_ground"
	}
	local rebelNPCClass = {
		"npc_citizen",
		"npc_alyx",
		"npc_vortigaunt",
		"npc_barney"
	}
	
	function PLUGIN:needmoregold(client)
		local isc = client:IsCombine()
		local t = client:Team()
		if isc then
			return true
		elseif t == FACTION_ADMIN then
			return true
		end

		return false
	end

	function PLUGIN:PlayerLoadedChar(client)
		self:UpdateRelations(client)
	end
	
	function PLUGIN:PlayerSpawnedNPC(client, ent)
		for k, v in pairs(player.GetAll()) do
			self:UpdateRelations(v)
		end
	end
	
	function PLUGIN:UpdateRelations(client)
		for k, v in pairs( ents.FindByClass( "npc_*" ) ) do
			if (table.HasValue(combineNPCClass, v:GetClass():lower())) then
				v:AddEntityRelationship(client, (client:needmoregold() and D_LI) or D_HT)
			elseif (table.HasValue(rebelNPCClass, v:GetClass():lower())) then
				v:AddEntityRelationship(client, (client:needmoregold() and D_HT) or D_LI)
			end
		end
	end
end