local szChungLib = system.GetScriptFolder() .. "\\LIB\\chung.lua"
IncludeFile(szChungLib)

function main()
    -- control.PauseAutoFight()
    while true do
        local attack = false
        local count = 0
        local mana1, mana2 = player.GetMana()

        for i = 0, 255 do
            if player.IsFightMode() == 1 and npc.IsExists(i) and string.len(npc.GetName(i)) > 0 and npc.GetKind(i) ==
                kind_normal and getDistanceNPC(i) < 233 and npc.GetSeries(i) == 2 then
                debugNPC(i)
                echo(i)
                player.Attack(i)
                -- count = count + 1
                timer.Sleep(2500)
            end
        end

        echoGreen("T×m thÊy " .. count .. " NPC")
        -- if count > 1 then
        --     control.ResetAutoFight()
        -- else
        --     control.PauseAutoFight()
        --     player.SendCommand(do_sit)
        -- end
        -- echoGreen("Cßn " .. count .. " b×nh mana")
        timer.Sleep(500)
    end
end
