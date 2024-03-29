szVulanLib = system.GetScriptFolder() .. "\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
local szTHP = system.GetScriptFolder() .. "\\LIB\\THP.lua"
IncludeFile(szTHP)
local libDaTau = system.GetScriptFolder() .. "\\LIB\\datau.lua"
IncludeFile(libDaTau)
local libHelper = system.GetScriptFolder() .. "\\LIB\\helper.lua"
IncludeFile(libHelper)
local libMenu = system.GetScriptFolder() .. "\\LIB\\menu.lua"
IncludeFile(libMenu)
------------------------------------------------------------

-- Global Variables --
chungVersion = "2.2"
chungVersionDate = "01/10/2018"
gl_Time = os.clock()
gl_TimeSuDoThiep = gl_Time
gl_FirstTime = gl_Time
gl_ScriptFolder = system.GetScriptFolder()
gl_SoDongVip = 4
gl_MenuSkip = 3
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
do_none = 0
do_stand = 1 --
do_walk = 2 --
do_run = 3 -- chay
do_jump = 4 --
do_skill = 5 --
do_magic = 6 -- xai chieu
do_attack = 7 -- tan cong
do_sit = 8 -- ngoi
do_hurt = 9
do_death = 10
do_defense = 11
do_idle = 12
do_specialskill = 13
do_special1 = 14
do_special2 = 15
do_special3 = 16
do_special4 = 17
do_runattack = 18
do_manyattack = 19
do_jumpattack = 20
do_revive = 21
pos_hand = 1 -- tren tay
pos_equip = 2 -- trang bi
pos_equiproom = 3 -- hanh trang
pos_repositoryroom = 4 -- kho chua do
pos_traderoom = 5
pos_trade1 = 6
pos_immediacy = 7
pos_giveitem = 12
kind_normal = 0
kind_player = 1
kind_partner = 2
kind_dialoger = 3
kind_bird = 4
kind_mouse = 5
he_kim = 0
he_moc = 1
he_thuy = 2
he_hoa = 3
he_tho = 4
CH_NEARBY = "CH_NEARBY"
CH_TEAM = "CH_TEAM"
CH_WORLD = "CH_WORLD"
CH_FACTION = "CH_FACTION"
CH_SYSTEM = "CH_SYSTEM"
CH_CITY = "CH_CITY"
CH_TONG = "CH_TONG"
CH_TONGUNION = "CH_TONGUNION"
CH_CHATROOM = "CH_CHATROOM"
CH_ATTACK = "CH_ATTACK"
CH_DEFEND = "CH_DEFEND"
CH_JABBER = "CH_JABBER"
CH_SONG = "CH_SONG"
CH_JIN = "CH_JIN"
CH_CUSTOM = "CH_CUSTOM"
-- End ----------------

function useTHP()
    tbVulanLib.UseItemName("Th�n H�nh Ph�")
end

function useLenhBai(szLenhBai)
    local szLenhBai = szLenhBai or 'L�nh b�i T�n Th�'
    tbVulanLib.UseItemName(szLenhBai) -- mo lenh bai
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

function IsThieuLam()
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

function DoiTienDong(nTime)
    local nTime1 = nTime or 1
    for i = 1, nTime1, 1 do
        talkNPC("Ti�n Trang Ba L�ng")
        clickMenuAll(0, 4, 3)
    end
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
        return
    end
    if nVip > 0 and os.time() - gl_Time > 20 then
        echoRed(line())
        echoGreen(
            "Auto L�c �� ch�y r�t hi�u qu� v� mi�n ph�, b�n c� mu�n �ng h� t�c gi� ph�t tri�n th�m t�nh n�ng kh�ng?")
        echoDonate()
        gl_Time = os.time()
    end
    -- echoQuangCao()
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

function enter(nWait)
    local nWait = nWait or 30
    timer.Sleep(nWait)
    system.SendKey(13, 1)
end

function backspace(nWait)
    local nWait = nWait or 30
    timer.Sleep(nWait)
    system.SendKey(8, 1)
end

function nhapso(nSo)
    echo("Nh�p s� " .. nSo)
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

function DinhGia(nPrice)
    local nIndex, nPlace, nX, nY = item.GetFirst()
    local nPrice = nPrice or 50000
    while nIndex ~= 0 do
        local nGenre, nDetail, nParticular = item.GetKey(nIndex)
        if nPlace == pos_equiproom then
            item.SetPrice(nIndex, nPrice)
            echo(item.GetName(nIndex))
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end
end

function ternary(condition, valueWhenTrue, valueWhenFalse)
    if condition then
        return valueWhenTrue
    else
        return valueWhenFalse
    end
end

function RaoVat(szContent)
    local szContent = szContent or ""
    while true do
        tbVulanLib.Chat("CH_WORLD", szContent)
        -- tbVulanLib.Chat(CH_CITY, szContent)
        -- tbVulanLib.Chat(CH_CITY, szContent)
        timer.Sleep(10000)
    end
end

function NguHanh(nIndex)
    local t = {" h� kim ", " h� m�c ", " h� th�y ", " h� h�a ", " h� th� "}
    return t[nIndex + 1]
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

function SellItemByName(szItemName)

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

function getAllData(t, prevData)
    -- if prevData == nil, start empty, otherwise start with prevData
    local data = prevData or {}

    -- copy all the attributes from t
    for k, v in pairs(t) do
        data[k] = data[k] or v
        echo(k)
    end

    -- get t's metatable, or exit if not existing
    local mt = getmetatable(t)
    if type(mt) ~= 'table' then
        return data
    end

    -- get the __index from mt, or exit if not table
    local index = mt.__index
    if type(index) ~= 'table' then
        return data
    end

    -- include the data from index into data, recursively, and return
    return getAllData(index, data)
