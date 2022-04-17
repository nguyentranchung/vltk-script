function TimDoKhangHoa()
    TimDoByMagic(102)
end
function TimDoKhangBang()
    TimDoByMagic(105)
end
function TimDoSucManh()
    TimDoByMagic(97)
end
function TimDoThanPhap()
    TimDoByMagic(98)
end
function TimDoKhangHoa()
    TimDoByMagic(102)
end
function TimDoTheLuc()
    TimDoByMagic(93)
end
function TimDoSinhKhi()
    TimDoByMagic(99)
end
function TimDoThoiGianLamCham()
    TimDoByMagic(106)
end
function TimDoThoiGianLamChoang()
    TimDoByMagic(110)
end
function TimDoTGTD()
    TimDoByMagic(108)
end

function TimDoByMagic(findnMagicType)
    echoRed('T×m ®å b¾t ®Çu')
    local nIndex, nPlace, nX, nY = item.GetFirst()
    while nIndex ~= 0 do
        local nGenre, nDetail, nParticular = item.GetKey(nIndex)
        local szName = item.GetName(nIndex)
        if nGenre == 0 and item.GetPrice(nIndex) > 0 then
            for i = 0, 5 do
                local nMagicType, nValue1, nValue2, nValue3 = item.GetMagicAttrib(nIndex, i)
                if (findnMagicType == nMagicType) then
                    echo(szName .. heNPC(item.GetSeries(nIndex)) .. ': ' .. nValue1)
                end
            end
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end
    echoRed('T×m ®å kÕt thóc')
end

function TimDoByLevel(nLevel)
    echoRed('T×m ®å b¾t ®Çu')
    local nIndex, nPlace, nX, nY = item.GetFirst()
    while nIndex ~= 0 do
        local nGenre, nDetail, nParticular = item.GetKey(nIndex)
        local szName = item.GetName(nIndex)
        if nGenre == 0 and item.GetLevel(nIndex) == nLevel and item.GetPrice(nIndex) > 0 then
            echo(szName .. NguHanh(item.GetSeries(nIndex)))
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end
    echoRed('T×m ®å kÕt thóc')
end

function TimBossXanh()
    while true do
        for i = 1, 255 do
            if npc.IsExists(i) then
                echo(npc.GetName(i))
            end
        end
        timer.Sleep(100)
    end
end

function TimDoTuNguoiBan()
    while true do
        for i = 2, 255 do
            echo(npc.GetName(i))
            echo(npc.IsStall(i) == 1)
            if npc.IsExists(i) and npc.GetKind(i) == 1 and npc.IsStall(i) == 1 and getDistanceNPC(i) < 200 then
                stall.Open(i)
                while stall.IsVisible() == 0 do
                    timer.Sleep(50)
                end

                if stall.IsVisible() == 1 then
                    local nEnd = stall.GetCount() - 1
                    for i = 0, nEnd do
                        local nItemIndex = stall.GetIndex(i)
                        echo(item.GetName(nItemIndex))
                    end
                end

                break
            end
        end

        break
        -- timer.Sleep(1000)
    end
end
