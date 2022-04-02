szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
-----------------------------------------------------------------
nHongBao = 0 -- SË  HÂng Bao c«n l y
bLocHongBao = 1 -- C„ l‰c HÂng Bao kh´ng?
-----------------------------------------------------------------
-- Danh s∏ch c∏c item sœ sˆ dÙng (C„ th” th™m ho∆c bÌt c∏c item kh∏c)
tbUseItemList  = {
	"Bang HÈi th«n mÀt hÂng bao",
	"PhÛc Duy™n LÈ (Trung) ",
	"PhÛc Duy™n LÈ (Ti”u) ",
	"Thi™n s¨n  B∂o LÈ ",
	"B∏ch Qu∂ LÈ ",
--	"Ti™n Th∂o LÈ ",
	"PhÛc Duy™n LÈ (ßπi) "
}

-- Danh s∏ch c∏c item sœ Æ≠Óc b∏n sau khi mÎ ra (C„ th” th™m ho∆c bÌt c∏c item kh∏c)
tbSell_ItemList = {
	"Phi Phong",
	"Kim Phong Thanh D≠¨ng Kh´i", -- B∏n trang bﬁ Kim Phong
	"Kim Phong K˙ L©n Huy’t",
	"Kim Phong ßoπt HÂn Ng‰c Æ∏i",
	"Kim Phong Thi™n L˝ Th∂o Th≠Óng Phi",
	"Kim Phong HÀu Ngh÷ d…n cung",
	"Kim Phong Trπc Li™n Quang",
	"Kim Phong Lan ß◊nh Ng‰c",
	"Kim Phong ßÂng T≠Ìc Xu©n Th©m",
	"Kim Phong C´ng C»n Tam Th∏n",
	"Thi™n Hoµng Long Long ßµi", -- B∏n trang bﬁ Thi™n Hoµng
	"Thi™n Hoµng Long Bπch Long T¯c",
	"Thi™n Hoµng Long Ng‰c Ti™u Di™u",
	"Thi™n Hoµng Long KhËc Thi™n L˝",
	"Thi™n Hoµng Long Hoµng Kim L©n",
	"Thi™n Hoµng Long Tr n Minh Li™n",
	"Thi™n Hoµng Long Bµn Long c´i",
	"Thi™n Hoµng Long NÈ Long ßÂng",
	"Thi™n Hoµng Long Cˆu Hi÷n chÿ",
--	"ßﬁnh QuËc § Sa Ph∏t Qu∏n", -- B∏n 1 sË trang bﬁ ßﬁnh QuËc
--	"ßﬁnh QuËc Thanh Sa Tr≠Íng Sam",
	"ßﬁnh QuËc Tˆ ßªng HÈ uy”n",
	"ßﬁnh QuËc X›ch Quy™n Nhuy‘n Ngoa",
	"ßﬁnh QuËc Ng©n Tµm Y™u Æ∏i"
}
-----------------------------------------------------------------
-- Hµm l‰c HÂng Bao
Open_Sell_Items = function()

	for i, v in pairs(tbUseItemList) do
		tbVulanLib.UseAllItem(v)
	end
	
	for i, k in pairs(tbSell_ItemList) do
		tbVulanLib.SellAllItem(k)
	end
end
-----------------------------------------------------------------

-- Hµm l y + l‰c HÂng Bao
LayHongBao = function()
	-- N’u Æ∑ thi’t lÀp sË HÂng Bao kh∏c 0 th◊ sœ l y ÆÛng sË Æ∑ thi’t lÀp
	if nHongBao > 0 then
		for i = 1, nHongBao do
			tbVulanLib.TalkToNpc("TÊng qu∂n L‘ ph»m ph≠Íng")
			tbVulanLib.WaitMenu(1)
			menu.ClickIndex(1,0)
			while menu.IsVisible(1) == 0 do  timer.Sleep(10) end
			menu.ClickIndex(1,0)
			timer.Sleep(10)
			if math.fmod(i, 10) == 0 and bLocHongBao == 1 then
				Open_Sell_Items ()
			end
		end
	-- N’u thi’t lÀp nHongBao = 0 th◊ sœ l y Æ’n khi Æ«y hµnh trang ho∆c bang hÈi h’t HÂng Bao)
	else
		local nCount = 0
		while true do
			nCount = nCount + 1
			tbVulanLib.TalkToNpc("TÊng qu∂n L‘ ph»m ph≠Íng")
			tbVulanLib.WaitMenu(1)
			menu.ClickIndex(1,0)
			while menu.IsVisible(1) == 0 do  timer.Sleep(10) end
			if system.MatchString(menu.GetTitle(1),"TÊng qu∂n L‘ ph»m ph≠Íng: ThÀt Æ∏ng ti’c") == 1  then
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
	-- N’u Æ¯ng xa NPC "TÊng qu∂n L‘ ph»m ph≠Íng" th◊ sœ di chuy”n tÌi
	player.PathMoveTo(0, 0, "TÊng qu∂n L‘ ph»m ph≠Íng")
	timer.Sleep(1000)
	while player.GetDoingStatus() ~= 1 do timer.Sleep(100) end

	LayHongBao() -- L y + l‰c HÂng Bao
	Open_Sell_Items() --Loc them lan nua
	system.Print("ß∑ hoµn thµnh!")
end