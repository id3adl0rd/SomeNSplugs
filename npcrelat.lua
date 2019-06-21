--[[


If it is necessary that the NPC is not aggressive to this fraction, then you need to add a table in the fraction file and prescribe the NPC in it. An example is described below.

FACTION.name = "fCitizenName"
FACTION.desc = "fCitizenDesc"
FACTION.color = Color(25, 180, 30)

FACTION.npcRelations = {
	["npc_metropolice"] = D_NU
}

FACTION_CITIZEN = FACTION.index



--]]



PLUGIN.name = "NPC Relations"
PLUGIN.author = "Gr4ss"
PLUGIN.description = "Allows easy setting of NPC relations."

if (SERVER) then
	function PLUGIN:OnEntityCreated(entity)
		if (entity:IsNPC()) then
			for _, client in pairs(player.GetAll()) do
				local charplayer = client:getChar()

				if (charplayer) then
					local faction = nut.faction.indices[character:getFaction()]

					if (faction and faction.npcRelations) then
						entity:AddEntityRelationship(client, faction.npcRelations[entity:GetClass()] or D_HT, 0)
					end
				end
			end
		end
	end

	function PLUGIN:PlayerSpawn(client)
		local charplayer = client:getChar()

		if (charplayer) then
			local faction = nut.faction.indices[character:getFaction()]
			local relations = faction.npcRelations

			if (relations) then
				for _, entity in pairs(ents.GetAll()) do
					if (entity:IsNPC() and relations[entity:GetClass()]) then
						entity:AddEntityRelationship(client, relations[entity:GetClass()], 0)
					end
				end
			else
				for _, entity in pairs(ents.GetAll()) do
					if (entity:IsNPC()) then
						entity:AddEntityRelationship(client, D_HT, 0)
					end
				end
			end
		end
	end
end

