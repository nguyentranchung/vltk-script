szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
---------------------------------------------------------------------------------------
nMocNhan = 0 -- So luong Mocnhan can lay
---------------------------------------------------------------------------------------
LayMocNhan = function()
	if nMocNhan > 0 then
		for i =1, nMocNhan do
			tbVulanLib.TalkToNpc("T�ng qu�n Th� luy�n ph��ng",1)
			tbVulanLib.WaitMenu(1);	
			menu.ClickIndex(1, 1)
			tbVulanLib.WaitMenu(1);
			menu.ClickIndex(1, 0)
			timer.Sleep(1)
		end
	else	
		while true do
			tbVulanLib.TalkToNpc("T�ng qu�n Th� luy�n ph��ng",1)
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
	player.PathMoveTo(0, 0, "T�ng qu�n Th� luy�n ph��ng")
	timer.Sleep(1000)
	while player.GetDoingStatus() ~= 1 do timer.Sleep(100) end

	LayMocNhan() 
end
---------------------------------------------------------------------------------------