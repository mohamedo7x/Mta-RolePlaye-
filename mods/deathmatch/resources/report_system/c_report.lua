Player_info = {
    ID = 1,
    name = getElementData(localPlayer, 'username'),
    ACTIVEADM = 0
}

addEventHandler('onClientKey', root , function(button, active) 
    if button == 'F2' and active and Panal_Config.spam == true then 
        return outputChatBox('SPAM DETECTION : PLEAS WAIT' , 255 , 0 , 0)
    end

    if button == 'F2' and active and  Panal_Config.active == false and Panal_Config.spam == false then 
        Panal_Config.active = true
        Panal_Config.spam = true
        setTimer(function () 
            Panal_Config.spam = false
        end , 3000 , 1)
        triggerServerEvent('fetch:status', resourceRoot, getElementData(localPlayer, 'username'))
    end
end)

addEvent('bulid:gui', true)
addEventHandler('bulid:gui', resourceRoot, function(admins , PlayerID) 
    if not isElement(Panal_Config.window[1]) then 
        Player_info.ACTIVEADM = tonumber(admins)
        Player_info.ID = PlayerID
        Panal() 
    end
    disapleScreenComponent(true)
end)


function destroyPanal()
    if isElement(Panal_Config.window[1]) then
        destroyElement(Panal_Config.window[1])
    end
    Panal_Config.active = false
end


function Panal()
    local x , y , width , height = getWindowPosistion(500 , 500)
        Panal_Config.window[1] = guiCreateWindow(x, y, height, 477, "Report Panal", false)
        guiWindowSetSizable(Panal_Config.window[1], false)
        Panal_Config.combobox[1] = guiCreateComboBox(10, 20, 697, 100, "Reason", false, Panal_Config.window[1])
        Panal_Config.memo[1] = guiCreateMemo(10, 50, 697, 200, "msg", false, Panal_Config.window[1])
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
        if Player_info.ACTIVEADM == 0 then 
        guiLabelSetColor(Panal_Config.label[4] , 255 , 0 , 0 )
        else 
            guiLabelSetColor(Panal_Config.label[4] , 0 , 255 , 0 )
        end
      
        -- guiLabelSetColor(Panal_Config.label[4], 3, 251, 14)
        guiLabelSetHorizontalAlign(Panal_Config.label[4], "center", false)
        guiLabelSetVerticalAlign(Panal_Config.label[4], "bottom")    

        -- Configuration
        for _ , reportType in ipairs(TypeOfReports) do 
            guiComboBoxAddItem(Panal_Config.combobox[1], '#'..reportType.typeID..': '..reportType.typeName)    
        end




        --Events
        addEventHandler('onClientGUIClick', Panal_Config.button[1], function(button, state)
            if button == 'left' and state == 'up' then
                destroyPanal()
                disapleScreenComponent(false)
                Panal_Config.onClick = false
                return
            end
        end, false)


        addEventHandler('onClientGUIClick', Panal_Config.button[2], function(button, state)
            if  button == 'left' and state == 'up' then
                destroyPanal()
                disapleScreenComponent(false)
                outputChatBox(guiGetText(Panal_Config.memo[1]))
                -- triggerServerEvent('send:report' , resourceRoot , guiGetText(Panal_Config.memo[1]) , tonumber(guiGetText(Panal_Config.combobox[1])) ,Player_info.ID )
                outputChatBox("Thank you for submitting your report (Report ID: #"..'1'.."). An administrator will contact you shortly.", 255, 165, 0)
                outputChatBox("Thank you for your patience. We have received your report (Report ID: #"..'1'.."). Our team is currently investigating the issue. We will contact you again once we have more information.", 102, 204, 255)
                Panal_Config.onClick = false

                
            end
           

        end, false)

        addEventHandler('onClientGUIClick' , Panal_Config.memo[1] , function (button , state)

            if Panal_Config.onClick == false and button == 'left' and state == 'up' then
                guiSetText(Panal_Config.memo[1] , "") 
                Panal_Config.onClick = true
            end
        end, false)

    end