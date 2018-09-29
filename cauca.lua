szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
------------------------------------------------------------
function clickMenu(nType, nSTT)
	tbVulanLib.WaitMenuTimeOut(nType, 1)
	menu.ClickIndex(nType, nSTT)
end

function main(  )	
	while true do
		system.Print("Chu»n bﬁ Æ∏nh c∏")
		tbVulanLib.Chat("CH_NEARBY","C∏ cæn c©u Æi nµo :U" )
		tbVulanLib.UseItemName("C«n c©u")
		timer.Sleep(8000)
		clickMenu(1, 0)
	end
end

