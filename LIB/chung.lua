szVulanLib = system.GetScriptFolder() .. "\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
------------------------------------------------------------

-- Global Vari ---------------------------------------------
chungVersion = "2.2"
chungVersionDate = "01/10/2018"
gl_Time = os.clock()
gl_TimeSuDoThiep = gl_Time
gl_FirstTime = gl_Time
gl_ScriptFolder = system.GetScriptFolder()
gl_SoDongVip = 4
gl_MenuSkip = 3
gl_EnterWait = 30
gl_ShowSelectedMenu = false
gl_QuangCao = true
gl_QuangCaoCount = 0
gl_LocDoTheoSet = 1
gl_menuClickSpeed = 50
gl_Sleep = 50
gl_Tien = false
gl_TienHanhTrang = 0
gl_GuiDo = true
gl_InternetDelay = 50
gl_filterCount = 0
preMenuText = ""
gl_Debug = true
tbSetDo = {}
-- End -----------------------------------------------------
function useTHP()
    tbVulanLib.UseItemName("Th�n H�nh Ph�")
end

function useLenhBai(szLenhBai)
    local szLenhBai = szLenhBai or 'L�nh b�i T�n Th�'
    tbVulanLib.UseItemName(szLenhBai) -- mo lenh bai
end

function clickMenu(nIndex)
    if hasMenu(gl_MenuSkip) then
        timer.Sleep(gl_menuClickSpeed)
        local nType = getMenuType()
        -- while menu.GetText(nType, nIndex) == preMenuText do
        --     timer.Sleep(gl_menuClickSpeed)
        -- end
        if gl_ShowSelectedMenu or gl_Debug then
            echo('�� ch�n: ' .. menu.GetText(nType, nIndex))
        end
        menu.ClickIndex(nType, nIndex)
        -- preMenuText = menu.GetText(nType, nIndex)
        return true
    else
        if gl_Debug then
            echo("Click Menu g�p s� c� ngo�i � mu�n! Vui l�ng ��i auto x� l�!")
        end
        return false
    end
end

function clickMenuNext(nIndex)
    if hasDialogOrMenu(5) then
        local nType = getMenuType()
        clickMenu(nIndex)
    end
end

function clickMenuAll(...)
    for i, v in ipairs(arg) do
        if clickMenu(v) == false then
            resetMenuDialog()
            break
        end
    end
end

function resetMenuDialog()
    if dialog.IsVisible() then
        dialog.Close()
        if dialog.IsVisible() == 1 then
            system.SendKey(27, 1)
        end
    end
    if menu.IsVisible(1) then
        menu.Close(1)
    end
    if menu.IsVisible(0) then
        menu.Close(0)
    end
end

function getMenuType()
    if menu.GetText(1, 0) == '' then
        return 0
    end
    return 1
end

function clickText(szText)
    echo('�� ch�n: ' .. szText)
    menu.ClickText(nType, szText)
end

function x2_sudothiep()
    if player.GetLevel() > 79 then
        return
    end
    if os.clock() - gl_TimeSuDoThiep < 30 then
        return
    end
    if player.IsFightMode() == 0 then
        return
    end
    if player.IsActiveState(76) == 1 then
        return
    end
    gl_TimeSuDoThiep = os.clock()
    echo("B�t " .. szSuDoThiep)
    tbVulanLib.UseItemName(szSuDoThiep)
    echo("B�t " .. szSuDoThiep .. ' k�t th�c')
end

function check_state()
    for i = 1, 500 do
        if player.IsActiveState(i) == 1 then
            echo(i)
        end
    end
end

function thieulam()
    return (player.GetSeries() == 0 and player.GetStature() == 1)
end

function bat_heal()
    local nMana = player.GetMana()
    if nMana > 50 then
        return
    end
    if player.GetLevel() > 80 then
        return
    end
    -- if player.IsActiveState(52) == 1 then return end
    echo("Nh�n v�ng s�ng")
    tbVulanLib.UseItemName("C�m nang ��ng h�nh")
    tbVulanLib.WaitMenuTimeOut(0, 2)
    clickMenu(0)
end

function checkVar(var)
    for k, v in pairs(var) do
        echo(k)
    end
end

function getFreeHanhTrang(showEcho)
    local free = 60
    local nItemIndex, nPlace, nX, nY, nWidth, nHeight
    for i = 0, 255 do
        nItemIndex, nPlace, nX, nY = item.GetPos(i)
        if nPlace == 3 then
            nWidth, nHeight = item.GetSize(nItemIndex)
            free = free - nWidth * nHeight
        end
    end
    if showEcho then
        echo('H�nh trang c�n tr�ng: ' .. free .. ' ch�')
    end
    return free
