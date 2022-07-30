local szChungLib = system.GetScriptFolder() .. "\\LIB\\chung.lua"
IncludeFile(szChungLib)

function main()
    while true do
        for i = 0, 255 do
            if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 and npc.GetKind(i) ==
                kind_normal and getDistanceNPC(i) < 433 and npc.GetSeries(i) == he_moc then
                debugNPC(i)
                player.FollowAttack(i)
                timer.Sleep(1500)
                break
            end
        end
        timer.Sleep(1500)
    end
end
