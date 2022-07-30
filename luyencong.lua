szChungLib = system.GetScriptFolder() .. "\\LIB\\chung.lua"
IncludeFile(szChungLib)

function main()
    local nFirstTime = os.clock()
    local nBatVongSang = nFirstTime
    local clockChat = os.clock()
    local nDungTrongThanh = 0

    if (player.IsFightMode() == 0) then
    echo("THPDenNoiLuyenCong")
    THPDenNoiLuyenCong()
    end

    while false do
        local nCurrentTime = os.clock()
        local nDiffSecond = nCurrentTime - nFirstTime
        local nDiffMinute = (nDiffSecond - (nDiffSecond % 60)) / 60
        -- echo(nDiffMinute)
        -- echo(nDiffSecond)

        -- Bat Vong Sang
        if player.GetLevel() < 60 and (nBatVongSang == nFirstTime or os.clock() - nBatVongSang > 600) then
            -- BatVongSang()
            nBatVongSang = os.clock()
        end

        -- bug luc tay thieu lam
        if (IsThieuLam()) then
            -- TangLucTayThieuLam()
        end

        -- Spam Chat Phu Can
        -- if os.clock() - clockChat > 4 then
        --     tbVulanLib.Chat(CH_NEARBY, colorBySeries() .. "<enter>§å chÝ miÔn phÝ ^^")
        --     clockChat = os.clock()
        -- end

        -- THP len bai
        if (player.IsFightMode() == 0) then
            nDungTrongThanh = nDungTrongThanh + 1
        else
            nDungTrongThanh = 0
        end

        if nDungTrongThanh > 60 then
            THPDenNoiLuyenCong()
        end
        timer.Sleep(1000)
    end
end

function THPDenNoiLuyenCong()
    echo("THPDenNoiLuyenCong")
    control.PauseAll()
    menu.Close(0)
    menu.Close(1)
    timer.Sleep(1000)
    BAITRAIN()
    timer.Sleep(2000)
    control.ResetAll()
end

function BatVongSang()
    if (player.GetLevel() < 66) then
        useLenhBai("CÈm nang b«n tÈu")
        clickMenu(2)
    end
end

function TangLucTayThieuLam()
    local nMinExp, nMaxExp = player.GetExperience()
    -- MangChuyVaoNguoi()
    local nIndex, nPlace, nX, nY = item.GetFirst()
    while nIndex ~= 0 do
        local szName = item.GetName(nIndex)
        if nPlace == 2 and string.find(szName, "chïy") then
            echo(szName)
            tbVulanLib.MoveItem(2, 3, szName)
            break
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end
end

function MangChuyVaoNguoi()
    local nIndex, nPlace, nX, nY = item.GetFirst()
    while nIndex ~= 0 do
        local szName = item.GetName(nIndex)
        if nPlace == 3 and string.find(szName, "chïy") then
            item.Use(nIndex, nPlace, nX, nY)
            break
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end
end
