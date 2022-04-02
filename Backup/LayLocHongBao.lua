szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
-----------------------------------------------------------------
nHongBao = 0 -- S�  H�ng Bao c�n l�y
bLocHongBao = 1 -- C� l�c H�ng Bao kh�ng?
-----------------------------------------------------------------
-- Danh s�ch c�c item s� s� d�ng (C� th� th�m ho�c b�t c�c item kh�c)
tbUseItemList  = {
	"Bang H�i th�n m�t h�ng bao",
	"Ph�c Duy�n L� (Trung) ",
	"Ph�c Duy�n L� (Ti�u) ",
	"Thi�n s�n  B�o L� ",
	"B�ch Qu� L� ",
--	"Ti�n Th�o L� ",
	"Ph�c Duy�n L� (��i) "
}

-- Danh s�ch c�c item s� ���c b�n sau khi m� ra (C� th� th�m ho�c b�t c�c item kh�c)
tbSell_ItemList = {
	"Phi Phong",
	"Kim Phong Thanh D��ng Kh�i", -- B�n trang b� Kim Phong
	"Kim Phong K� L�n Huy�t",
	"Kim Phong �o�t H�n Ng�c ��i",
	"Kim Phong Thi�n L� Th�o Th��ng Phi",
	"Kim Phong H�u Ngh� d�n cung",
	"Kim Phong Tr�c Li�n Quang",
	"Kim Phong Lan ��nh Ng�c",
	"Kim Phong ��ng T��c Xu�n Th�m",
	"Kim Phong C�ng C�n Tam Th�n",
	"Thi�n Ho�ng Long Long ��i", -- B�n trang b� Thi�n Ho�ng
	"Thi�n Ho�ng Long B�ch Long T�c",
	"Thi�n Ho�ng Long Ng�c Ti�u Di�u",
	"Thi�n Ho�ng Long Kh�c Thi�n L�",
	"Thi�n Ho�ng Long Ho�ng Kim L�n",
	"Thi�n Ho�ng Long Tr�n Minh Li�n",
	"Thi�n Ho�ng Long B�n Long c�i",
	"Thi�n Ho�ng Long N� Long ��ng",
	"Thi�n Ho�ng Long C�u Hi�n ch�",
--	"��nh Qu�c � Sa Ph�t Qu�n", -- B�n 1 s� trang b� ��nh Qu�c
--	"��nh Qu�c Thanh Sa Tr��ng Sam",
	"��nh Qu�c T� ��ng H� uy�n",
	"��nh Qu�c X�ch Quy�n Nhuy�n Ngoa",
	"��nh Qu�c Ng�n T�m Y�u ��i"
}
-----------------------------------------------------------------
-- H�m l�c H�ng Bao
Open_Sell_Items = function()

	for i, v in pairs(tbUseItemList) do
		tbVulanLib.UseAllItem(v)
	end
	
	for i, k in pairs(tbSell_ItemList) do
		tbVulanLib.SellAllItem(k)
	end
end
-----------------------------------------------------------------

-- H�m l�y + l�c H�ng Bao
LayHongBao = function()
	-- N�u �� thi�t l�p s� H�ng Bao kh�c 0 th� s� l�y ��ng s� �� thi�t l�p
	if nHongBao > 0 then
		for i = 1, nHongBao do
			tbVulanLib.TalkToNpc("T�ng qu�n L� ph�m ph��ng")
			tbVulanLib.WaitMenu(1)
			menu.ClickIndex(1,0)
			while menu.IsVisible(1) == 0 do  timer.Sleep(10) end
			menu.ClickIndex(1,0)
			timer.Sleep(10)
			if math.fmod(i, 10) == 0 and bLocHongBao == 1 then
				Open_Sell_Items ()
			end
		end
	-- N�u thi�t l�p nHongBao = 0 th� s� l�y ��n khi ��y h�nh trang ho�c bang h�i h�t H�ng Bao)
	else
		local nCount = 0
		while true do
			nCount = nCount + 1
			tbVulanLib.TalkToNpc("T�ng qu�n L� ph�m ph��ng")
			tbVulanLib.WaitMenu(1)
			menu.ClickIndex(1,0)
			while menu.IsVisible(1) == 0 do  timer.Sleep(10) end
			if system.MatchString(menu.GetTitle(1),"T�ng qu�n L� ph�m ph��ng: Th�t ��ng ti�c") == 1  then
				menu.ClickIndex(1,0)
				return
			end	

			menu.ClickIndex(1,0)
			timer.Sleep(10)
			if math.fmod(nCount, 10) == 0 and bLocHongBao == 1  then
				Open_Sell_Items ()
			end
		end
	end
end
-----------------------------------------------------------------

function main()
	-- N�u ��ng xa NPC "T�ng qu�n L� ph�m ph��ng" th� s� di chuy�n t�i
	player.PathMoveTo(0, 0, "T�ng qu�n L� ph�m ph��ng")
	timer.Sleep(1000)
	while player.GetDoingStatus() ~= 1 do timer.Sleep(100) end

	LayHongBao() -- L�y + l�c H�ng Bao
	Open_Sell_Items() --Loc them lan nua
	system.Print("�� ho�n th�nh!")
end