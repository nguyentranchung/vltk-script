 --Script gom vat pham 
---------------------------------------------------------------------------------------
-- Chon noi de gom vat pham va ten vat pham can gom tai day.
-- 3 : Hanh trang;   4 : Ruong;   9 : Ruong 1;	  10 : Ruong 2;     23 : Ruong bang hoi
nBox = 3 			-- Gom vat pham trong hanh trang.	
szItemName = "" 	-- Ten vat pham can gom (szItemName = "" se gom tat ca)
---------------------------------------------------------------------------------------

Chat = function(szChatChannel, szContent)
	local szTemp = ""
	szTemp = "Chat('"..szChatChannel.."', '"..szContent.."')"
	player.ExecuteScript(szTemp)
end

-- Kiem tra 1 item co thuoc black list hay khong
BelongItemBlackList = function(nItemIndex, tbBlackList)
	local nSize = table.maxn(tbBlackList)
	if nSize < 1 then return false end
	for i = 1, nSize do
		if nItemIndex == tbBlackList[i] then return true end
	end
	return false
end

-- Gom vat pham theo ten, va ruong (Neu szItemName = "" thi se gom tat ca cac vat pham)
CollectItem = function()
	local bFlag = false
	local nCollectItemIndex, nCollectX, nCollectY, nCollectNum = 0, 0, 0, 0
	local szCollectItemName = ""				
	local nColectItemFBE = -1 					-- Ngu hanh cua vat pham (FBE : Five Basic Element)
	local nColectItemLevel = 0					-- Cap do cua vat pham
	local nItemCount, nItemMaxCount = 0, 0	
	local tbItemBlackList = {}
	
	local nItemIndex, nPlace, nX, nY = item.GetFirst()
	while nItemIndex ~= 0 do
		if nPlace == nBox then
			if item.GetName(nItemIndex) == szItemName or szItemName == "" then
				nItemCount, nItemMaxCount = item.GetStackCount(nItemIndex)
				if 0 < nItemCount and nItemCount < nItemMaxCount and BelongItemBlackList(nItemIndex, tbItemBlackList) == false then
					nCollectItemIndex, nCollectX, nCollectY, nCollectNum = nItemIndex, nX, nY, item.GetStackCount(nItemIndex)
					nColectItemFBE = item.GetSeries(nItemIndex)
					nColectItemLevel = item.GetLevel(nItemIndex)
					szCollectItemName = item.GetName(nItemIndex)
					table.insert(tbItemBlackList, nItemIndex)
					bFlag = true
				end
				
				if nCollectItemIndex ~= nItemIndex and nCollectItemIndex > 0 and nColectItemFBE == item.GetSeries(nItemIndex) and nColectItemLevel == item.GetLevel(nItemIndex) and szCollectItemName == item.GetName(nItemIndex) then
					nItemCount, nItemMaxCount = item.GetStackCount(nItemIndex)
					if nItemCount + nCollectNum <= nItemMaxCount then
						-- Thuc hien gom vat pham
						while item.IsHold()==0 do
							item.Move(nBox,nX, nY,0,0,0)
							timer.Sleep(10)
						end
						while item.IsHold()==1 do
							item.Move(nBox, nCollectX, nCollectY, nBox, nCollectX, nCollectY)
							timer.Sleep(10)
							nCollectItemIndex = 0 
						end		
						-- Xoa black list
						tbItemBlackList = {}
						bFlag = true						
					end
				end
			end
		end

		if bFlag == false then nItemIndex, nPlace, nX, nY = item.GetNext() 
		else nItemIndex, nPlace, nX, nY = item.GetFirst() bFlag = false end
	end
	Chat("CH_NEARBY","<color=green> §· thùc hiÖn xong !")
end

function main()
	-- Thuc hien viec gom vat pham tren nBox
	CollectItem()  
end