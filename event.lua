local szChungLib = system.GetScriptFolder() .. "\\LIB\\chung.lua"
IncludeFile(szChungLib)

function main()
    ThapNienQuaUyDanh(60)
    echoRed("Lµm Event hoµn tÊt!")
end

function ThapNienQuaUyDanh(nSoLuong)
    local nSoLuong = nSoLuong or 1
    local quaUyDanh = "ThËp niªn qu¶ uy danh"
    local damMeBatTan = "§am mª bÊt tËn"
    local nIndex, nPlace, nX, nY = item.GetFirst()
    local nCount = nSoLuong - countHanhTrang(quaUyDanh) - countHanhTrang(damMeBatTan)
    local nInputNumber = 0
    while nCount > 0 do
        nInputNumber = ternary(getFreeHanhTrang(true) < nCount, getFreeHanhTrang(), nCount)
        talkNPC("C©y céi nguån")
        clickMenuAll(2, 0)
        timer.Sleep(500)
        backspace()
        nhapso(nInputNumber)
        timer.Sleep(500)
        nCount = nSoLuong - countHanhTrang(quaUyDanh) - countHanhTrang(damMeBatTan)
    end

    nCount = nSoLuong - countHanhTrang(quaUyDanh)
    while nCount > 0 do
        nInputNumber = ternary(getFreeHanhTrang(true) < nCount, getFreeHanhTrang(), nCount)
        echo(nInputNumber)
        talkNPC("C©y céi nguån")
        clickMenuAll(0, 0)
        timer.Sleep(500)
        backspace()
        nhapso(nInputNumber)
        timer.Sleep(500)
        nCount = nSoLuong - countHanhTrang(quaUyDanh)
    end
end
