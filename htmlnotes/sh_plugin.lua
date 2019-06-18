local PLUGIN = PLUGIN
PLUGIN.name = "Notes [HTML]"
PLUGIN.author = ""
PLUGIN.desc = ""

nut.util.includeDir("libs")

function nut.item:FindInstance(itemID)
	return self.instances[tonumber(itemID)]
end