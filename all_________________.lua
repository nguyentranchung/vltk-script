local szChungLib = system.GetScriptFolder() .. "\\LIB\\chung.lua"
IncludeFile(szChungLib)

function main()
    -- writeNPC(kind_dialoger)
    -- writeObject()
    -- writeHanhTrang()
    -- writeObject()
    getAllData(tong)
    echo(tong.GetName())
    -- DoiTienDong(9)
    writeThuocTinh()
end

local function checkPK()
    while true do
        for i = 2, 255 do
            if npc.GetKind(i) == kind_player then
                echo(npc.GetName(i) .. " PK: " .. npc.Get)
            end
        end
        timer.Sleep(500)
    end
end
