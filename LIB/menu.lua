function WaitMenuTimeOut(nSecond)
    local nFirstTime = os.clock()
    while menu.IsVisible(0) == 0 and menu.IsVisible(1) == 0 do
        timer.Sleep(20)
        if (os.clock() - nFirstTime) > nSecond then
            return false
        end
    end
    return true
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

function getMenuType()
    if menu.GetText(1, 0) == '' then
        return 0
    end
    return 1
end

function clickMenu(nIndex)
    if hasMenu(gl_MenuSkip) then
        timer.Sleep(gl_menuClickSpeed)
        local nType = getMenuType()
        -- while menu.GetText(nType, nIndex) == preMenuText do
        --     timer.Sleep(gl_menuClickSpeed)
        -- end
        if gl_ShowSelectedMenu or gl_Debug then
            echo('§· chän: ' .. menu.GetText(nType, nIndex))
        end
        menu.ClickIndex(nType, nIndex)
        -- preMenuText = menu.GetText(nType, nIndex)
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

function clickText(szText)
    echo('§· chän: ' .. szText)
    menu.ClickText(getMenuType(), szText)
end
