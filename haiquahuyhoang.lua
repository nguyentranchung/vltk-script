GetNpcIndexByName = function(szNpcName)
	for i = 2, 255 do
		if npc.GetKind(i) == 3 then
			if npc.GetName(i) == szNpcName then return npc.GetIndex(i) end
		end
	end
	return 0
end

function StopTimer()
end

function main()
	while true do
		local nNpcIndex = GetNpcIndexByName("Qu¶ Huy Hoµng")
		if nNpcIndex > 0 then
			player.DialogNpc(nNpcIndex)
		end	
		timer.Sleep(1)
	end

end