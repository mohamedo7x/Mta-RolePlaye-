function getWindowPosistion(width, height)
    local sw, sh = guiGetScreenSize()

    local x = (sw / 2) - (width / 2)
    local y = (sh / 2) - (height / 2)

    return x, y, width, height
end


function disapleScreenComponent (status) -- true then panal is active else panal is destoryed
    if status == true then
        guiSetInputMode("no_binds")
        showCursor(true, true)
    else
        guiSetInputMode("allow_binds")
        showCursor(false)
    end
end