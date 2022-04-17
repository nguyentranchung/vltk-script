local szChungLib = system.GetScriptFolder() .. "\\LIB\\chung.lua"
IncludeFile(szChungLib)

function main()
    ThapNienQuaUyDanh(60)
    echoRed("L�m Event ho�n t�t!")
end

function ThapNienQuaUyDanh(nSoLuong)
    local nSoLuong = nSoLuong or 1
    local quaUyDanh = "Th�p ni�n qu� uy danh"
    local damMeBatTan = "�am m� b�t t�n"
    local nIndex, nPlace, nX, nY = item.GetFirst()
    local nCount = nSoLuong - countHanhTrang(quaUyDanh) - countHanhTrang(damMeBatTan)
    local nInputNumber = 0
    while nCount > 0 do
        nInputNumber = ternary(getFreeHanhTrang(true) < nCount, getFreeHanhTrang(), nCount)
        talkNPC("C�y c�i ngu�n")
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
        talkNPC("C�y c�i ngu�n")
        clickMenuAll(0, 0)
        timer.Sleep(500)
        backspace()
        nhapso(nInputNumber)
        timer.Sleep(500)
        nCount = nSoLuong - countHanhTrang(quaUyDanh)
    end
end
