--Script lÊy + läc LÖnh bµi

nLenhBai = 0 -- Sè LÖnh Bµi  cÇn lÊy
bLocLenhBai = 1 -- Cã läc LÖnh Bµi kh«ng?

-- Danh s¸ch c¸c item sÏ b¸n shop (Muèn gi÷ l¹i nhiÖm vô nµo th× thªm -- vµo tr­íc nhiÖm vô ®ã)
tbSellListLB = {
	["201"] = "2 Tr­êng MÖnh hoµn", 
	["202"] = "2 Gia Bµo hoµn", 
	["204"] = "2 Cao ThiÓm hoµn", 
	["205"] = "2 Cao Trung hoµn", 
	["207"] = "2 B¨ng Phßng hoµn", 
	["208"] = "2 L«i Phßng hoµn", 
	["209"] = "2 Ho¶ Phßng hoµn", 
	["210"] = "2 §éc Phßng hoµn", 
--	["211"] = "3 HuyÒn ThiÕt Nguyªn Kho¸ng", 
--	["212"] = "2 Khæng T­íc Nguyªn Th¹ch", 
--	["213"] = "3 MËt Ng©n Nguyªn Kho¸ng", 
--	["214"] = "2 Phï Dung Nguyªn Th¹ch", 
	["215"] = "3 Chu Sa Nguyªn Th¹ch", 
	["216"] = "2 Chung Nhò Nguyªn Th¹ch", 
	["217"] = "1 S¸t Thñ Gi¶n (Kim)", 
	["218"] = "1 S¸t Thñ Gi¶n (Méc)", 
	["219"] = "1 S¸t Thñ Gi¶n (Thñy)", 
	["220"] = "1 S¸t Thñ Gi¶n (Ho¶)", 
	["221"] = "1 S¸t Thñ Gi¶n (Thæ)", 
--	["222"] = "5 ph¸o hoa", 
--	["224"] = "1 T©m T©m T­¬ng ¸nh Phï", 
--	["225"] = "1 Thiªn S¬n B¶o Lé", 
--	["226"] = "1 B¸ch Qu¶ Lé", 
--	["227"] = "1 Phóc Duyªn Lé (TiÓu)", 
--	["228"] = "1 Phóc Duyªn Lé (§¹i)", 
	["229"] = "M¹c Cao QuËt", 
	["230"] = "Tr­êng B¹ch S¬n B¾c", 
	["231"] = "Tr­êng B¹ch S¬n Nam", 
	["232"] = "Sa M¹c tÇng 3", 
	["233"] = "Sa M¹c tÇng 2", 
	["234"] = "D­îc V­¬ng §éng TÇng 4", 
	["235"] = "Kho¶ Lang §éng", 
	["236"] = "TiÕn Cóc §éng", 
	["237"] = "C¸n Viªn §éng", 
	["301"] = "TÈu Th¹ch - M¹c Cao QuËt", 
	["302"] = "Phi Sa - M¹c Cao QuËt", 
	["303"] = "M¹c TÆc - M¹c Cao QuËt", 
	["304"] = "Sa §¹o - M¹c Cao QuËt", 
	["305"] = "§ao Tr¶m - Tr­êng B¹ch S¬n B¾c", 
	["306"] = "L¹c Quang - Tr­êng B¹ch S¬n B¾c", 
	["307"] = "Hµn Th­¬ng - Tr­êng B¹ch S¬n B¾c", 
	["308"] = "25 §o¹t Ph¸ch - Tr­êng B¹ch S¬n B¾c", 
	["309"] = "S¶n Vò - Tr­êng B¹ch S¬n Nam", 
	["310"] = "Gi¸ng Chïy - Tr­êng B¹ch S¬n Nam", 
	["311"] = "L·nh §ao - Tr­êng B¹ch S¬n Nam", 
	["312"] = "S­¬ng §ao - Tr­êng B¹ch S¬n Nam", 
	["313"] = "TËt Vò - Sa M¹c 3", 
	["314"] = "TËt Viªm - Sa M¹c 3", 
	["315"] = "TËt Vò - Sa M¹c 3", 
	["316"] = "TËt Phong - Sa M¹c 3", 
	["317"] = "TËt §iÖn - Sa M¹c 3", 
	["318"] = "L­u V©n - Sa M¹c 2", 
	["319"] = "L­u Quang - Sa M¹c 2", 
	["320"] = "L­u Phong - Sa M¹c 2", 
	["321"] = "KÕ Trñy - D­îc V­¬ng §éng tÇng 4", 
	["322"] = "Xuyªn s¬n - D­îc V­¬ng §éng tÇng 4", 
	["323"] = "§ao Kh¸ch - D­îc V­¬ng §éng tÇng 4", 
	["324"] = "H¾c C©n - Kho¶ Lang §éng", 
	["325"] = "Lang Bæng - Kho¶ Lang §éng", 
	["326"] = "¶nh C«n - Kho¶ Lang §éng", 
	["328"] = "§o¹t MÖnh Liªm - TiÕn Cóc §éng", 
	["329"] = "B¸o §èm - TiÕn Cóc §éng", 
	["330"] = "con Voi - C¸n Viªn", 
	["331"] = "Voi Hoµng Hµ - C¸n Viªn §éng", 
	["332"] = "Nh·n KÝnh Xµ - C¸n Viªn §éng"
}


