szVulanLib = system.GetScriptFolder().."\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
------------------------------------------------------------

-- Global Vari ---------------------------------------------
chungVersion = "2.1"
chungVersionDate = "29/09/2018"
gl_Time = os.clock()
gl_TimeSuDoThiep = gl_Time
gl_FirstTime = gl_Time
gl_ScriptFolder = system.GetScriptFolder()
gl_SoDongVip = 4
gl_MenuSkip = 3
gl_EnterWait = 200
gl_ShowSelectedMenu = false
gl_QuangCao = true
gl_QuangCaoCount = 0
gl_LocDoTheoSet = 1
gl_menuClickSpeed = 50
gl_Sleep = 50
gl_Tien = false
gl_TienHanhTrang = 0
gl_GuiDo = true
preMenuText = ""
gl_Debug = true
tbSetDo = {}
-- End -----------------------------------------------------
function useTHP()
    tbVulanLib.UseItemName("ThÇn Hµnh Phï")
end

function useLenhBai(szLenhBai)
    local szLenhBai = szLenhBai or 'LÖnh bµi T©n Thñ'
    tbVulanLib.UseItemName(szLenhBai) -- mo lenh bai
end

function clickMenu(nIndex)
    if hasMenu(gl_MenuSkip) then
        local nType = getMenuType()
        -- while menu.GetText(nType, nIndex) == preMenuText do
        --     timer.Sleep(gl_menuClickSpeed)
        -- end
        if gl_ShowSelectedMenu or gl_Debug then
            echo('§· chän: ' .. menu.GetText(nType, nIndex))
        end
        menu.ClickIndex(nType, nIndex)
        -- preMenuText = menu.GetText(nType, nIndex)
        timer.Sleep(gl_menuClickSpeed)
        return true
    else
        if gl_Debug then
            echo("Click Menu gÆp sù cè ngoµi ý muèn! Vui lßng ®îi auto xö lý!")
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
    for i,v in ipairs(arg) do
        if clickMenu(v) == false then
            resetMenuDialog()
            break
        end
    end
end

function resetMenuDialog()
    if dialog.IsVisible() then
        dialog.Close()
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
    echo('§· chän: ' .. szText)
    menu.ClickText(nType, szText)
end

function x2_sudothiep()
if player.GetLevel() > 79 then return end
if os.clock() - gl_TimeSuDoThiep < 30 then return end
if player.IsFightMode() == 0 then return end
if player.IsActiveState(76) == 1 then return end
gl_TimeSuDoThiep = os.clock()
echo("BËt "..szSuDoThiep)
tbVulanLib.UseItemName(szSuDoThiep)
echo("BËt "..szSuDoThiep.. ' kÕt thóc')
end

function check_state()
    for i=1,500 do
        if player.IsActiveState(i) == 1 then
            echo(i)
        end
    end
end

function bat_heal()
    local nMana = player.GetMana()
if nMana > 50 then return end
if player.GetLevel() > 80 then return end
    -- if player.IsActiveState(52) == 1 then return end
    echo("NhËn vßng s¸ng")
    tbVulanLib.UseItemName("CÈm nang ®ång hµnh")
    tbVulanLib.WaitMenuTimeOut(0,2)
    clickMenu(0,0)
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
        echo('Hµnh trang cßn trèng: ' .. free .. ' chç')
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
            echo(npc.GetName(i) .. ' kind: ' .. npc.GetKind(i) .. " length: " ..string.len(npc.GetName(i)))
        end
    end
end

function showNPC()
    for i = 0, 255 do
        if npc.GetKind(i) == 0 and npc.IsExists(i) and string.len(npc.GetName(i)) > 0 then
            local nx, ny = npc.GetMapPos(i)
            local szHe = " kh«ng râ "
            if npc.GetSeries(i) == 0 then
                szHe = " hÖ kim "
            end
            if npc.GetSeries(i) == 1 then
                szHe = " hÖ méc "
            end
            if npc.GetSeries(i) == 2 then
                szHe = " hÖ thñy "
            end
            if npc.GetSeries(i) == 3 then
                szHe = " hÖ háa "
            end
            if npc.GetSeries(i) == 4 then
                szHe = " hÖ thæ "
            end
            echo(npc.GetName(i) .. szHe .. npc.GetLife(i))
        end
    end
end

