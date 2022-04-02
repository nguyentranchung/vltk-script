szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
---------------------------------------------------------------------------------------
--Khai bao cac bien toan cuc
nHBRequest = 0 -- So luong HB can lay, neu = 0 se lay den khi het
---------------------------------------------------------------------------------------
LayHongBao = function()
	player.PathMoveTo(0, 0, "TÊng qu∂n L‘ ph»m ph≠Íng")
	timer.Sleep(1000)
	while player.GetDoingStatus() ~= 1 do timer.Sleep(100) end	

	if nHBRequest > 0 then
		for i = 1, nHBRequest do
			tbVulanLib.TalkToNpc("TÊng qu∂n L‘ ph»m ph≠Íng", 1)
			menu.ClickIndex(1, 0)
			tbVulanLib.WaitMenu(1);	
			if tbVulanLib.IsMenuTitle(1,"TÊng qu∂n L‘ ph»m ph≠Íng: ThÀt Æ∏ng ti’c") ~= 0 then
				menu.Close()
				system.Print("<color=yellow>ß∑ h’t HÂng Bao!")
				return
			end
			menu.ClickIndex(1, 0)
			timer.Sleep(10)
		end

	else
		while true do
			tbVulanLib.TalkToNpc("TÊng qu∂n L‘ ph»m ph≠Íng", 1)
			menu.ClickIndex(1, 0)
			tbVulanLib.WaitMenu(1);	
			if tbVulanLib.IsMenuTitle(1,"TÊng qu∂n L‘ ph»m ph≠Íng: ThÀt Æ∏ng ti’c") == true then
				system.Print(menu.GetTitle())
				menu.Close()
				system.Print("<color=yellow>ß∑ h’t HÂng Bao!")
				return
			end
			menu.ClickIndex(1, 0)
			timer.Sleep(10)
		end
	end
end
---------------------------------------------------------------------------------------
function main()
	LayHongBao()
	system.Print("<color=yellow>L y HÂng Bao: Hoµn thµnh!")
end
---------------------------------------------------------------------------------------
