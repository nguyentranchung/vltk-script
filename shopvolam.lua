function main()
    system.Print('Ghi tªn c¸c vËt phÈm trong hµnh trang')
    local nIndex, nPlace, nX, nY = item.GetFirst()
    local file = io.open(system.GetScriptFolder() .. "\\shopvolam.com.txt", "w+")
    while nIndex ~= 0 do
        if nPlace == 3 then
            local nGenre, nDetail, nParticular = item.GetKey(nIndex)
            file:write('Name:' .. item.GetName(nIndex) .. '\n')
            file:write('Level:' .. item.GetLevel(nIndex) .. '\n')
            file:write('Series:' .. item.GetSeries(nIndex) .. '\n')
            file:write('Intro:' .. item.GetIntro(nIndex) .. '\n')
            if nGenre == 0 then
                for i = 0, 5 do
                    local nRequireAttribType, nRequireValue = item.GetRequireAttrib(nIndex, i)
                    if nRequireAttribType > 0 and nRequireAttribType < 1000 then
                        file:write('Require:' .. nRequireAttribType .. '_' .. nRequireValue .. '\n')
                    end
                end
                for i = 0, 6 do
                    local nMagicType, nValue = item.GetMagicAttrib(nIndex, i)
                    if nMagicType > 0 and nMagicType < 1000 then
                        file:write('Magic:' .. nMagicType .. '_' .. nValue .. '\n')
                    end
                end
            end
            file:write('Genre:' .. nGenre .. '\n')
            file:write('Detail:' .. nDetail .. '\n')
            file:write('Particular:' .. nParticular .. '\n')
            file:write('-----' .. '\n')
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end
    file:close(file)
    system.Print('<color=green>Ghi tªn c¸c vËt phÈm trong hµnh trang hoµn tÊt!')
end
