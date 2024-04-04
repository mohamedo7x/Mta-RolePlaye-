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
-- reuse it again :)


Panal_Config = {
    button = {},
    window = {},
    label = {},
    memo = {},
    active = false
}
Player_info = {
    ID = 199,
    name = getPlayerName(localPlayer),
    ACTIVEADM = 0
}

addEvent('bulid:gui' , true)

addEventHandler('onClientKey' , root , function (button , active) 
    if(button == 'F2' and Panal_Config.active == false) then 
        -- Before Start Get Information From Sql Server
        triggerServerEvent('fetch:status' ,resourceRoot, Player_info.name) -- update it later 
        addEventHandler('bulid:gui' ,resourceRoot ,function (ID , ACTIVEADM)
            Player_info.ID = ID
            Player_info.ACTIVEADM = ACTIVEADM
            Panal()
            Panal_Config.active = true
            disapleScreenComponent(true)
        end)
    end

end)


function Panal()
    local x , y , width , height = getWindowPosistion(500 , 500)
        Panal_Config.window[1] = guiCreateWindow(x, y, height, 477, "Report Panal", false)
        guiWindowSetSizable(Panal_Config.window[1], false)
        Panal_Config.memo[1] = guiCreateMemo(10, 20, 697, 315, "", false, Panal_Config.window[1])
        Panal_Config.button[1] = guiCreateButton(315, 422, 142, 45, "Close", false, Panal_Config.window[1])
        guiSetAlpha(Panal_Config.button[1], 0.82)
        Panal_Config.button[2] = guiCreateButton(315, 362, 142, 45, "Send", false, Panal_Config.window[1])
        Panal_Config.label[1] = guiCreateLabel(100, 369, 112, 24, "Player :"..Player_info.name, false, Panal_Config.window[1])
        guiLabelSetHorizontalAlign(Panal_Config.label[1], "center", false)
        guiLabelSetVerticalAlign(Panal_Config.label[1], "center")
        Panal_Config.label[2] = guiCreateLabel(100, 393, 112, 24, "ID :" .. Player_info.ID, false, Panal_Config.window[1])
        guiLabelSetHorizontalAlign(Panal_Config.label[2], "center", false)
        guiLabelSetVerticalAlign(Panal_Config.label[2], "center")
        Panal_Config.label[3] = guiCreateLabel(100, 417, 77, 23, "Active ADM :", false, Panal_Config.window[1])
        guiLabelSetHorizontalAlign(Panal_Config.label[3], "center", false)
        guiLabelSetVerticalAlign(Panal_Config.label[3], "center")
        Panal_Config.label[4] = guiCreateLabel(171, 417, 31, 17, Player_info.ACTIVEADM, false, Panal_Config.window[1])
        guiLabelSetColor(Panal_Config.label[4], 3, 251, 14)
        guiLabelSetHorizontalAlign(Panal_Config.label[4], "center", false)
        guiLabelSetVerticalAlign(Panal_Config.label[4], "bottom")    

        -- Configuration


        --Events
        addEventHandler('onClientGUIClick' ,Panal_Config.button[1] , function (button , state) 
            if button ~= 'left' and state ~= 'up' then 
               return 
            end
            Panal_Config.active = false
            destroyElement(Panal_Config.window[1])
            disapleScreenComponent(false)
        end , false)


    end