end

function box(szContent)
    system.MessageBox(szContent)
end

function checkNPC()
    for i = 0, 255 do
        if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            echo(npc.GetName(i) .. ' kind: ' .. npc.GetKind(i) .. " length: " .. string.len(npc.GetName(i)))
        end
    end
end

function showNPC()
    for i = 0, 255 do
        if npc.GetKind(i) == 0 and npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            local szHe = " kh�ng r� "
            if npc.GetSeries(i) == 0 then
                szHe = " h� kim "
            end
            if npc.GetSeries(i) == 1 then
                szHe = " h� m�c "
            end
            if npc.GetSeries(i) == 2 then
                szHe = " h� th�y "
            end
            if npc.GetSeries(i) == 3 then
                szHe = " h� h�a "
            end
            if npc.GetSeries(i) == 4 then
                szHe = " h� th� "
            end
            echo(npc.GetName(i) .. szHe .. npc.GetLife(i))
        end
    end
end

function writeNPC()
    local file = io.open(gl_ScriptFolder .. "\\npc.txt", "w")
    for i = 0, 255 do
        if npc.GetKind(i) == 3 and npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            -- file:write("npc_" .. toSlug(npc.GetName(i)) .. " = \"" .. npc.GetName(i) .. "\"", "\n")
            file:write("\"" .. npc.GetName(i) .. "\"", "\n")
        end
    end
    file:close()
end

function writeMapPath()
    echoRed("Ghi l�i qu�ng ���ng nh�n v�t di chuy�n!")
    local x = 0
    local time = os.date("*t", os.time())
    local file = io.open(gl_ScriptFolder .. "\\mapPath.txt", "w")
    file:write("local mapPath = {")
    -- s
    while true and x < 20 do
        local nx, ny = player.GetMapPos(i)
        file:write("{" .. nx .. "," .. ny .. "}")

        if player.GetDoingStatus() == 1 then
            x = x + 1
            echo(x)
        end
        timer.Sleep(200)
    end
    file:close()
    echoRed("Ghi l�i th�nh c�ng!")
end

function talkNPC(szNPCName)
    local minLength = 999999
    local indexNPC = 2

    for i = 2, 255 do
        local nx, ny = npc.GetMapPos(i)
        if npc.GetKind(i) == 3 and filled(szNPCName) and npc.GetName(i) == szNPCName then
            echo("T�m th�y " .. szNPCName .. " s� n�i chuy�n trong ch�c l�t")
            echo(nx .. "/" .. ny)
            player.DialogNpc(i)
            hasDialogOrMenu(4)
            echo("N�i chuy�n th�nh c�ng!")
            echoLine()
            return true
        end
        if npc.GetKind(i) == 3 and blank(szNPCName) then
            if getDistance(nx, ny) < minLength then
                indexNPC = i
                minLength = getDistance(nx, ny)
            end
        end
    end

    if blank(szNPCName) then
        if gl_Debug then
            echo(minLength)
        end
        if minLength > 1100 then
            echo("Kh�ng nh�p v�o t�n npc, n�i chuy�n v�i ng��i g�n nh�t: " .. npc.GetName(indexNPC))
            player.DialogNpc(indexNPC)
            hasDialogOrMenu(4)
            echo("N�i chuy�n th�nh c�ng!")
            echoLine()
            return true
        else
            echoRed("NPC g�n nh�t ��ng c�ch qu� xa")
            return false
        end
    end
    echo("N�i chuy�n th�t b�i!")
    echoLine()
end

function hasDialogOrMenu(nSecond)
    gl_FirstTime = os.clock()
    while menu.IsVisible(0) == 0 and menu.IsVisible(1) == 0 and dialog.IsVisible() == 0 do
        timer.Sleep(gl_Sleep)
        if (os.clock() - gl_FirstTime) > nSecond then
            return false
        end
    end
    return true
end

function hasMenu(nSecond)
    gl_FirstTime = os.clock()
    while menu.IsVisible(0) == 0 and menu.IsVisible(1) == 0 do
        timer.Sleep(gl_Sleep)
        if (os.clock() - gl_FirstTime) > nSecond then
            return false
        end
    end
    timer.Sleep(20)
    return true
end

