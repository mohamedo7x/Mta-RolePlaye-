local config = {
    window = nil,
    login = nil,
    passwordInput = nil,
    userInput = nil,
    register = nil,
    emailInput = nil,
    passwordInpuTtwo = nil
}

addEvent("open:register", false)
addEventHandler(
    "open:register",
    localPlayer,
    function()
        local x, y, width, height = getWindowPosistion(400, 400)
        config.window = guiCreateWindow(x, y, width, height, "Register Panal", false)
        guiSetInputMode("no_binds")
        guiWindowSetMovable(config.window, false)
        guiWindowSetSizable(config.window, false)

        local userLable = guiCreateLabel(15, 30, width, 20, "Username: ", false, config.window)
        config.userInput = guiCreateEdit(10, 50, width, 30, "", false, config.window)
        -- lable ERORR USERNAME
        local usernameErrorLable = guiCreateLabel(width - 120, 30, 140, 20, "Incorrect Username", false, config.window)
        guiLabelSetColor(usernameErrorLable, 255, 0, 0)
        guiSetVisible(usernameErrorLable, false)
        --END

        local passwordLable = guiCreateLabel(15, 90, width, 20, "Password: ", false, config.window)
        config.passwordInput = guiCreateEdit(10, 110, width, 30, "", false, config.window)
        guiEditSetMasked(config.passwordInput, true)

        -- lable ERROR PASSWORD
        local passwordErrorLable = guiCreateLabel(width - 120, 90, 140, 20, "Incorrect Password", false, config.window)
        guiLabelSetColor(passwordErrorLable, 255, 0, 0)
        guiSetVisible(passwordErrorLable, false)
        -- END

        local passwordLable_2 = guiCreateLabel(15, 140, width, 20, "re Password: ", false, config.window)
        config.passwordInpuTtwo = guiCreateEdit(10, 160, width, 30, "", false, config.window)
        guiEditSetMasked(config.passwordInpuTtwo, true)

        -- lable ERROR PASSWORD
        local passwordErrorLabletwo =
            guiCreateLabel(width - 120, 140, 140, 20, "Incorrect Password", false, config.window)
        guiLabelSetColor(passwordErrorLabletwo, 255, 0, 0)
        guiSetVisible(passwordErrorLabletwo, false)
        -- END

        local emailLable = guiCreateLabel(15, 190, width, 20, "Email: ", false, config.window)
        config.emailInput = guiCreateEdit(10, 210, width, 30, "", false, config.window)

        local Error_lable = guiCreateLabel(15, 250, width, 100, "ERROR", false, config.window)
        guiLabelSetColor(Error_lable, 255, 0, 0)
        guiSetVisible(Error_lable, false)

        config.register = guiCreateButton(10, 300, width - 20, 30, "SignUp", false, config.window)
        config.login = guiCreateButton(10, 340, width - 15, 35, "Back to Login", false, config.window)

        addEventHandler(
            "onClientGUIClick",
            config.register,
            function(btn, state)
                if btn ~= "left" or state ~= "up" then
                    return
                end
                local username = guiGetText(config.userInput)
                local email = guiGetText(config.emailInput)
                local passwordOne = guiGetText(config.passwordInput)
                local passwordtwo = guiGetText(config.passwordInpuTtwo)

                if not validUsername(tostring(username)) then
                    return guiSetVisible(usernameErrorLable, true)
                else
                    guiSetVisible(usernameErrorLable, false)
                end

                if not validPassword(tostring(passwordOne)) then
                    return guiSetVisible(passwordErrorLable, true)
                else
                    guiSetVisible(passwordErrorLable, false)
                end

                if not validPasswordSame(tostring(passwordOne), tostring(passwordtwo)) then
                    return guiSetVisible(passwordErrorLabletwo, true)
                else
                    guiSetVisible(passwordErrorLabletwo, false)
                end

                if not validemail(tostring(email)) then
                    guiSetText(Error_lable, "Invlaid Email")
                    return guiSetVisible(Error_lable, true)
                else
                    guiSetVisible(Error_lable, false)
                end

                triggerServerEvent(
                    "is:playerExsist",
                    resourceRoot,
                    username,
                    email,
                    passwordtwo,
                    getPlayerSerial(localPlayer)
                )

                addEvent("throw:error", true)
                addEventHandler(
                    "throw:error",
                    resourceRoot,
                    function(error)
                        guiSetVisible(Error_lable, true)
                        guiLabelSetColor(Error_lable, 255, 0, 0)
                        guiSetText(Error_lable, tostring(error))
                    end
                )

                addEvent("throw:okey", true)
                addEventHandler(
                    "throw:okey",
                    resourceRoot,
                    function(message)
                        guiSetVisible(Error_lable, true)
                        guiLabelSetColor(Error_lable, 0, 255, 0)
                        guiSetText(Error_lable, tostring(message))
                    end
                )
            end,
            false
        )

        addEventHandler(
            "onClientGUIClick",
            config.login,
            function(btn, state)
                if btn ~= "left" or state ~= "up" then
                    return
                end
                destroyElement(config.window)
                triggerEvent("login:open", localPlayer)
            end,
            false
        )
    end
)

addEvent("register:close", true)
addEventHandler(
    "register:close",
    resourceRoot,
    function()
        if isElement(config.window) then
            destroyElement(config.window)
        end
        hideScreenCombonenet(true)
        showCursor(false)
        guiSetInputMode("allow_binds")
        setCameraDrunkLevel(0)
        return
    end
)
