--Script Chuyen vat pham
-- Include file chua cac bien cau hinh chuong trinh chinh
---------------------------------------------------------------------------------------
-- Chon noi chuyen di, noi chuyen den va ten vat pham can chuyen tai day
-- 3 : Hanh trang;   4 : Ruong;   9 : Ruong 1;	  10 : Ruong 2;     23 : Ruong bang hoi
nStartBox 		= 3 	-- Noi chuyen di
nDestinationBox = 4 	-- Noi chuyen den
szItemName = "Thæ ®Þa phï "			-- Ten vat pham can chuyen (szItemName = "" se chuyen tat ca)
---------------------------------------------------------------------------------------

Chat = function(szChatChannel, szContent)
	local szTemp = ""
	szTemp = "Chat('"..szChatChannel.."', '"..szContent.."')"
	player.ExecuteScript(szTemp)
end

-- Chuyen nPlace thanh RoomType de su dung cho ham player.FindRoom()
MapToRoomType = function(nPlace)	
	if nPlace == 3  then return 0 end	-- Hanh trang
	if nPlace == 4  then return 1 end	-- Ruong 
	if nPlace == 9  then return 7 end	-- Ruong 1
	if nPlace == 10 then return 8 end	-- Ruong 2
	if nPlace == 23 then return 14 end	-- Ruong bang hoi
end

-- Ham chuyen vat pham
MoveItem = function()
	--if nStoreItemPlace  < 1 then return end
	local nRoomType = 0 
	local bRoomExist, nFreeX, nFreeY, nWidth, nHeight = 0, 0, 0, 0, 0
	local bMoveOk = 0
	
	local nItemIndex,nPlace,nX,nY = item.GetFirst()
	while nItemIndex ~= 0 do
		bMoveOk = 0
		if nPlace == nStartBox and (item.GetName(nItemIndex) == szItemName or szItemName == "")then
			nWidth,nHeight = item.GetSize(nItemIndex)
			nRoomType = MapToRoomType(nDestinationBox)
			bRoomExist, nFreeX, nFreeY = player.FindRoom(nWidth, nHeight, nRoomType)
			if bRoomExist == 1 then
				-- Cam item len tay
				while item.IsHold()==0 do
					item.Move(nStartBox,nX,nY,0,0,0)
					timer.Sleep(10)
				end
				-- Chuyen den noi thiet lap
				while item.IsHold()==1 do
					item.Move(nDestinationBox, nFreeX, nFreeY, nDestinationBox, nFreeX, nFreeY)
					timer.Sleep(10)
				end	
				bMoveOk = 1
			end
		end
		
		if bMoveOk == 0 then nItemIndex, nPlace, nX, nY = item.GetNext()
		else nItemIndex, nPlace, nX, nY = item.GetFirst() end
	end	
	Chat("CH_NEARBY","<color=green> §· thùc hiÖn xong !")
end

function main()
	-- Thuc hien viec chuyen vat pham
	MoveItem()  
end