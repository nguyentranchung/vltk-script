--Script l�y + l�c L�nh b�i

nLenhBai = 0 -- S� L�nh B�i  c�n l�y
bLocLenhBai = 1 -- C� l�c L�nh B�i kh�ng?

-- Danh s�ch c�c item s� b�n shop (Mu�n gi� l�i nhi�m v� n�o th� th�m -- v�o tr��c nhi�m v� ��)
tbSellListLB = {
	["201"] = "2 Tr��ng M�nh ho�n", 
	["202"] = "2 Gia B�o ho�n", 
	["204"] = "2 Cao Thi�m ho�n", 
	["205"] = "2 Cao Trung ho�n", 
	["207"] = "2 B�ng Ph�ng ho�n", 
	["208"] = "2 L�i Ph�ng ho�n", 
	["209"] = "2 Ho� Ph�ng ho�n", 
	["210"] = "2 ��c Ph�ng ho�n", 
--	["211"] = "3 Huy�n Thi�t Nguy�n Kho�ng", 
--	["212"] = "2 Kh�ng T��c Nguy�n Th�ch", 
--	["213"] = "3 M�t Ng�n Nguy�n Kho�ng", 
--	["214"] = "2 Ph� Dung Nguy�n Th�ch", 
	["215"] = "3 Chu Sa Nguy�n Th�ch", 
	["216"] = "2 Chung Nh� Nguy�n Th�ch", 
	["217"] = "1 S�t Th� Gi�n (Kim)", 
	["218"] = "1 S�t Th� Gi�n (M�c)", 
	["219"] = "1 S�t Th� Gi�n (Th�y)", 
	["220"] = "1 S�t Th� Gi�n (Ho�)", 
	["221"] = "1 S�t Th� Gi�n (Th�)", 
--	["222"] = "5 ph�o hoa", 
--	["224"] = "1 T�m T�m T��ng �nh Ph�", 
--	["225"] = "1 Thi�n S�n B�o L�", 
--	["226"] = "1 B�ch Qu� L�", 
--	["227"] = "1 Ph�c Duy�n L� (Ti�u)", 
--	["228"] = "1 Ph�c Duy�n L� (��i)", 
	["229"] = "M�c Cao Qu�t", 
	["230"] = "Tr��ng B�ch S�n B�c", 
	["231"] = "Tr��ng B�ch S�n Nam", 
	["232"] = "Sa M�c t�ng 3", 
	["233"] = "Sa M�c t�ng 2", 
	["234"] = "D��c V��ng ��ng T�ng 4", 
	["235"] = "Kho� Lang ��ng", 
	["236"] = "Ti�n C�c ��ng", 
	["237"] = "C�n Vi�n ��ng", 
	["301"] = "T�u Th�ch - M�c Cao Qu�t", 
	["302"] = "Phi Sa - M�c Cao Qu�t", 
	["303"] = "M�c T�c - M�c Cao Qu�t", 
	["304"] = "Sa ��o - M�c Cao Qu�t", 
	["305"] = "�ao Tr�m - Tr��ng B�ch S�n B�c", 
	["306"] = "L�c Quang - Tr��ng B�ch S�n B�c", 
	["307"] = "H�n Th��ng - Tr��ng B�ch S�n B�c", 
	["308"] = "25 �o�t Ph�ch - Tr��ng B�ch S�n B�c", 
	["309"] = "S�n V� - Tr��ng B�ch S�n Nam", 
	["310"] = "Gi�ng Ch�y - Tr��ng B�ch S�n Nam", 
	["311"] = "L�nh �ao - Tr��ng B�ch S�n Nam", 
	["312"] = "S��ng �ao - Tr��ng B�ch S�n Nam", 
	["313"] = "T�t V� - Sa M�c 3", 
	["314"] = "T�t Vi�m - Sa M�c 3", 
	["315"] = "T�t V� - Sa M�c 3", 
	["316"] = "T�t Phong - Sa M�c 3", 
	["317"] = "T�t �i�n - Sa M�c 3", 
	["318"] = "L�u V�n - Sa M�c 2", 
	["319"] = "L�u Quang - Sa M�c 2", 
	["320"] = "L�u Phong - Sa M�c 2", 
	["321"] = "K� Tr�y - D��c V��ng ��ng t�ng 4", 
	["322"] = "Xuy�n s�n - D��c V��ng ��ng t�ng 4", 
	["323"] = "�ao Kh�ch - D��c V��ng ��ng t�ng 4", 
	["324"] = "H�c C�n - Kho� Lang ��ng", 
	["325"] = "Lang B�ng - Kho� Lang ��ng", 
	["326"] = "�nh C�n - Kho� Lang ��ng", 
	["328"] = "�o�t M�nh Li�m - Ti�n C�c ��ng", 
	["329"] = "B�o ��m - Ti�n C�c ��ng", 
	["330"] = "con Voi - C�n Vi�n", 
	["331"] = "Voi Ho�ng H� - C�n Vi�n ��ng", 
	["332"] = "Nh�n K�nh X� - C�n Vi�n ��ng"
}


