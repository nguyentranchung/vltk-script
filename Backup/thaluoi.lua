szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
------------------------------------------------------------
function main(  )	
	while true do
		system.Print("Chu�n b� ��nh c�")
		tbVulanLib.Chat("CH_NEARBY","C� m�c l��i �i n�o :U" )
		tbVulanLib.UseItemName("L��i ��nh c�")
		timer.Sleep(8000)
		clickMenu(0)
	end
end