function writeNPC()
    local file = io.open (gl_ScriptFolder .. "\\npc.txt", "w")
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
    echoRed("Ghi l¹i qu·ng ®­êng nh©n vËt di chuyÓn!")
    local x = 0
    local time = os.date("*t", os.time())
    local file = io.open (gl_ScriptFolder .. "\\mapPath.txt", "w")
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
    echoRed("Ghi l¹i thµnh c«ng!")
end

function talkNPC(szNPCName)
    local minLength = 999999
    local indexNPC = 2

    for i = 2, 255 do
        local nx, ny = npc.GetMapPos(i)
        if npc.GetKind(i) == 3 and filled(szNPCName) and npc.GetName(i) == szNPCName then
            echo ("T×m thÊy " .. szNPCName .. " sÏ nãi chuyÖn trong chèc l¸t")
            echo(nx .. "/" .. ny)
            player.DialogNpc(i)
            hasDialogOrMenu(4)
            echo("Nãi chuyÖn thµnh c«ng!")
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
            echo ("Kh«ng nhËp vµo tªn npc, nãi chuyÖn víi ng­êi gÇn nhÊt: " .. npc.GetName(indexNPC))
            player.DialogNpc(indexNPC)
            hasDialogOrMenu(4)
            echo("Nãi chuyÖn thµnh c«ng!")
            echoLine()
            return true
        else
            echoRed("NPC gÇn nhÊt ®øng c¸ch qu¸ xa")
            return false
        end
    end
    echo("Nãi chuyÖn thÊt b¹i!")
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
    if gl_Debug then
        echo("TiÕn hµnh läc ®å!")
    end
    gl_FirstTime = os.clock()
    while nFreeHanhTrang == getFreeHanhTrang(false) do 
        timer.Sleep(500)
        if (os.clock() - gl_FirstTime) > 1 then
            gl_EnterWait = 500
            if gl_Debug then
                echoRed("CËp nhËt hµnh trang thÊt b¹i")
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
        echo('Trong hµnh trang cã ' .. nVip .. ' ®å vÝp')
        tbVulanLib.Chat("CH_NEARBY","<color=green>Trong hµnh trang cã " .. nVip .. " mãn vÝp :0!")
    end
    if nVip > 0 and os.time() - gl_Time > 20 then
        echoRed(line())
        echoGreen("Auto Läc ®å ch¹y rÊt hiÖu qu¶ vµ miÔn phÝ, b¹n cã muèn ñng hé t¸c gi¶ ph¸t triÓn thªm tÝnh n¨ng kh«ng?")
        echoDonate()
        gl_Time = os.time()
    end
    echoQuangCao()
    nFreeHanhTrang = getFreeHanhTrang(false)
end

function GuiDo(nIndex, nXLocDo, nYLocDo)
    if gl_GuiDo then
        echoGreen("TiÕn hµnh cÊt ®å!!!")
        local nWidthGuiDo, nHeightGuiDo = item.GetSize(nIndex)
        local bFound, nXGuiDo, nYGuiDo = player.FindRoom(nWidthGuiDo, nHeightGuiDo, 1)
        if bFound then
            echoRed("B¹n ph¶i ch¾n ch¾n r­¬ng ch­a ®å ®ang ®­îc më s½n!!!")
            item.Move(3,nXLocDo, nYLocDo,0,0,0)
            while item.IsHold() == 0 do
                echo("no hold")
                timer.Sleep(500)
            end
            item.Move(4, nXGuiDo, nYGuiDo, 4, nXGuiDo, nYGuiDo)
            gl_FirstTime = os.clock()
            while item.IsHold() == 1 do
                timer.Sleep(500)
                if os.clock() - gl_FirstTime > 5 then
                    echoRed("R­¬ng ®å ch­a më, t¾t tÝnh n¨ng göi ®å!!!")
                    gl_GuiDo = false
                    item.Move(3,nXLocDo, nYLocDo, 3,nXLocDo, nYLocDo)
                    break
                end
            end
        else
            gl_GuiDo = false
            echoRed("R­¬ng kh«ng cßn chç trèng!!!")
        end
    end
end

