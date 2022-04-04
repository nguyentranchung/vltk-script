function checkNPC()
    for i = 0, 255 do
        if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            echo(npc.GetName(i) .. ' kind: ' .. npc.GetKind(i) .. " length: " .. string.len(npc.GetName(i)))
        end
    end
end

function showNPC()
    for i = 0, 255 do
        if npc.GetKind(i) == 0 and npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
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

function debugNPC(nIndex)
    local nx, ny = npc.GetMapPos(nIndex)
    local text = npc.GetName(nIndex) .. heNPC(nIndex) .. ' Range: ' .. getDistance(nx, ny)
    echo(text)
    return text
end

function attackNPC()
    -- while true do
    --     echo(player.GetDoingStatus())
    --     timer.Sleep(300)
    -- end
    while true do
        local nNearNPC = 0
        local nNearestNPCIndex = 0
        for i = 0, 255 do
            if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 and npc.GetKind(i) == 0 then
                local nx, ny = npc.GetMapPos(i)
                if getDistance(nx, ny) < 400 then
                    nNearNPC = nNearNPC + 1
                    nNearestNPCIndex = i
                    -- debugNPC(i)
                end
            end
        end

        echo("Sè l­îng NPC: " .. nNearNPC)
        if nNearNPC > 3 then
            player.Attack(nNearestNPCIndex)
        else
            echoRed("Bá qua")
        end
        timer.Sleep(500)
    end
end