function hasDialog(nSecond)
    gl_FirstTime = os.clock()
    while dialog.IsVisible() == 0 do
        timer.Sleep(gl_Sleep)
        if (os.clock() - gl_FirstTime) > nSecond then
            return false
        end
    end
    return true
end

function testLength()
    for i = 0, 255 do
        if npc.IsExists(i) and npc.GetKind(i) == 3 and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            echo(npc.GetName(i))
            echo(tbVulanLib.GetLengthPlayer(nx, ny))
        end
    end
end

function LocDo()
    if gl_InternetDelay == nil then
        gl_InternetDelay = 150
    end

    if gl_InternetDelay > 3000 then
        gl_InternetDelay = 3000
    end

    timer.Sleep(gl_InternetDelay)

    if gl_Debug then
        echo("Ti�n h�nh l�c ��!")
    end
    gl_FirstTime = os.clock()
    while nFreeHanhTrang == getFreeHanhTrang(false) do
        timer.Sleep(500)
        if (os.clock() - gl_FirstTime) > 1 then
            -- gl_EnterWait = 500
            if gl_Debug then
                echoRed("C�p nh�t h�nh trang th�t b�i")
            end
            nFreeHanhTrang = 61
        end
    end
    local nVip = 0
    local nIndex, nPlace, nXLocDo, nYLocDo = item.GetFirst()
    while nIndex ~= 0 do
        local nGenre = item.GetKey(nIndex)
        if nPlace == 3 and nGenre == 0 then
            local bFlag = 0
            local nDoVip = 0
            if gl_LocDoTheoSet == 1 then
                for k1, v1 in pairs(tbSetDo) do
                    bFlag = 0
                    for i = 0, 5 do
                        local nMagicType, nValue = item.GetMagicAttrib(nIndex, i)
                        if 600 >= nValue and v1[nMagicType] ~= nil and nValue >= v1[nMagicType] then
                            bFlag = bFlag + 1
                        end
                    end
                    if bFlag == tablelength(v1) then
                        nDoVip = 1
                    end
                end
            else
                for i = 0, 5 do
                    local nMagicType, nValue = item.GetMagicAttrib(nIndex, i)
                    if 600 >= nValue and tbThuocTinh[nMagicType] ~= nil and nValue >= tbThuocTinh[nMagicType] then
                        bFlag = bFlag + 1
                    end
                end
                if bFlag < gl_SoDongVip then
                    nDoVip = 1
                end
            end
            if nDoVip == 0 then
                ShopItem(nIndex)
            else
                GuiDo(nIndex, nXLocDo, nYLocDo)
                nVip = nVip + 1
            end
        end
        nIndex, nPlace, nXLocDo, nYLocDo = item.GetNext()
    end
    if nVip > 0 then
        echo('Trong h�nh trang c� ' .. nVip .. ' �� v�p')
        tbVulanLib.Chat("CH_NEARBY", "<color=green>Trong h�nh trang c� " .. nVip .. " m�n v�p :0!")
    end
    if nVip > 0 and os.time() - gl_Time > 20 then
        echoRed(line())
        echoGreen(
            "Auto L�c �� ch�y r�t hi�u qu� v� mi�n ph�, b�n c� mu�n �ng h� t�c gi� ph�t tri�n th�m t�nh n�ng kh�ng?")
        echoDonate()
        gl_Time = os.time()
    end
    echoQuangCao()
    nFreeHanhTrang = getFreeHanhTrang(false)
end

function GuiDo(nIndex, nXLocDo, nYLocDo)
    if gl_GuiDo then
        echoGreen("Ti�n h�nh c�t ��!!!")
        local nWidthGuiDo, nHeightGuiDo = item.GetSize(nIndex)
        local bFound, nXGuiDo, nYGuiDo = player.FindRoom(nWidthGuiDo, nHeightGuiDo, 1)
        if bFound then
            echoRed("B�n ph�i ch�n ch�n r��ng ch�a �� �ang ���c m� s�n!!!")
            item.Move(3, nXLocDo, nYLocDo, 0, 0, 0)
            while item.IsHold() == 0 do
                echo("no hold")
                timer.Sleep(500)
            end
            item.Move(4, nXGuiDo, nYGuiDo, 4, nXGuiDo, nYGuiDo)
            gl_FirstTime = os.clock()
            while item.IsHold() == 1 do
                timer.Sleep(500)
                if os.clock() - gl_FirstTime > 5 then
                    echoRed("R��ng �� ch�a m�, t�t t�nh n�ng g�i ��!!!")
                    gl_GuiDo = false
                    item.Move(3, nXLocDo, nYLocDo, 3, nXLocDo, nYLocDo)
                    break
                end
            end
        else
            gl_GuiDo = false
            echoRed("R��ng kh�ng c�n ch� tr�ng!!!")
        end
    end
