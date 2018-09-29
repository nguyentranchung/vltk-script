-- File nay duoc dung trong phan Datau mo rong->tab KN/PD

szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
--------------------------
gl_szItemName = "Lång ®Ìn b­¬m b­ím"
--------------------------
Use_Long_Den = function()
	if quest.Datau_Exp() <= 0  then return end

	player.GotoCityByID(1)	-- sang Phuong Tuong
	timer.Sleep(1000)
	player.PathMoveTo(0, 0, "DÞch Quan")
	tbVulanLib.MoveTo(49890,99772)
	tbVulanLib.MoveTo(49323,99204)
	tbVulanLib.MoveTo(48776,98492)
	while player.IsFightMode() == 0 do timer.Sleep(10) end
	
	while quest.Datau_Exp() > 0 do	
		if tbVulanLib.UseItemName(gl_szItemName) == 0 then break end --het vat pham
		timer.Sleep(1000)
		system.Print("CÇn ¨n thªm: "..quest.Datau_Exp())
	end

	tbVulanLib.UseTDP()
	while player.IsFightMode() == 1 do timer.Sleep(10) end

end
--------------------------
function main()

	control.PauseAll()	--tam ngung Vulan
	Use_Long_Den()
	if quest.Datau_Exp() > 0  then system.Print("HÕt vËt phÈm ®Ó ¨n!") end	
	control.ResetAll()	--Tra ve trang thai ban dau cua Vulan
end