szChungLib = system.GetScriptFolder() .. "\\LIB\\chung.lua"
IncludeFile(szChungLib)

function main()
    nFirstTime = os.clock()
    nBatVongSang = nFirstTime

    while true do
        nCurrentTime = os.clock()
        nDiffSecond = nCurrentTime - nFirstTime
        nDiffMinute = (nDiffSecond - (nDiffSecond % 60)) / 60
        -- echo(nDiffMinute)
        -- echo(nDiffSecond)

        -- Bat Vong Sang
        if (nBatVongSang == nFirstTime or os.clock() - nBatVongSang > 60) then
            BatVongSang()
            nBatVongSang = os.clock()
        end
        timer.Sleep(1000)
    end
end

function BatVongSang()
    useLenhBai("CÈm nang b«n tÈu")
    clickMenu(2)
end
