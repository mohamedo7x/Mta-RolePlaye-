function getWindowPosistion(width, height)
    local sw, sh = guiGetScreenSize()

    local x = (sw / 2) - (width / 2)
    local y = (sh / 2) - (height / 2)

    return x, y, width, height
end

function hideScreenCombonenet(status)
    fadeCamera(true)
    if status == false or status == nil then
        setPlayerHudComponentVisible("radar", false)
        showChat(false)
        showCursor(true, true)
    else
        setPlayerHudComponentVisible("radar", true)
        showChat(true)
        showCursor(false)
    end
end