-- Hµm ®èi tho¹i víi NPC cã tªn lµ szNpcName
TalkToNpc = function(szNpcName, nType)
	local nNpcIndex = 0
	repeat
		nNpcIndex = npc.GetNearest(3, 200)
	until npc.GetName(nNpcIndex) == szNpcName
	player.DialogNpc(nNpcIndex)
	while menu.IsVisible(nType) == 0 do  timer.Sleep(10) end
	return 1
end

-- Hµm läc LÖnh Bµi
lqSellItemLB = function()
	local nItemIndex, nPlace, nX, nY = item.GetFirst()
	while nItemIndex ~= 0 do
		if item.GetName(nItemIndex) == "LÖnh bµi " and nPlace == 3 then
			-- KiÓm tra xem item nµy cã thuéc danh s¸ch c¸c LÖnh Bµi sÏ b¸n shop hay kh«ng (§­îc thiÕt lËp ë table tbSellListLB)
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

-- Hµm lÊy + läc LÖnh Bµi
LayLenhBai = function()
	if bLocLenhBai == 1 then
		lqSellItemLB()
	end

	-- NÕu ®· thiÕt lËp sè LÖnh Bµi cÇn lÊy th× sÏ lÊy ®óng sè ®· thiÕt lËp
	if nLenhBai > 0 then
		for i = 1, nLenhBai do
			-- LÊy ®Õn khi nµo ®Çy r­¬ng th× tiÕn hµnh läc
			if player.FindRoom(1, 2, 0) == 0 and bLocLenhBai == 1 then lqSellItemLB() end
			TalkToNpc("Tæng qu¶n Thiªn ý ph­êng", 1)
			menu.ClickIndex(1, 0)
			while menu.IsVisible(1) == 0 do  timer.Sleep(10) end
			menu.ClickIndex(1, 0)
			timer.Sleep(1)
		end
	-- NÕu thiÕt lËp nLenhBai = 0 th× sÏ lÊy ®Õn khi ®Çy hµnh trang hoÆc bang héi hÕt LÖnh Bµi)
	else
		while true do
			-- LÊy ®Õn khi nµo ®Çy r­¬ng th× tiÕn hµnh läc
			if player.FindRoom(1, 2, 0) == 0 and bLocLenhBai == 1 then lqSellItemLB() end
			TalkToNpc("Tæng qu¶n Thiªn ý ph­êng", 1)
			menu.ClickIndex(1, 0)
			while menu.IsVisible(1) == 0 do  timer.Sleep(10) end
			menu.ClickIndex(1, 0)
			timer.Sleep(1)
		end
	end
end

function main()
	-- NÕu ®øng xa NPC "Tæng qu¶n Thiªn ý ph­êng" th× sÏ di chuyÓn tíi
	player.PathMoveTo(0, 0, "Tæng qu¶n Thiªn ý ph­êng")
	timer.Sleep(1000)
	while player.GetDoingStatus() ~= 1 do timer.Sleep(100) end

	LayLenhBai()
	system.Print("Hoan thanh!")
end