szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
---------------------------------------------------------------------------------------
nKNB_Num 	= 2000		-- So luong can rut
----------------------------------------------------------------------------------------
IsNoKnbDialog = function()
	while menu.IsVisible(1) == 0 do 
		if dialog.IsVisible() ~= 0 then return 1 end
		timer.Sleep(10) 
		
	end
	return 0
end
----------------------------------------------------------------------------------------
-- Ham rut TienDong
RutTienDong = function()
	player.PathMoveTo(0,0,"Ch� Ti�n trang")	
	timer.Sleep(1000)
	while player.GetDoingStatus() ~= 1 do timer.Sleep(100) end

	while true do
		if tbVulanLib.CountItem(3,"Ti�n ��ng") >= nKNB_Num then 
			tbVulanLib.Chat("CH_NEARBY","�� c� �� <color=green> Ti�n ��ng") 
			return 
		end

		tbVulanLib.TalkToNpc("Ch� Ti�n trang")
		if dialog.IsVisible() ~= 0 then dialog.Close() timer.Sleep(100); end
		tbVulanLib.WaitMenu(1);

		if system.MatchString(menu.GetText(1, 0), "Ta mu�n r�t Ti�n ��ng") == 1 then 
			menu.ClickIndex(1, 0) 
			timer.Sleep(100);
			if IsNoKnbDialog() ~= 0 then
				dialog.Close()
				system.Print("<color=yellow>�� h�t <color=green> Ti�n ��ng")
				return
			end
		end


		if system.MatchString(menu.GetText(1, 0), "Ta mu�n l�y ra 20 Ti�n ��ng") == 1 then 
			menu.ClickIndex(1, 0) 
			timer.Sleep(100); 
			tbVulanLib.WaitMenu(1);
		end


		if system.MatchString(menu.GetText(1, 0), "X�c nh�n") == 1 then 
			menu.ClickIndex(1, 0) 
			timer.Sleep(100) 
			tbVulanLib.WaitMenu(1);
		end	

		if system.MatchString(menu.GetText(1, 0), "K�t th�c ��i tho�i") == 1 then 
			menu.ClickIndex(1, 0) 
			timer.Sleep(200) 
		end			
	end
end
----------------------------------------------------------------------------------------
function main()
	RutTienDong ()
end