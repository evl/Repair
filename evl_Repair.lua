local addonName, addon = ...
local frame = CreateFrame("Frame", nil, UIParent)

local COLOR_COPPER = "eda55f"
local COLOR_SILVER = "c7c7cf"
local COLOR_GOLD = "ffd700"

local formatMoney = function(value)
	local gold = value / 10000
	local silver = mod(value / 100, 100)
	local copper = mod(value, 100)
	
	if value >= 10000 then
		return format("|cff%s%dg|r |cff%s%ds|r |cff%s%dc|r", COLOR_GOLD, gold, COLOR_SILVER, silver, COLOR_COPPER, copper)
	elseif value >= 100 then
		return format("|cff%s%ds|r |cff%s%dc|r", COLOR_SILVER, silver, COLOR_COPPER, copper)
	else	
		return format("|cff%s%dc|r", COLOR_COPPER, copper)
	end
end

local onEvent = function(self)
  if CanMerchantRepair() then
	  local cost = GetRepairAllCost()
		local money = GetMoney()

		if cost > 0 then
			RepairAllItems(CanGuildBankRepair() and 1 or 0)
			DEFAULT_CHAT_FRAME:AddMessage(string.format("Repair costs: %s", formatMoney(math.min(cost, money))))
		end
	end
end

frame:SetScript("OnEvent", onEvent)

frame:RegisterEvent("MERCHANT_SHOW")