end

function writeThuocTinh()
    echoRed('Ghi to�n b� thu�c t�nh c� trong h�nh trang ra file')
    local nIndex, nPlace, nX, nY = item.GetFirst()
    local file = io.open(gl_ScriptFolder .. "\\option.txt", "w+")
    while nIndex ~= 0 do
        local nGenre, nDetail, nParticular = item.GetKey(nIndex)
        local szName = item.GetName(nIndex)
        -- echo (szName)
        -- echo (nGenre .. nDetail .. nParticular)
        if nPlace == 3 and nGenre == 0 and item.GetPrice(nIndex) > 0 then
            echo(szName)
            file:write(szName .. '\n')
            for i = 0, 5 do
                local nMagicType, nValue1, nValue2, nValue3 = item.GetMagicAttrib(nIndex, i)
                echo('D�ng ' .. (i + 1) .. ': ' .. nMagicType .. ' - ' .. nValue1)
                file:write('[' .. nMagicType .. '] = ' .. nValue1 .. ',' .. '\n')
            end
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end
    file:close(file)
end

function writeHanhTrang()
    echoRed('Ghi t�n c�c v�t ph�m trong h�nh trang')
    local nIndex, nPlace, nX, nY = item.GetFirst()
    local file = io.open(gl_ScriptFolder .. "\\logs\\items", "w+")
    while nIndex ~= 0 do
        local szName = item.GetName(nIndex)
        echo(szName)
        file:write(szName .. '\n')
        nIndex, nPlace, nX, nY = item.GetNext()
    end
    file:close(file)
end

function TangLucTayThieuLam()
    local nMinExp, nMaxExp= player.GetExperience()

    -- writeHanhTrang()
    -- MangChuyVaoNguoi("Ng� Tinh ch�y")
    echo(nMinExp)
    echo(nMaxExp)
    local nIndex, nPlace, nX, nY = item.GetFirst()
    -- while item.GetEquipmentIndex(3) == 0 do
    --     echo("Chua mang vu khi")
    --     timer.Sleep(500)
    -- end
    while nIndex ~= 0 do
        local szName = item.GetName(nIndex)
        if nPlace == 2 then
            -- if nPlace == 2 and szName == "Ng� Tinh ch�y" then
            echo(szName)
            echo(nIndex)
            echo(nX)
            echo(nY)
            -- timer.Sleep(500)
            -- item.Use(nIndex)
            item.Move(nPlace, nX, nY, 0, 0, 0)
            return
            -- while item.IsHold() == 0 do
            --     echo("IsHold 0")
            --     timer.Sleep(500)
            -- end
            -- item.Move(nIndex, 1, 1, 3, 1, 1)
            -- while item.IsHold() == 1 do
            --     echo("IsHold 1")
            --     timer.Sleep(500)
            -- end
            -- echo("okkkkkkkkkkkkkkkkkkkkk")
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end
end

function MangChuyVaoNguoi(szItemName)
    if item.GetEquipmentIndex(3) > 0 then
        return
    end
    -- local szItemName = szItemName or 'L�nh b�i T�n Th�'
    local nIndex, nPlace, nX, nY = item.GetFirst()
    while nIndex ~= 0 do
        local szName = item.GetName(nIndex)
        if (szName == szItemName) then
            item.Use(nIndex, nPlace, nX, nY)
            return
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end
end

function enter()
    if gl_Debug then
        echo("Enter Sleep: " .. gl_EnterWait)
    end
    timer.Sleep(gl_EnterWait)
    system.SendKey(13, 1)
    -- gl_EnterWait = 30
end

function nhapso(nSo)
    local nLength
    gl_FirstTime = os.clock()
    while dialog.IsVisible() == 0 do
        timer.Sleep(10)
        if os.clock() - gl_FirstTime > 3 then
            resetMenuDialog()
            if gl_Debug then
                echoRed("Nh�p s� kh�ng th�nh c�ng!")
            end
            return
        end
    end
    for i in string.gmatch(tostring(nSo), "%d") do
        timer.Sleep(50)
        system.SendKey(48 + tonumber(i), 0)
    end
    enter()
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

