local szChungLib = system.GetScriptFolder() .. "\\LIB\\chung.lua"
IncludeFile(szChungLib)

function main()
    local file = io.open(gl_ScriptFolder .. "\\logs\\npc", "w")
    for i = 2, 255 do
        if npc.GetKind(i) == 1 and npc.GetTongName(i) == "Tr¹i" then
            file:write("\"" .. npc.GetName(i) .. "\"", "\n")
        end
    end
    file:close()
    DinhGia()
end
local nIndex, nPlace, nX, nY = item.GetFirst()
local nPrice = nPrice or 50000
while nIndex ~= 0 do
    local nGenre, nDetail, nParticular = item.GetKey(nIndex)
    if nPlace == pos_equiproom and nGenre == 0 then
        item.SetPrice(nIndex, nPrice)
        echo(item.GetName(nIndex))
    end
    nIndex, nPlace, nX, nY = item.GetNext()
end