-- Thu vien cac ham thuong dung, giup cho viec viet cac Script tro nen gon gang hon
---------------------------------------------------------------------------------------
gl_ShowMoveToInfo = 0	--0: Khong hien thong bao ham MoveTo, 1: Hien thong bao
tbVulanLib = {}
---------------------------------------------------------------------------------------
tbVulanLib.Chat = function(szChatChannel, szContent)
	local szTemp = ""
	szTemp = "Chat('"..szChatChannel.."', '"..szContent.."')"
	player.ExecuteScript(szTemp)
end
---------------------------------------------------------------------------------------
tbVulanLib.GetRoomType = function(nPlace)	
	if nPlace == 3  then return 0 end	-- Hanh trang
	if nPlace == 4  then return 1 end	-- Ruong 1
	if nPlace == 5  then return 2 end	-- Trade Box 
	if nPlace == 7  then return 3 end	-- SHORTCUT 
	if nPlace == 9  then return 7 end	-- Ruong 2
	if nPlace == 10 then return 8 end	-- Ruong 3
	if nPlace == 12 then return 9 end	-- QUEST BOX
	if nPlace == 13 then return 10 end	-- LUYEN HUYEN TINH BOX
	if nPlace == 16 then return 11 end	-- Hut thuoc tinh trang bi Box
	if nPlace == 23 then return 14 end	-- Ruong bang hoi
end
---------------------------------------------------------------------------------------
--------------CAC HAM LIEN QUAN TOI NPC------------------------------------------------
---------------------------------------------------------------------------------------
tbVulanLib.GetNpcIndexByName = function(szNpcName)
	for i = 2, 255 do
		if npc.GetKind(i) == 3 then
			if npc.GetName(i) == szNpcName then return npc.GetIndex(i) end
		end
	end
	return 0
end
---------------------------------------------------------------------------------------
tbVulanLib.TalkToNpc = function(szNpcName)
	for i = 0, 255 do
		if npc.GetName(i) == szNpcName then
			player.SetPeopleIndex(i) 
			--timer.Sleep(100)
			if szNpcName == "Chñ TiÒn trang" then
				while dialog.IsVisible() == 0 do  timer.Sleep(10) end
			end
			return true
		end
	end
	system.Print("<color=yellow>Kh«ng t×m thÊy: "..szNpcName)
	return false
end
---------------------------------------------------------------------------------------
-- Hµm di chuyÓn ®Õn to¹ ®é. NÕu sau 20s mµ ch­a ®Õn vÞ trÝ th× sÏ tr¶ vÒ gi¸ trÞ 0, ng­îc l¹i sÏ lµ 1
tbVulanLib.MoveTo = function(nDestX, nDestY)
	local nPlayerX, nPlayerY = player.GetMapPos()
	local nBeginTime = os.clock() 
	local nCurMapID = map.GetID()
	local dZ = (nDestX - nPlayerX) * (nDestX - nPlayerX) +( nDestY - nPlayerY) * (nDestY - nPlayerY)
	while dZ > 22500 do
		player.MoveTo(nDestX, nDestY)
		if os.clock() - nBeginTime > 20 then 
			if gl_ShowMoveToInfo ~= 0 then system.Print(nDestX..","..nDestY.."   ->TimeOut!") end
			return 0 
		end
		nPlayerX, nPlayerY = player.GetMapPos()
		dZ = (nDestX - nPlayerX) * (nDestX - nPlayerX) +( nDestY - nPlayerY) * (nDestY - nPlayerY)
		timer.Sleep(100)
		if nCurMapID ~= map.GetID() then return 1 end
	end
	if gl_ShowMoveToInfo ~= 0 then system.Print(nDestX..","..nDestY.."   ->Oke") end
	return 1
end
---------------------------------------------------------------------------------------
--------------CAC HAM LIEN QUAN TOI MENU-----------------------------------------------
---------------------------------------------------------------------------------------
tbVulanLib.WaitMenu = function(nType)
	while menu.IsVisible(nType) == 0 do timer.Sleep(10) end