function ShopItem(nIndex)
    local startTime = os.clock() * 1000
    if gl_Tien then
        gl_TienHanhTrang = player.GetMoney(0)
        shop.Buy(nIndex)
        while gl_TienHanhTrang == player.GetMoney(0) do
            timer.Sleep(10)
        end
    else
        nFreeHanhTrang = getFreeHanhTrang(false)
        shop.Buy(nIndex)
        gl_FirstTime = os.clock()
        while nFreeHanhTrang == getFreeHanhTrang(false) do
            timer.Sleep(10)
            if os.clock() - gl_FirstTime > 2 then
                break
            end
        end
    end
    gl_InternetDelay = (os.clock() * 1000 - startTime) + 30
    if gl_InternetDelay < 150 then
        gl_InternetDelay = 150
    end
end

function writeMenu()
    local nType = 1
    if menu.IsVisible(1) == 0 then
        nType = 0
    end
    local file = io.open(gl_ScriptFolder .. "\\menu.txt", "w")
    for i = 0, menu.GetCount(nType) do
        echo(menu.GetText(nType, i))
        file:write(toSlug(menu.GetText(nType, i)) .. '\n')
    end
    file:close(file)
end

function blank(var)
    return var == nil
end

function filled(var)
    return not blank(var)
end

function getDistance(x1, y1)
    local x2, y2 = player.GetMapPos()
    return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2))
end

function echo(szContent)
    system.Print(szContent)
end

function echoColor(szContent, szColor)
    szContent = "<color=" .. szColor .. ">" .. szContent
    echo(szContent)
end

function echoGreen(szContent)
    echoColor(szContent, "green")
end

function echoRed(szContent)
    echoColor(szContent, "red")
end

function line()
    return "==================================="
end

function echoLine()
    echo(line())
end

function echoDonate()
    echoRed(line())
    echo("Ch� TK: NGUYEN TRAN CHUNG")
    echo("S� TK: 0061001069423")
    echo("Chi nh�nh Vietcombank Kh�nh H�a")
    echoRed(line())
end

function echoQuangCao()
    if gl_QuangCao and gl_QuangCaoCount > 40 then
        -- tbVulanLib.Chat("CH_WORLD", "<enter>Chung Nguy�n<enter>v�a update auto l�c �.� version 2.2<enter>T�c �� �nh s�ng - kh�ng lag - free")
        gl_QuangCaoCount = 0
    end
    -- tbVulanLib.Chat("CH_NEARBY", "<color=green>Auto ChungNguy�n max speed, free :0")
    tbVulanLib.Chat("CH_NEARBY", "<bclr=blue>�� VIP �i ra n�o! :0")
    gl_QuangCaoCount = gl_QuangCaoCount + 1
end

