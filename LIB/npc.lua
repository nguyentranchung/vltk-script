-- kind_normal 0 = quai    
-- kind_player 1 = nguoi choi,
-- kind_partner 2 = ,
-- kind_dialoger,
-- kind_bird,
-- kind_mouse = 5
function checkNPC()
    for i = 0, 255 do
        if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            echo(npc.GetName(i) .. ' kind: ' .. npc.GetKind(i) .. " length: " .. string.len(npc.GetName(i)))
        end
    end
end

function showNPC(nKind)
    for i = 0, 255 do
        if npc.GetKind(i) == nKind and npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            debugNPC(i)
        end
    end
end

function talkNPC(szNPCName)
    local minLength = 999999
    local indexNPC = 2

    for i = 2, 255 do
        local nx, ny = npc.GetMapPos(i)
        if npc.GetKind(i) == 3 and filled(szNPCName) and npc.GetName(i) == szNPCName then
            echo("T×m thÊy " .. szNPCName .. " sÏ nãi chuyÖn trong chèc l¸t")
            echo(nx .. "/" .. ny)
            player.DialogNpc(i)
            hasDialogOrMenu(4)
            echo("Nãi chuyÖn thµnh c«ng!")
            echoLine()
            return true
        end
        if npc.GetKind(i) == 3 and blank(szNPCName) then
            if getDistance(nx, ny) < minLength then
                indexNPC = i
                minLength = getDistance(nx, ny)
            end
        end
    end

    if blank(szNPCName) then
        if gl_Debug then
            echo(minLength)
        end
        if minLength > 1100 then
            echo("Kh«ng nhËp vµo tªn npc, nãi chuyÖn víi ng­êi gÇn nhÊt: " .. npc.GetName(indexNPC))
            player.DialogNpc(indexNPC)
            hasDialogOrMenu(4)
            echo("Nãi chuyÖn thµnh c«ng!")
            echoLine()
            return true
        else
            echoRed("NPC gÇn nhÊt ®øng c¸ch qu¸ xa")
            return false
        end
    end
    echo("Nãi chuyÖn thÊt b¹i!")
    echoLine()
end

function heNPC(nIndex)
    if npc.GetSeries(i) == 0 then
        return " hÖ kim "
    end
    if npc.GetSeries(i) == 1 then
        return " hÖ méc "
    end
    if npc.GetSeries(i) == 2 then
        return " hÖ thñy "
    end
    if npc.GetSeries(i) == 3 then
        return " hÖ háa "
    end
    if npc.GetSeries(i) == 4 then
        return " hÖ thæ "
    end
    return " kh«ng râ "
end

function getDistanceNPC(nIndex)
    local nx, ny = npc.GetMapPos(nIndex)
    return getDistance(nx, ny)
end

function debugNPC(nIndex)
    local text = npc.GetName(nIndex) .. heNPC(nIndex) .. ' Range: ' .. getDistanceNPC(nIndex)

    local nHeal, nHealMax = npc.GetLife(nIndex)

    if nHeal > 0 then
        text = text .. ' M¸u: ' .. nHeal
    end
    echo(text)
    return text
end

function attackNPC(nDistance)
    while true do
        local nNearNPC = 0
        local nNearestNPCIndex = 0
        for i = 0, 255 do
            if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 and npc.GetKind(i) == 0 then
                local nx, ny = npc.GetMapPos(i)
                if getDistance(nx, ny) < nDistance then
                    nNearNPC = nNearNPC + 1
                    nNearestNPCIndex = i
                    -- debugNPC(i)
                end
            end
        end
        -- echo("Sè l­îng NPC: " .. nNearNPC)
        if nNearNPC > 2 then
            player.Attack(nNearestNPCIndex)
        else
            if player.GetDoingStatus() ~= do_sit then
                player.SendCommand(do_sit)
            end
        end
        timer.Sleep(500)
    end
end

function LuyenSkill()
    while true do
        control.ResetAll()
        local attack = false
        local count = 0
        for i = 0, 255 do
            if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 and npc.GetKind(i) == 0 and getDistanceNPC(i) < 300 then
                -- debugNPC(i)
                count = count + 1
            end
        end

        echoGreen("T×m thÊy " .. count .. " NPC")
        count = 0
        local nIndex, nPlace, nX, nY = item.GetFirst()
        while nIndex ~= 0 do
            local nGenre, nDetail, nParticular = item.GetKey(nIndex)
            if nPlace == 3 and nGenre == 1 then
                count = count + 1
            end
            nIndex, nPlace, nX, nY = item.GetNext()
        end

        -- echoGreen("Cßn " .. count .. " b×nh mana")

        if fasle and count < 1 then
            echoGreen("Cßn " .. count .. " b×nh mana")
            control.PauseAll()
            for i = 0, 255 do
                if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 and npc.GetKind(i) == 3 then
                    debugNPC(i)
                    local nX, nY = npc.GetMapPos(i)
                    player.MoveTo(nX, nY)
                    echo(getDistanceNPC(i))
                    while getDistanceNPC(i) > 90 do
                        player.MoveTo(nX, nY)
                        timer.Sleep(100)
                    end
                    player.DialogNpc(i)
                    timer.Sleep(1000)
                    WaitMenuTimeOut(3)
                    clickMenu(2)
                end
            end
            control.ResetAll()
        end
        timer.Sleep(1000)
    end
end