function writeThuocTinh()
    echoRed('Ghi toµn bé thuéc tÝnh cã trong hµnh trang ra file')
    local nIndex, nPlace, nX, nY = item.GetFirst()
    local file = io.open (gl_ScriptFolder .. "\\option.txt", "w+")
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
                echo('Dßng ' .. (i+1) .. ': ' .. nMagicType .. ' - ' .. nValue1)
                file:write('[' .. nMagicType .. '] = ' .. nValue1 .. ',' .. '\n')
            end
        end
        nIndex, nPlace, nX, nY = item.GetNext()
    end
    file:close(file)
end

function enter()
    if gl_Debug then
        echo("Enter Sleep: " .. gl_EnterWait)
    end
    timer.Sleep(gl_EnterWait)
    system.SendKey(13, 1)
    gl_EnterWait = 200
end

function nhapso(nSo)
    local nLength
    gl_FirstTime = os.clock()
    while dialog.IsVisible() == 0 do
        timer.Sleep(10)
        if os.clock() - gl_FirstTime > 3 then
            resetMenuDialog()
            if gl_Debug then
                echoRed("NhËp sè kh«ng thµnh c«ng!")
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
end

function writeMenu()
    local nType = 1
    if menu.IsVisible(1) == 0 then
        nType = 0
    end
    local file = io.open (gl_ScriptFolder .. "\\menu.txt", "w")
    for i=0, menu.GetCount(nType) do
        echo (menu.GetText(nType, i))
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
    echo("Chñ TK: NGUYEN TRAN CHUNG")
    echo("Sè TK: 0061001069423")
    echo("Chi nh¸nh Vietcombank Kh¸nh Hßa")
    echoRed(line())
end

function echoQuangCao()
    if gl_QuangCao and gl_QuangCaoCount > 20 then
        -- tbVulanLib.Chat("CH_WORLD", "<enter>Chung NguyÔn<enter>võa update auto läc ®.å version 2.0<enter>Tèc ®é ¸nh s¸ng - kh«ng lag - free")
        gl_QuangCaoCount = 0
    end
    tbVulanLib.Chat("CH_NEARBY", "<color=green>Auto ChungNguyÔn max speed, free :0")
    gl_QuangCaoCount = gl_QuangCaoCount + 1
end

function toSlug(str)
    str = string.gsub(str,"iÕ","tiet")
    str = string.gsub(str,"§¸i","dai")
    str = string.gsub(str,"§­","d")
    str = string.gsub(str,"ê","uo")
    str = string.gsub(str,"­u","uu")
    str = string.gsub(str,"¤","o")
    str = string.gsub(str,"¢","a")
    str = string.gsub(str,"uyÕ","uye")
    return str
    :gsub('%®¹o', 'dao') -- duong

    :gsub('%­­®', 'd') -- dd

    :gsub('%­­­øu', 'uu') -- uuws
    :gsub('%­­­õu', 'uu') -- uuwf
    :gsub('%­­­÷u', 'uu') -- uuwx
    :gsub('%öu', 'uu') -- uuwr
    :gsub('%­­ùu', 'uu') -- uuwj

    :gsub('%¸', 'a') -- as
    :gsub('%µ', 'a') -- af
    :gsub('%·', 'a') -- ax
    :gsub('%¶', 'a') -- ar
    :gsub('%¹', 'a') -- aj

    :gsub('%©', 'a') -- aa
    :gsub('%Ê', 'a') -- aas
    :gsub('%Ç', 'a') -- aaf
    :gsub('%É', 'a') -- aax
    :gsub('%È', 'a') -- aar
    :gsub('%Ë', 'a') -- aaj

    :gsub('%¨', 'a') -- aw
    :gsub('%¾', 'a') -- aws
    :gsub('%»', 'a') -- awf
    :gsub('%½', 'a') -- awx
    :gsub('%¼', 'a') -- awr
    :gsub('%Æ', 'a') -- awj

    :gsub('%Ð', 'e') -- es
    :gsub('%Ì', 'e') -- ef
    :gsub('%Ï', 'e') -- ex
    :gsub('%Î', 'e') -- er
    :gsub('%Ñ', 'e') -- ej

    :gsub('%Õ', 'e') -- ees
    :gsub('%Ò', 'e') -- eef
    :gsub('%Ô', 'e') -- eex
    :gsub('%Ó', 'e') -- eer
    :gsub('%Ö', 'e') -- eej

    :gsub('%Ý', 'i') -- is
    :gsub('%×', 'i') -- if
    :gsub('%Ü', 'i') -- ix
    :gsub('%Ø', 'i') -- ir
    :gsub('%Þ', 'i') -- ij

    :gsub('%ã', 'o') -- os
    :gsub('%ß', 'o') -- of
    :gsub('%â', 'o') -- ox
    :gsub('%á', 'o') -- or
    :gsub('%ä', 'o') -- oj

    :gsub('%«', 'o') -- oo
    :gsub('%è', 'o') -- oos
    :gsub('%å', 'o') -- oof
    :gsub('%ç', 'o') -- oox
    :gsub('%æ', 'o') -- oor
    :gsub('%é', 'o') -- ooj

    :gsub('%ý', 'y') -- s
    :gsub('%ú', 'y') -- f
    :gsub('%ü', 'y') -- x
    :gsub('%û', 'y') -- r
    :gsub('%þ', 'y') -- j

    :gsub('%ó', 'u') -- us
    :gsub('%ï', 'u') -- uf
    :gsub('%ò', 'u') -- ux
    :gsub('%ñ', 'u') -- ur
    :gsub('%ô', 'u') -- uj

    :gsub('%­¬', 'uo') -- uow
    :gsub('%­­­í', 'uo') -- uos
    :gsub('%­­­ê', 'uo') -- uof
    :gsub('%­­­ì', 'uo') -- uox
    :gsub('%­­­ë', 'uo') -- uor
    :gsub('%­­î', 'uo') -- uoj

    -- :gsub(' I$', '1')
    -- :gsub(' II$', '2')
    -- :gsub(' III$', '3')
    -- :gsub(' IV$', '4')
    -- :gsub(' V$', '5')
    -- :gsub('[^%w]', '')
    :lower()
