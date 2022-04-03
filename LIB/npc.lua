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
            local szHe = " kh�ng r� "
            if npc.GetSeries(i) == 0 then
                szHe = " h� kim "
            end
            if npc.GetSeries(i) == 1 then
                szHe = " h� m�c "
            end
            if npc.GetSeries(i) == 2 then
                szHe = " h� th�y "
            end
            if npc.GetSeries(i) == 3 then
                szHe = " h� h�a "
            end
            if npc.GetSeries(i) == 4 then
                szHe = " h� th� "
            end
            echo(npc.GetName(i) .. szHe .. npc.GetLife(i))
        end
    end
end

function talkNPC(szNPCName)
    local minLength = 999999
    local indexNPC = 2

    for i = 2, 255 do
        local nx, ny = npc.GetMapPos(i)
        if npc.GetKind(i) == 3 and filled(szNPCName) and npc.GetName(i) == szNPCName then
            echo("T�m th�y " .. szNPCName .. " s� n�i chuy�n trong ch�c l�t")
            echo(nx .. "/" .. ny)
            player.DialogNpc(i)
            hasDialogOrMenu(4)
            echo("N�i chuy�n th�nh c�ng!")
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
            echo("Kh�ng nh�p v�o t�n npc, n�i chuy�n v�i ng��i g�n nh�t: " .. npc.GetName(indexNPC))
            player.DialogNpc(indexNPC)
            hasDialogOrMenu(4)
            echo("N�i chuy�n th�nh c�ng!")
            echoLine()
            return true
        else
            echoRed("NPC g�n nh�t ��ng c�ch qu� xa")
            return false
        end
    end
    echo("N�i chuy�n th�t b�i!")
    echoLine()
end
