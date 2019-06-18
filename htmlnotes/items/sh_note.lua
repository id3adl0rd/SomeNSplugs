local PLUGIN = PLUGIN
ITEM.name = "Бумага"
ITEM.desc = "Просто кусок бумаги"
ITEM.model = "models/props_c17/paper01.mdl"
ITEM.category = "Other"

function ITEM:getDesc()
	local str = self.desc
	local canwrite = self:getData("CanWrite")

	if !canwrite then
		str = "Листок бумаги, на котором что-то написано." .. "\nЗаголовок: " .. (self:getData("PaperTitle") or "none")
	else
		str = "Чистый листок бумаги."
	end

	return str
end

ITEM.functions.use =
{
	name = "Написать",
	tip = "useTip",
	icon = "icon16/add.png",
	onRun = function(item)
		local client = item.player

		--PrintTable(nut.item:FindInstance(item.id))

		if !PLUGIN.bureaucracy:bb_CanPlayerEdit(item.id, client) then 
			client:notify("Этот предмет уже кем-то используется!")

			return false
		end

		if item:getData("CanWrite") then
			client.bb_writing_itemid = item.id
			netstream.Start(client, "bb_OpenWriteEditor")
		else
			client.bb_writing_itemid = item.id
			PLUGIN.bureaucracy:bb_SendPaper(item, client)
		end

		return false
	end,
}

function ITEM:onInstanced()
	if !self:getData("CanWrite") then
		self:setData("CanWrite", true)
	end

	if !self:getData("CanPickup") then
		self:setData("CanPickup", true)
	end

	if !self:getData("PaperTitle") then
		self:setData("PaperTitle", "Unnamed")
	end
end