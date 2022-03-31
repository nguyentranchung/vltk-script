szChungLib = system.GetScriptFolder() .. "\\LIB\\chung.lua"
IncludeFile(szChungLib)

function main()
    -- writeHanhTrang()
    tbVulanLib.UseItemName("ThÇn Hµnh Phï")
    lahantran()
end

function lahantran()
    CamRuongDuongChau()
    clickMenuAll(1, 0, 5, 3) -- 108 la han tran
end

function CamRuongDuongChau()
    clickMenuAll(0, 6, 0, 0) -- 108 la han tran
end
