-- kind_normal = quai    
-- kind_player,
-- kind_partner,
-- kind_dialoger,
-- kind_bird,
-- kind_mouse = 5
function writeThuocTinh()
    echoRed('Ghi toµn bé thuéc tÝnh cã trong hµnh trang ra file')
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
                echo('Dßng ' .. (i + 1) .. ': ' .. nMagicType .. ' - ' .. nValue1)
                file:write('[' .. nMagicType .. '] = ' .. nValue1 .. ',' .. '\n')
            end
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end
    file:close(file)
end

function writeHanhTrang()
    echoRed('Ghi tªn c¸c vËt phÈm trong hµnh trang')
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

function writeObject()
    echoRed('Ghi tªn c¸c vËt phÈm ®ang rít')
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

function writeNPC()
    local file = io.open(gl_ScriptFolder .. "\\logs\\npc", "w")
    for i = 0, 255 do
        if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            -- file:write("npc_" .. toSlug(npc.GetName(i)) .. " = \"" .. npc.GetName(i) .. "\"", "\n")
            file:write("\"" .. debugNPC(i) .. "\"", "\n")
        end
    end
    file:close()
end
