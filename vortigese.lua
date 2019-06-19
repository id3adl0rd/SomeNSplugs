PLUGIN.name = "Vortigese"
PLUGIN.author = "Qemist"
PLUGIN.desc = "Vortigese"

vortigeseWords = {"ahglah", "ahhhr", "alla", "allu", "baah", "beh", "bim", "buu", "chaa", "chackt", "churr", "dan", "darr", "dee", "eeya", "ge", "ga", "gaharra",
"gaka", "galih", "gallalam", "gerr", "gog", "gram", "gu", "gunn", "gurrah", "ha", "hallam", "harra", "hen", "hi", "jah", "jurr", "kallah", "keh", "kih",
"kurr", "lalli", "llam", "lih", "ley", "lillmah", "lurh", "mah", "min", "nach", "nahh", "neh", "nohaa", "nuy", "raa", "ruhh", "rum", "saa", "seh", "sennah",
"shaa", "shuu", "surr", "taa", "tan", "tsah", "turr", "uhn", "ula", "vahh", "vech", "veh", "vin", "voo", "vouch", "vurr", "xkah", "xih", "zurr"}

nut.chat.register("vorttrue", {
	color = Color(114, 175, 237),
	onChatAdd = function(speaker, text)
		chat.AddText(Color(114, 175, 237), text)
	end,
	onCanHear = function(speaker, listener)
		local sr = nut.config.get("chatRange", 280)
		local se = ents.FindInSphere(speaker:GetPos(), sr)
		for _,v in ipairs(se) do
			if v:Team == FACTION_VORT then
				return true
			end
		end
	end
})

nut.chat.register("vortfalse", {
	color = Color(114, 175, 237),
	onChatAdd = function(speaker, text)
		local vort = {}
		local split = string.Split(text, " ")

		for k, v in pairs(split) do 
			local string = table.Random(vortigeseWords)
			table.insert(vort, string)
		end

		local text = table.concat(vort, " ")

		chat.AddText(Color(114, 175, 237), text)
	end,
	onCanHear = function(speaker, listener)
		local sr = nut.config.get("chatRange", 280)
		local se = ents.FindInSphere(speaker:GetPos(), sr)
		for _,v in ipairs(se) do
			if v:Team != FACTION_VORT then
				return true
			end
		end
	end
})

nut.command.add("vort", {
	syntax = "<string text>",
	onRun = function(client, arguments)
		local text = table.concat(arguments, " ")
		local vn = client:Name()
		if client:Team() == FACTION_VORT then
			if text:find("%S") then
				for _,v in ipairs(player.GetAll()) do
					local vt = v:Team()
					if vt == FACTION_VORT then
						nut.chat.send(v, "vorttrue", vn.." :"..text)
					else
						nut.chat.send(v, "vortfalse", vn.." :"..text)
					end
				end
			end
		end
	end
})