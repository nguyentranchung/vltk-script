szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
---------------------------------------------------------------------------------------
nMocNhan = 0 -- So luong Mocnhan can lay
---------------------------------------------------------------------------------------
LayMocNhan = function()
	if nMocNhan > 0 then
		for i =1, nMocNhan do
			tbVulanLib.TalkToNpc("TÊng qu∂n Th› luy÷n ph≠Íng",1)
			tbVulanLib.WaitMenu(1);	
			menu.ClickIndex(1, 1)
			tbVulanLib.WaitMenu(1);
			menu.ClickIndex(1, 0)
			timer.Sleep(1)
		end
	else	
		while true do
			tbVulanLib.TalkToNpc("TÊng qu∂n Th› luy÷n ph≠Íng",1)
			tbVulanLib.WaitMenu(1);	
			menu.ClickIndex(1, 1)
			tbVulanLib.WaitMenu(1);
			menu.ClickIndex(1, 0)
			timer.Sleep(1)
		end
	end
end
---------------------------------------------------------------------------------------
function main()
	player.PathMoveTo(0, 0, "TÊng qu∂n Th› luy÷n ph≠Íng")
	timer.Sleep(1000)
	while player.GetDoingStatus() ~= 1 do timer.Sleep(100) end

	LayMocNhan() 
end
---------------------------------------------------------------------------------------