end
---------------------------------------------------------------------------------------
-- Cho menu, neu sau nSecond khong xuat hien se ket thuc
tbVulanLib.WaitMenuTimeOut = function(nType,nSecond)
	nFirstTime = os.clock()
	while menu.IsVisible(nType) == 0 do 
		timer.Sleep(10) 
		if (os.clock() - nFirstTime ) > nSecond then return 0 end
	end
	return 1
end
---------------------------------------------------------------------------------------
tbVulanLib.IsMenuTitle = function(nType,szSubText)
	if  system.MatchString(menu.GetTitle(nType),szSubText) ~= 0 then return true end
	return false
end
---------------------------------------------------------------------------------------
--------------CAC HAM LIEN QUAN TOI ITEM-----------------------------------------------
---------------------------------------------------------------------------------------
-- Ham dem so vat pham theo ten
--nPlace = Noi chua mon do
tbVulanLib.CountItem = function(nPlaceID,szItemName)
local nCount = 0
local nStackItemNum = 0
	for i = 0, 255 do
		local nItemIndex, nPlace, nX, nY = item.GetPos(i)
		if nItemIndex ~= 0 then
			if nPlace == nPlaceID and item.GetName(nItemIndex) == szItemName then
				nStackItemNum = item.GetStackCount(nItemIndex)
				if nStackItemNum < 2 then nStackItemNum = 1 end
				nCount = nCount + nStackItemNum
			end
		end
	end
	return nCount
end
----------------------------------------------------------------------------------------
tbVulanLib.MoveItem = function(nStartBox,nDestinationBox,szItemName)
	--if nStoreItemPlace  < 1 then return end
	local nRoomType = 0 
	local bRoomExist, nFreeX, nFreeY, nWidth, nHeight = 0, 0, 0, 0, 0
	
	for i = 0, 255 do
		local nItemIndex, nPlace, nX, nY = item.GetPos(i)
		if nPlace == nStartBox and (item.GetName(nItemIndex) == szItemName or szItemName == "")then
			nWidth,nHeight = item.GetSize(nItemIndex)
			nRoomType = tbVulanLib.GetRoomType(nDestinationBox)
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
			end
		end
	end	
end
----------------------------------------------------------------------------------------
tbVulanLib.UseTDP = function()
	if player.IsFightMode() == 0 then 
		tbVulanLib.Chat("CH_NEARBY","<color=green>§ang ë n¬i Phi ChiÕn §Êu, kh«ng thÓ TDP!")
		return
	end

	for i = 0, 255 do
		local nItemIndex, nPlace, nX, nY = item.GetPos(i)
		if nPlace == 3 and item.GetName(nItemIndex)== "Thæ ®Þa phï " then
			item.Use(nItemIndex, nPlace, nX, nY)
			return
		end
	end
	tbVulanLib.Chat("CH_NEARBY","<color=green>§· hÕt TDP!")
end
----------------------------------------------------------------------------------------
-- Dung vat pham theo ten trong Hanhtrang
tbVulanLib.UseItemName = function(szItemName)
	for i = 0, 255 do
		local nItemIndex, nPlace, nX, nY = item.GetPos(i)
		if nPlace == 3 and item.GetName(nItemIndex) == szItemName then
			item.Use(nItemIndex, nPlace, nX, nY)
			return 1
		end
	end
	return 0	
end
----------------------------------------------------------------------------------------
--Dung tat ca cac vat pham co trong Hanhtrang theo ten 
tbVulanLib.UseAllItem = function(szItemName)
	for i = 0, 255 do
		local nItemIndex, nPlace, nX, nY = item.GetPos(i)
		if nPlace == 3 and item.GetName(nItemIndex) == szItemName then
			item.Use(nItemIndex, nPlace, nX, nY)
		end
	end
end
----------------------------------------------------------------------------------------
--Ban tat ca cac vat pham co trong Hanhtrang theo ten
tbVulanLib.SellAllItem = function(szItemName)
	for i = 0, 255 do
		local nItemIndex, nPlace, nX, nY = item.GetPos(i)
		if nPlace == 3 and item.GetName(nItemIndex) == szItemName then
			local rc = 0
			while rc == 0 do 
				rc = shop.Buy(nItemIndex)
				timer.Sleep(10)
			end
		end
	end
end
----------------------------------------------------------------------------------------