-- H�m ��i tho�i v�i NPC c� t�n l� szNpcName
TalkToNpc = function(szNpcName, nType)
	local nNpcIndex = 0
	repeat
		nNpcIndex = npc.GetNearest(3, 200)
	until npc.GetName(nNpcIndex) == szNpcName
	player.DialogNpc(nNpcIndex)
	while menu.IsVisible(nType) == 0 do  timer.Sleep(10) end
	return 1
end

-- H�m l�c L�nh B�i
lqSellItemLB = function()
	local nItemIndex, nPlace, nX, nY = item.GetFirst()
	while nItemIndex ~= 0 do
		if item.GetName(nItemIndex) == "L�nh b�i " and nPlace == 3 then
			-- Ki�m tra xem item n�y c� thu�c danh s�ch c�c L�nh B�i s� b�n shop hay kh�ng (���c thi�t l�p � table tbSellListLB)
			for i, v in pairs(tbSellListLB) do
				if item.GetTaskNumber(nItemIndex) == tonumber(i)  then
					local nBuyItem = 0
					while nBuyItem <= 0 do 
						timer.Sleep(100)
						nBuyItem = shop.Buy(nItemIndex)
					end
					break
				end
			end
		end
		nItemIndex, nPlace, nX, nY = item.GetNext()
		--timer.Sleep(10)
	end
end

-- H�m l�y + l�c L�nh B�i
LayLenhBai = function()
	if bLocLenhBai == 1 then
		lqSellItemLB()
	end

	-- N�u �� thi�t l�p s� L�nh B�i c�n l�y th� s� l�y ��ng s� �� thi�t l�p
	if nLenhBai > 0 then
		for i = 1, nLenhBai do
			-- L�y ��n khi n�o ��y r��ng th� ti�n h�nh l�c
			if player.FindRoom(1, 2, 0) == 0 and bLocLenhBai == 1 then lqSellItemLB() end
			TalkToNpc("T�ng qu�n Thi�n � ph��ng", 1)
			menu.ClickIndex(1, 0)
			while menu.IsVisible(1) == 0 do  timer.Sleep(10) end
			menu.ClickIndex(1, 0)
			timer.Sleep(1)
		end
	-- N�u thi�t l�p nLenhBai = 0 th� s� l�y ��n khi ��y h�nh trang ho�c bang h�i h�t L�nh B�i)
	else
		while true do
			-- L�y ��n khi n�o ��y r��ng th� ti�n h�nh l�c
			if player.FindRoom(1, 2, 0) == 0 and bLocLenhBai == 1 then lqSellItemLB() end
			TalkToNpc("T�ng qu�n Thi�n � ph��ng", 1)
			menu.ClickIndex(1, 0)
			while menu.IsVisible(1) == 0 do  timer.Sleep(10) end
			menu.ClickIndex(1, 0)
			timer.Sleep(1)
		end
	end
end

function main()
	-- N�u ��ng xa NPC "T�ng qu�n Thi�n � ph��ng" th� s� di chuy�n t�i
	player.PathMoveTo(0, 0, "T�ng qu�n Thi�n � ph��ng")
	timer.Sleep(1000)
	while player.GetDoingStatus() ~= 1 do timer.Sleep(100) end

	LayLenhBai()
	system.Print("Hoan thanh!")
end