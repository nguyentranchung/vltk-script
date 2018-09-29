szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
---------------------------------------------------------------------------------------
--Duong di co the chua chuan, nguoi dung co the dieu chinh lai cho phu hop
tbPath = {
			{50637,103736}, -- Xap phu Balang
			{50136,103950},
			{49844,104498},
			{49186,104524},
			{48344,103866},
			{47502,103008},
			{46722,103506},
			{46476,104488},
			{45764,104300},
			{45178,104568},
			{44806,104835},
			{44558,105612},
			{43830,106056},
			{43085,105948},
			{42480,105792},	-- >Vu lang Son

			{50210,101818},	-- index = 16
			{49215,101042},
			{48485,99900},
			{49516,98794},
			{50747,97744},
			{52003,96706},
			{53007,97784},
			{53007,97384}, -->Bach Thuy Dong
			
			{54140,96648},	-- index = 24
			{53752,96308},
			{52842,97630},
			{51853,98682},
			{51267,98746},	--{50921,99188},
			{50537,99688},	--{50003,99794},
			{49606,100804},
			{50042,101540},
			{50626,102228},
			{51242,103000},
			{50901,103798},
			{51374,104590},
			{51120,105530},
			{51622,106222},
			{52311,107026},
			{52774,106542},
			{53297,105756},
			{53297,105356}, -->Phuc Luu dong
			
			{50232,102128},	--index = 41
			{49429,102874},
			{48170,101414},
			{48554,100520},
			{49101,99578},
			{48290,98816},
			{47368,98000},
			{46950,98672},
			{46603,98376},
			{45308,97066},
			{45985,96038},
			{46614,95154},
			{47876,96350},
			{49597,97572},
			{49322,98384}, -- cua vao Vulangson
			{50187,99146},
			{51214,100104},
			{52329,101090},
			{53428,99728},
			{54854,98258},
			{55609,97266},
			{55523,96682},
			{54479,95770},
			{53534,94954},
			{52683,94298},
			{51547,93186},
			{50609,92562},
			{50368,92672},
			{50068,92472}, -- >Dao Hoa Nguyen
			
			{54097,104596}, -- nga 3 DHN
			{53186,104342},
			{52620,103792}, -- cong vao
			{52261,103300},
			{52101,102814},
			{52072,102826}	-- Tiem tap hoa
} 
---------------------------------------------------------------------------------------
gl_TDPReq = 4	--So luong TDP can co trong hanh trang
gl_TDPKeep = 3	-- So luong TDP giu lai hanh trang - con lai cat het vao ruong
gl_SourceBox = 3
gl_DestinationBox = 4			
---------------------------------------------------------------------------------------
BuyTDP = function(nCount)
	tbVulanLib.TalkToNpc("Chñ tiÖm t¹p hãa")
	tbVulanLib.WaitMenu(1);
	menu.ClickIndex(1,0)
	timer.Sleep(100)
	while shop.IsVisible() == 0 do timer.Sleep(10) end
	while tbVulanLib.CountItem(3,"Thæ ®Þa phï ") < nCount do
		shop.Sell(0)
		timer.Sleep(10)
	end
	shop.Close()
end
---------------------------------------------------------------------------------------
BaLang_To_DaoHoaNguyen = function(nIndex)
	local nSize = table.maxn(tbPath)
	local i = 1
	if nIndex == 1 then i= 41 end
	if nIndex == 2 then i= 24 end
	if nIndex == 3 then i= 16 end
	
	while i < nSize do
		while player.IsRideHorse() == 0 and item.GetEquipmentIndex(10) ~= 0 do player.ExecuteScript("Switch([[horse]])") timer.Sleep(500) end
		local bOke = tbVulanLib.MoveTo(tbPath[i][1],tbPath[i][2])
		if bOke == 0 then i = i - 1  --TimeOut->quay lui
		else i = i + 1 end
		if i == 0 then return end
	end
end
---------------------------------------------------------------------------------------
ReturnCityByTDP = function()
	tbVulanLib.MoveTo(52261,103300)
	tbVulanLib.MoveTo(52620,103792) -- cong vao
	tbVulanLib.MoveTo(53186,104342)
	tbVulanLib.UseTDP()
end
---------------------------------------------------------------------------------------
CheckStartMap = function()
	player.PathMoveTo(0,0,"Xa phu")
	while player.IsMoving() ~= 0 do timer.Sleep(100) end
	tbVulanLib.TalkToNpc("Xa phu")
	tbVulanLib.WaitMenu(0)
	menu.ClickText(0,"Nh÷ng n¬i ®· ®i qua")
	tbVulanLib.WaitMenu(1)

	local szText1 = "Phôc L­u ®éng"
	local szText2 = "B¹ch Thñy ®éng"	
	local szText3 = "Vò L¨ng s¬n"
	
	if menu.GetText(1,0) == szText1 then menu.ClickIndex(1,0) return 1 end
	if menu.GetText(1,1) == szText1 then menu.ClickIndex(1,1)  return 1 end
	if menu.GetText(1,2) == szText1 then menu.ClickIndex(1,2)  return 1 end

	if menu.GetText(1,0) == szText2 then menu.ClickIndex(1,0)  return 2 end
	if menu.GetText(1,1) == szText2 then menu.ClickIndex(1,1)  return 2 end
	if menu.GetText(1,2) == szText2 then menu.ClickIndex(1,2)  return 2 end

	if menu.GetText(1,0) == szText3 then menu.ClickIndex(1,0)  return 3 end
	if menu.GetText(1,1) == szText3 then menu.ClickIndex(1,1)  return 3 end
	if menu.GetText(1,2) == szText3 then menu.ClickIndex(1,2)  return 3 end

	menu.Close(1);
	return 0

end
---------------------------------------------------------------------------------------
function main()
	gl_ShowMoveToInfo = 1
	control.PauseAll()	--Dung moi dieu khien cua auto
	
	local nIndex = CheckStartMap()
	if nIndex == 0 then	player.GotoCityByID(53) end	--Den Ba Lang huyen
	while player.GetName() == "" do timer.Sleep(100) end -- cho chuyen map
	BaLang_To_DaoHoaNguyen(nIndex)
	BuyTDP (gl_TDPReq)
	ReturnCityByTDP ()
	-------------------
	timer.Sleep(1000)
	box.Open()
	while box.IsVisible() == 0 do timer.Sleep(10) end
	tbVulanLib.MoveItem(gl_SourceBox,gl_DestinationBox,"Thæ ®Þa phï ")
	box.Close()
	------------------
	system.Print("Hoan thanh!")
end
---------------------------------------------------------------------------------------