end

function blank(var)
    return var == nil
end

function filled(var)
    return not blank(var)
end

function getDistance(x1, y1)
    local x2, y2 = player.GetMapPos()
    return math.floor(math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2)))
end

function echo(szContent)
    system.Print(szContent)
end

function echoColor(szContent, szColor)
    szContent = "<color=" .. szColor .. ">" .. szContent
    echo(szContent)
end

function color(szColor)
    return "<color=" .. szColor .. ">"
end

function colorGreen()
    return color("green")
end

function colorRed()
    return color("red")
end

function colorYellow()
    return color("yellow")
end

function colorBySeries()
    if player.GetSeries() == 0 then
        return colorYellow()
    end
    if player.GetSeries() == 1 then
        return colorGreen()
    end
    if player.GetSeries() == 2 then
        return "<bclr=blue>"
    end
    if player.GetSeries() == 3 then
        return "<bclr=red>"
    end
    if player.GetSeries() == 4 then
        return "<bclr=pink>"
    end
end

function echoGreen(szContent)
    echoColor(szContent, "green")
end

function echoRed(szContent)
    echoColor(szContent, "red")
end

-- NPC --
function checkNPC()
    for i = 0, 255 do
        if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            echo(npc.GetName(i) .. ' kind: ' .. npc.GetKind(i) .. " length: " .. string.len(npc.GetName(i)))
        end
    end
end

function showNPC(nKind)
    for i = 0, 255 do
        if npc.GetKind(i) == nKind and npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            debugNPC(i)
        end
    end
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

function heNPC(nIndex)
    if npc.GetSeries(nIndex) == 0 then
        return " h� kim "
    end
    if npc.GetSeries(nIndex) == 1 then
        return " h� m�c "
    end
    if npc.GetSeries(nIndex) == 2 then
        return " h� th�y "
    end
    if npc.GetSeries(nIndex) == 3 then
        return " h� h�a "
    end
    if npc.GetSeries(nIndex) == 4 then
        return " h� th� "
    end
    return " kh�ng r� "
end

function getDistanceNPC(nIndex)
    local nx, ny = npc.GetMapPos(nIndex)
    return getDistance(nx, ny)
end

function debugNPC(nIndex)
    local text = nIndex .. ': ' .. npc.GetName(nIndex) .. heNPC(nIndex) .. ' Range: ' .. getDistanceNPC(nIndex)

    local nHeal, nHealMax = npc.GetLife(nIndex)

    if nHeal > 0 then
        text = text .. ' M�u: ' .. math.floor(nHeal / 1000) .. 'K'
    end
    echo(text)
    return text
end

function attackNPC(nDistance, nNumber)
    local nDistance = nDistance or 150
    local nNumber = nNumber or 2
    while true do
        if player.IsFightMode() == 0 then
            timer.Sleep(500)
        end
        local nNearNPC = 0
        local nNearestNPCIndex = 0
        for i = 0, 255 do
            if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 and npc.GetKind(i) == 0 then
                local nx, ny = npc.GetMapPos(i)
                if getDistance(nx, ny) < nDistance then
                    nNearNPC = nNearNPC + 1
                    nNearestNPCIndex = i
                    debugNPC(i)
                    if nNearNPC > nNumber then
                        echo("T�n c�ng: " .. nNearestNPCIndex)
                        player.SetAttackRadius(200)
                        player.Attack(i)
                        break
                    else
                        if player.GetDoingStatus() ~= do_sit then
                            player.SendCommand(do_sit)
                        end
                    end
                end
            end
        end
        -- echo("S� l��ng NPC: " .. nNearNPC)

        timer.Sleep(1000)
    end
end

function LuyenSkill()
    while true do
        control.ResetAll()
        local attack = false
        local count = 0
        for i = 0, 255 do
            if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 and npc.GetKind(i) == 0 and getDistanceNPC(i) < 300 then
                -- debugNPC(i)
                count = count + 1
            end
        end

        echoGreen("T�m th�y " .. count .. " NPC")
        count = 0
        local nIndex, nPlace, nX, nY = item.GetFirst()
        while nIndex ~= 0 do
            local nGenre, nDetail, nParticular = item.GetKey(nIndex)
            if nPlace == 3 and nGenre == 1 then
                count = count + 1
            end
            nIndex, nPlace, nX, nY = item.GetNext()
        end

        -- echoGreen("C�n " .. count .. " b�nh mana")

        if fasle and count < 1 then
            echoGreen("C�n " .. count .. " b�nh mana")
            control.PauseAll()
            for i = 0, 255 do
                if npc.IsExists(i) and string.len(npc.GetName(i)) > 0 and npc.GetKind(i) == 3 then
                    debugNPC(i)
                    local nX, nY = npc.GetMapPos(i)
                    player.MoveTo(nX, nY)
                    echo(getDistanceNPC(i))
                    while getDistanceNPC(i) > 90 do
                        player.MoveTo(nX, nY)
                        timer.Sleep(100)
                    end
                    player.DialogNpc(i)
                    timer.Sleep(1000)
                    WaitMenuTimeOut(3)
                    clickMenu(2)
                end
            end
            control.ResetAll()
        end
        timer.Sleep(1000)
    end
end
-- NPC --

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

function welcome()
    echoLine()
    echo("Scripts phi�n b�n " .. chungVersion .. " || " .. chungVersionDate)
    echoGreen("Chung Nguy�n Blog: https://chungnguyen.xyz")
    echo(map.GetID() .. " : " .. map.GetName())
    echo("Kinh nghi�m d� t�u: " .. quest.Datau_Exp())
    local nX, nY = player.GetMapPos()
    echo("V� tr� hi�n t�i: " .. nX .. " - " .. nY)
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
nFreeHanhTrang = 61

welcome()
