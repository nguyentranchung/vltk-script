function TimDoKhangHoa()
    TimDo(102)
end
function TimDoKhangBang()
    TimDo(105)
end
function TimDoSucManh()
    TimDo(97)
end
function TimDoThanPhap()
    TimDo(98)
end
function TimDoKhangHoa()
    TimDo(102)
end
function TimDoSinhKhi()
    TimDo(99)
end
function TimDoTGLC()
    TimDo(106)
end
function TimDoTGTD()
    TimDo(108)
end

function TimDo(findnMagicType)
    echoRed('T×m ®å b¾t ®Çu')
    local nIndex, nPlace, nX, nY = item.GetFirst()
    while nIndex ~= 0 do
        local nGenre, nDetail, nParticular = item.GetKey(nIndex)
        local szName = item.GetName(nIndex)
        if nGenre == 0 and item.GetPrice(nIndex) > 0 then
            for i = 0, 5 do
                local nMagicType, nValue1, nValue2, nValue3 = item.GetMagicAttrib(nIndex, i)
                if (findnMagicType == nMagicType) then
                    echo(szName)
                    echo('Dßng ' .. (i + 1) .. ': ' .. nValue1)
                end
            end
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
