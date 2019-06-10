PLUGIN.name = "Vortigese"
PLUGIN.author = "Qemist"
PLUGIN.desc = "Vortigese"

nut.util.include("sh_config.lua")

nut.command.add("vortigese", {
	onCanHear = nut.config.get("chatRange", 280),
	onRun = function(speaker, text)
		local vort = {}
		local split = string.Split(text, " ")

		for k, v in pairs(split) do 
			local string = table.Random(nut.config.vortigeseWords)
			table.insert(vort, string)
		end

		local text = (LocalPlayer():Team() == FACTION_VORT) and text or table.concat(vort, " ")

		chat.AddText(Color(114, 175, 237), hook.Run("GetPlayerName", speaker, "ic", text)..": "..text)
	end,
	onCanSay = function(speaker)
		if (speaker:Team() != FACTION_VORT) then
			nut.util.notify("You don't know Vortigese!", speaker)

			return false
		end

		return true
	end,
	prefix = {"/v", "/vortigese"}
})