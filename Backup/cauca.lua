szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
------------------------------------------------------------
function main(  )	
	while true do
		system.Print("Chu�n b� ��nh c�")
		tbVulanLib.Chat("CH_NEARBY","C� c�n c�u �i n�o :U" )
		tbVulanLib.UseItemName("C�n c�u")
		timer.Sleep(8000)
		clickMenu(0)
	end
end

