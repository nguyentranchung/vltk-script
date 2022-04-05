szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
------------------------------------------------------------
function main(  )	
	while true do
		system.Print("Chu»n bﬁ Æ∏nh c∏")
		tbVulanLib.Chat("CH_NEARBY","C∏ mæc l≠Ìi Æi nµo :U" )
		tbVulanLib.UseItemName("L≠Ìi Æ∏nh c∏")
		timer.Sleep(8000)
		clickMenu(0)
	end
end

