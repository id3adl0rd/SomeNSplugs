PLUGIN.name = "NPC Relations"
PLUGIN.author = "D3ADL0RD"
PLUGIN.desc = ":shrug:"

if (SERVER) then
	local cn = {
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
	local rn = {
		"npc_citizen",
		"npc_alyx",
		"npc_vortigaunt",
		"npc_barney"
	}
	
	local neutral = {
		"FACTION_CITIZEN",
		"FACTION_VORTSLAVE"
	}
	
	function PLUGIN:PlayerLoadedChar(client)
		self:UpdateRelations(client)
	end
	
	function PLUGIN:PlayerSpawnedNPC(client, ent)
		for k, v in pairs(player.GetAll()) do
			self:UpdateRelations(v)
		end
	end
	
	function PLUGIN:needmoregold(client)
 		return client:isCombine() or client:Team() == FACTION_ADMIN
	end

	function PLUGIN:UpdateRelations(client)
		local npc = ents.FindByClass("npc_*")
		for _,v in pairs(npc) do
			local gc = v:GetClass():lower()
			if (table.HasValue(cn, gc)) then
				v:AddEntityRelationship(client, (self:needmoregold(client) and D_LI) or D_HT, 99)
			elseif (table.HasValue(rn, gc)) then
				v:AddEntityRelationship(client, (self:needmoregold(client) and D_HT) or D_LI, 99)
			end
			if (table.HasValue(cn, gc) or table.HasValue(rn, gc)) then
				for _2,v2 in ipairs(neutral) do
					v2:AddEntityRelationship(client, D_LI 99)
				end
			end
		end
	end
end
