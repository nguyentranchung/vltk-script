szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
--------------------------
gl_AdMess = "Ban do cui, ai mua PM (gw5)(jt)(gw5)(jt)(gw5)"
--------------------------
function main()
	while true do
		tbVulanLib.Chat("CH_WORLD",gl_AdMess )
		timer.Sleep(1000)
		tbVulanLib.Chat("CH_CITY",gl_AdMess )
		--tbVulanLib.Chat("CH_NEARBY",gl_AdMess )
		timer.Sleep(60000)
	end
end