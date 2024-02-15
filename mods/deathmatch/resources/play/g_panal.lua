local config = {
    window = nil,
    login = nil,
    passwordInput = nil,
    userInput = nil,
    register = nil
}



addEvent('open:register' , false)
addEventHandler('open:register' , localPlayer , function () 
    local x , y , width , height = getWindowPosistion(400 , 400)
        config.window = guiCreateWindow(x , y ,width ,height , 'Register Panal' , false )
        guiSetInputMode('no_binds')
        guiWindowSetMovable(config.window , false)
        guiWindowSetSizable(config.window , false)
        
        local userLable = guiCreateLabel(15,30 ,width, 20 , 'Username: ' , false , config.window)
        config.userInput = guiCreateEdit(10 , 50 , width , 30 , '', false , config.window)
        -- lable ERORR USERNAME
        local usernameErrorLable = guiCreateLabel(width-120,30,140 , 20 , 'Incorrect Username' , false , config.window)
        guiLabelSetColor(usernameErrorLable , 255 , 0 ,0)
        guiSetVisible(usernameErrorLable , false)
        --END
    
        local passwordLable = guiCreateLabel(15,90 ,width, 20 , 'Password: ' , false , config.window)
        config.passwordInput = guiCreateEdit(10 ,110 , width , 30 , '', false , config.window)
        guiEditSetMasked(config.passwordInput , true)
        
        -- lable ERROR PASSWORD
        local passwordErrorLable = guiCreateLabel(width-120,90,140 , 20 , 'Incorrect Password' , false , config.window)
        guiLabelSetColor(passwordErrorLable , 255 , 0 ,0)
        guiSetVisible(passwordErrorLable , false)
        -- END


        local passwordLable_2 = guiCreateLabel(15,140 ,width, 20 , 're Password: ' , false , config.window)
        config.passwordInput = guiCreateEdit(10 ,160 , width , 30 , '', false , config.window)
        guiEditSetMasked(config.passwordInput , true)


          -- lable ERROR PASSWORD
          local passwordErrorLable = guiCreateLabel(width-120,140,140 , 20 , 'Incorrect Password' , false , config.window)
          guiLabelSetColor(passwordErrorLable , 255 , 0 ,0)
          guiSetVisible(passwordErrorLable , false)
          -- END


          

        config.register = guiCreateButton(10 , 300 , width-20 , 30 , 'SignUp' , false , config.window)
        config.login = guiCreateButton(10 , 340 , width - 15 ,35 , 'Back to Login' , false , config.window)
    
       






        addEventHandler('onClientGUIClick' ,config.login  , function (btn,state) 
            if btn ~='left' or state ~='up' then
                    return
            end
            destroyElement(config.window)
            triggerEvent('login:open' , localPlayer)
            end , false)
end)