function toSlug(str)
    str = string.gsub(str, "i�", "tiet")
    str = string.gsub(str, "��i", "dai")
    str = string.gsub(str, "��", "d")
    str = string.gsub(str, "�", "uo")
    str = string.gsub(str, "�u", "uu")
    str = string.gsub(str, "�", "o")
    str = string.gsub(str, "�", "a")
    str = string.gsub(str, "uy�", "uye")
    return str:gsub('%��o', 'dao') -- duong
    :gsub('%���', 'd') -- dd
    :gsub('%����u', 'uu') -- uuws
    :gsub('%����u', 'uu') -- uuwf
    :gsub('%����u', 'uu') -- uuwx
    :gsub('%�u', 'uu') -- uuwr
    :gsub('%���u', 'uu') -- uuwj
    :gsub('%�', 'a') -- as
    :gsub('%�', 'a') -- af
    :gsub('%�', 'a') -- ax
    :gsub('%�', 'a') -- ar
    :gsub('%�', 'a') -- aj
    :gsub('%�', 'a') -- aa
    :gsub('%�', 'a') -- aas
    :gsub('%�', 'a') -- aaf
    :gsub('%�', 'a') -- aax
    :gsub('%�', 'a') -- aar
    :gsub('%�', 'a') -- aaj
    :gsub('%�', 'a') -- aw
    :gsub('%�', 'a') -- aws
    :gsub('%�', 'a') -- awf
    :gsub('%�', 'a') -- awx
    :gsub('%�', 'a') -- awr
    :gsub('%�', 'a') -- awj
    :gsub('%�', 'e') -- es
    :gsub('%�', 'e') -- ef
    :gsub('%�', 'e') -- ex
    :gsub('%�', 'e') -- er
    :gsub('%�', 'e') -- ej
    :gsub('%�', 'e') -- ees
    :gsub('%�', 'e') -- eef
    :gsub('%�', 'e') -- eex
    :gsub('%�', 'e') -- eer
    :gsub('%�', 'e') -- eej
    :gsub('%�', 'i') -- is
    :gsub('%�', 'i') -- if
    :gsub('%�', 'i') -- ix
    :gsub('%�', 'i') -- ir
    :gsub('%�', 'i') -- ij
    :gsub('%�', 'o') -- os
    :gsub('%�', 'o') -- of
    :gsub('%�', 'o') -- ox
    :gsub('%�', 'o') -- or
    :gsub('%�', 'o') -- oj
    :gsub('%�', 'o') -- oo
    :gsub('%�', 'o') -- oos
    :gsub('%�', 'o') -- oof
    :gsub('%�', 'o') -- oox
    :gsub('%�', 'o') -- oor
    :gsub('%�', 'o') -- ooj
    :gsub('%�', 'y') -- s
    :gsub('%�', 'y') -- f
    :gsub('%�', 'y') -- x
    :gsub('%�', 'y') -- r
    :gsub('%�', 'y') -- j
    :gsub('%�', 'u') -- us
    :gsub('%�', 'u') -- uf
    :gsub('%�', 'u') -- ux
    :gsub('%�', 'u') -- ur
    :gsub('%�', 'u') -- uj
    :gsub('%��', 'uo') -- uow
    :gsub('%����', 'uo') -- uos
    :gsub('%����', 'uo') -- uof
    :gsub('%����', 'uo') -- uox
    :gsub('%����', 'uo') -- uor
    :gsub('%���', 'uo') -- uoj
    -- :gsub(' I$', '1')
    -- :gsub(' II$', '2')
    -- :gsub(' III$', '3')
    -- :gsub(' IV$', '4')
    -- :gsub(' V$', '5')
    -- :gsub('[^%w]', '')
    :lower()
end

tbThuocTinhName = {
    [43] = "Kh�ng th� ph� h�y",
    [58] = "B� qua n� tr�nh",
    [85] = "Sinh l�c",
    [89] = "N�i l�c",
    [93] = "Th� l�c",
    [97] = "S�c m�nh",
    [98] = "Th�n ph�p",
    [99] = "Sinh kh�",
    [88] = "Ph�c h�i sinh l�c m�i n�a gi�y",
    [92] = "Ph�c h�i n�i l�c m�i n�a gi�y",
    [96] = "Ph�c h�i th� l�c m�i n�a gi�y",
    [101] = "Kh�ng ��c",
    [102] = "Kh�ng h�a",
    [103] = "Kh�ng l�i",
    [104] = "Ph�ng th� v�t l�",
    [105] = "Kh�ng b�ng",
    [106] = "TG l�m ch�m",
    [108] = "TG tr�ng ��c",
    [110] = "TG l�m cho�ng",
    [111] = "T�c �� di chuy�n",
    [113] = "TG ph�c h�i",
    [115] = "T�c �� ��nh (ngo�i c�ng)",
    [116] = "T�c �� ��nh (n�i c�ng)",
    [114] = "Kh�ng t�t c�",
    [117] = "Ph�n ��n c�n chi�n",
    [135] = "May m�n %",
    [121] = "STVL �i�m",
    [122] = "H�a s�t ngo�i c�ng",
    [123] = "B�ng s�t ngo�i c�ng",
    [124] = "L�i s�t s�t ngo�i c�ng",
    [125] = "��c s�t ngo�i c�ng",
    [126] = "STVL %",
    [134] = "CHSTTNL",
    [136] = "H�t sinh l�c",
    [137] = "H�t n�i l�c",
    [139] = "K� n�ng MP",
    [166] = "T� l� c�ng k�ch ch�nh x�c",
    [168] = "STVL n�i c�ng",
    [169] = "B�ng s�t n�i c�ng",
    [170] = "H�a s�t n�i c�ng",
    [171] = "L�i s�t n�i c�ng",
    [172] = "��c s�t n�i c�ng,"
}

-- Start
nFreeHanhTrang = 61
echoLine()
echo("Scripts phi�n b�n " .. chungVersion .. " || " .. chungVersionDate)
echoGreen("Chung Nguy�n Blog: https://chungnguyen.xyz")
-- End