end

tbThuocTinhName = {
    [43] = "Kh«ng thÓ ph¸ hñy", 
    [58] = "Bá qua nÐ tr¸nh", 
    [85] = "Sinh lùc", 
    [89] = "Néi lùc", 
    [93] = "ThÓ lùc", 
    [97] = "Søc m¹nh", 
    [98] = "Th©n ph¸p",
    [99] = "Sinh khÝ", 
    [88] = "Phôc håi sinh lùc mçi nöa gi©y", 
    [92] = "Phôc håi néi lùc mçi nöa gi©y", 
    [96] = "Phôc håi thÓ lùc mçi nöa gi©y", 
    [101] = "Kh¸ng ®äc", 
    [102] = "Kh¸ng háa", 
    [103] = "Kh¸ng l«i", 
    [104] = "Phßng thñ vËt lý", 
    [105] = "Kh¸ng b¨ng", 
    [106] = "TG lµm chËm", 
    [108] = "TG tróng ®äc", 
    [110] = "TG lµm cho¸ng", 
    [111] = "Tèc ®é di chuyÓn", 
    [113] = "TG phôc håi", 
    [115] = "Tèc ®é ®¸nh (ngo¹i c«ng)", 
    [116] = "Tèc ®é ®¸nh (néi c«ng)", 
    [114] = "Kh¸ng tÊt c¶", 
    [117] = "Ph¶n ®ßn cËn chiÕn", 
    [135] = "May m¾n %", 
    [121] = "STVL ®iÓm", 
    [122] = "Háa s¸t ngo¹i c«ng", 
    [123] = "B¨ng s¸t ngo¹i c«ng", 
    [124] = "L«i s¸t s¸t ngo¹i c«ng", 
    [125] = "§éc s¸t ngo¹i c«ng", 
    [126] = "STVL %", 
    [134] = "CHSTTNL", 
    [136] = "Hót sinh lùc", 
    [137] = "Hót néi lùc", 
    [139] = "Kü n¨ng MP", 
    [166] = "TØ lÖ c«ng kÝch chÝnh x¸c", 
    [168] = "STVL néi c«ng", 
    [169] = "B¨ng s¸t néi c«ng", 
    [170] = "Háa s¸t néi c«ng", 
    [171] = "L«i s¸t néi c«ng", 
    [172] = "§éc s¸t néi c«ng,"  
}


-- Start
nFreeHanhTrang = getFreeHanhTrang(false)
echoLine()
echo("Scripts phiªn b¶n " .. chungVersion .. " || " .. chungVersionDate)
echoGreen("Chung NguyÔn Blog: https://chungnguyen.xyz")
-- End