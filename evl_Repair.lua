local evl_Repair = CreateFrame("Frame", nil, UIParent)

local COLOR_COPPER = "eda55f"
local COLOR_SILVER = "c7c7cf"
local COLOR_GOLD = "ffd700"

function evl_Repair:onEvent()
  if CanMerchantRepair() then
	  local cost = GetRepairAllCost()
		local money = GetMoney()

		if cost > 0 then
			RepairAllItems(CanGuildBankRepair() and 1 or 0)
			DEFAULT_CHAT_FRAME:AddMessage(string.format("Repair costs: %s", self:formatMoney(math.min(cost, money))))
		end
	end
end

function evl_Repair:formatMoney(value)
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

function evl_Repair:new()
	self:SetScript("OnEvent", self.onEvent)
	self:RegisterEvent("MERCHANT_SHOW")
end

evl_Repair:new()