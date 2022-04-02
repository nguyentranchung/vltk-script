szChungLib = system.GetScriptFolder() .. "\\LIB\\chung.lua"
IncludeFile(szChungLib)

function main()
    -- writeNPC()
    -- writeObject()
    -- writeHanhTrang()
    TimDoTGLC()
    getAllData(object)
    writeObject()
    for i = 0, 79 do
        local nSkillID = skill.GetID(i)
        if (nSkillID ~= nil) then
            -- echo(nSkillID)
        end
    end
end
