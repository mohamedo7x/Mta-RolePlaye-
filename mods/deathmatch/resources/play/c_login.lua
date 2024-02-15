function times () 

    setTime(0, 0) 
    setMinuteDuration(60000) 
end

local config = {
    window = nil,
    loginButton = nil,
    registerButton = nil,
    forgetPasswordButton = nil,
    passwordInput = nil,
    userInput = nil,
    isBand = false
}


addEvent('login:close' , true)
addEventHandler('login:close' , root , function ()
    if isElement(config.window) then
        destroyElement(config.window)
    end
    hideScreenCombonenet(true)
    showCursor(false)
    guiSetInputMode('allow_binds')
    setCameraDrunkLevel (0)
    return
end)

addEvent('login:open' , true)
addEventHandler('login:open' ,root , function () 
    hideScreenCombonenet(false) ----- CHANAAAAAAAAAAAA
    setCameraDrunkLevel (10)
    setCameraMatrix(-95.5556640625 ,-1185.806640625 ,20 , 500,0,-200) -- make methd change postion
    -- setCameraDrunkLevel(10)
    times() -- remove it after finish
   
   
       
        local x , y , width , height = getWindowPosistion(400 , 240)
        config.window = guiCreateWindow(x , y ,width ,height , 'Login Panal' , false )
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
        config.loginButton = guiCreateButton(10 , 150 , width-20 , 30 , 'Login' , false , config.window)
    
        config.registerButton = guiCreateButton(10 , 190 , (width/2) - 15 ,35 , 'SignUp' , false , config.window)
    
        config.forgetPasswordButton = guiCreateButton((width/2)+5 , 190 ,(width/2) - 15 , 35 , 'Forget Password' , false , config.window ) 


        addEvent('panal:error' , true)
        addEventHandler('panal:error' , resourceRoot , function (msg)
            guiSetVisible(usernameErrorLable , true)
            guiSetText(usernameErrorLable ,msg )
        end)

        addEvent('clinet:band' , true)
        addEventHandler('clinet:band' ,resourceRoot, function () 
        guiSetEnabled(config.loginButton , false)
        guiSetText(config.loginButton , 'Band 50 Munite')
        end)

        addEvent('client:free' , true)
        
        addEventHandler('client:free' ,resourceRoot, function () 
        guiSetEnabled(config.loginButton , true)
        guiSetText(config.loginButton , 'Login')
        end)


        -- BTN CLICK
        addEventHandler('onClientGUIClick' ,config.registerButton  , function (btn,state) 
        if btn ~='left' or state ~='up' then
                return
        end
                triggerEvent('open:register' , localPlayer)
                destroyElement(config.window)
        end , false)
        
        addEventHandler('onClientGUIClick' ,config.loginButton  , function (btn,state) 
        if btn ~='left' or state ~='up' then
                return
        end
        local user = guiGetText(config.userInput)
        local password = guiGetText(config.passwordInput)
    
        if not validUsername(user) then
            return guiSetVisible(usernameErrorLable , true)
        end
        if not validPassword(password) then  
            return guiSetVisible(passwordErrorLable , true)
        end
        guiSetVisible(passwordErrorLable ,false)
        guiSetVisible(usernameErrorLable , false)
        -- TODO: now cechk database for username and password
        
        triggerServerEvent('find:player',resourceRoot , user , password , getPlayerSerial(localPlayer))
     
        end , false)

end)




triggerEvent('login:open' , localPlayer)

-- clinet