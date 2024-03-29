function writeThuocTinh()
    echoRed('Ghi to�n b� thu�c t�nh c� trong h�nh trang ra file')
    local nIndex, nPlace, nX, nY = item.GetFirst()
    local file = io.open(gl_ScriptFolder .. "\\option.txt", "w+")
    while nIndex ~= 0 do
        local nGenre, nDetail, nParticular = item.GetKey(nIndex)
        local szName = item.GetName(nIndex)
        -- echo (szName)
        -- echo (nGenre .. nDetail .. nParticular)
        if nPlace == 3 and nGenre == 0 and item.GetPrice(nIndex) > 0 then
            echo(szName)
            file:write(szName .. '\n')
            for i = 0, 5 do
                local nMagicType, nValue1, nValue2, nValue3 = item.GetMagicAttrib(nIndex, i)
                echo('D�ng ' .. (i + 1) .. ': ' .. nMagicType .. ' - ' .. nValue1)
                file:write('[' .. nMagicType .. '] = ' .. nValue1 .. ',' .. '\n')
            end
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end
    file:close(file)
end

function writeMenu()
    local nType = getMenuType()
    local file = io.open(gl_ScriptFolder .. "\\logs\\menu.txt", "a+")
    for i = 0, menu.GetCount(nType) do
        echo(menu.GetText(nType, i))
        file:write(menu.GetText(nType, i) .. '\n')
    end
    file:close(file)
end

function writeHanhTrang()
    echoRed('Ghi t�n c�c v�t ph�m trong h�nh trang')
    local nIndex, nPlace, nX, nY = item.GetFirst()
    local file = io.open(gl_ScriptFolder .. "\\logs\\items", "w+")
    while nIndex ~= 0 do
        local szName = item.GetName(nIndex)
        echo(szName)
        file:write(szName .. '\n')
        nIndex, nPlace, nX, nY = item.GetNext()
    end
    file:close(file)
end

function countHanhTrang(szItemName)
    local nIndex, nPlace, nX, nY = item.GetFirst()
    local count = 0
    while nIndex ~= 0 do
        if item.GetName(nIndex) == szItemName then
            local nStackCount = item.GetStackCount(nIndex)
            count = count + nStackCount
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end

    echo(szItemName .. ': ' .. count)
    return count
end

function writeObject()
    echoRed('Ghi t�n c�c v�t ph�m �ang r�t')
    local file = io.open(gl_ScriptFolder .. "\\logs\\objects", "w+")
    for i = 1, 255 do
        if object.IsExists(i) then
            if string.len(object.GetName(i)) > 0 then
                local szObjectName = object.GetName(i)
                echo(szObjectName)
                file:write(object.GetName(i) .. '\n')
            end
        end
    end
    file:close(file)
end

function writeNPC(kindNPC)
    local file = io.open(gl_ScriptFolder .. "\\logs\\npc", "w")
    local kindNPC = kindNPC or 0
    for i = 0, 255 do
        if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 and npc.GetKind(i) == kindNPC then
            local nx, ny = npc.GetMapPos(i)
            debugNPC(i)
            file:write("\"" .. npc.GetName(i) .. "\"", "\n")
        end
    end
    file:close()
end
