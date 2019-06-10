PLUGIN.name = "Vorti-Howl"
PLUGIN.author = "josephfra"
PLUGIN.desc = "Howling for Vorts!"

resource.AddWorkshop("259824553")

if CLIENT then
	surface.CreateFont("nut_C_Yell", {
		font = mainFont,
		size = 24,
		weight = 1000,
		antialias = true
	})
end

nut.chat.register("howl", {
	font = "nut_C_Yell",
	color = Color(77, 158, 154),
	onChatAdd = function(speaker, listener)
		for _,v in ipairs(player.GetAll()) do
			local vt = v:Team()
			if vt == FACTION_VORT then
				chat.AddText(Color(77, 158, 154), speaker:Name().." howls: "..text)
				surface.PlaySound( "vo/outland_01/intro/ol01_vortcall0"..math.random(1, 4)..".wav" )	
			else
				chat.AddText(Color(77, 158, 154), "A vortigaunt howls")
				surface.PlaySound( "vo/outland_01/intro/ol01_vortcall0"..math.random(1, 4)..".wav" )
			end
		end
	end,
	onCanSay = function(speaker, text)
		if (speaker:Team() != FACTION_VORT) then
			client:notifyLocalized("notAllowed")

			return
		end

		return true
	end,
	prefix = "/howl",
})