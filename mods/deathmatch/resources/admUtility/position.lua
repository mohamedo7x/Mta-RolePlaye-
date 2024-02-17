-- getPostion
addCommandHandler(
    "getpos",
    function(player)
        local x, y, z = getElementPosition(player)
        -- outputChatBox('Real Position \n'..x .. " " ..y ..  " " .. z , player)
        outputChatBox("Position\n" .. x .. " " .. y .. " " .. z)
    end
)

addCommandHandler(
    "allpos",
    function(player)
        local x, y, z = getElementPosition(player)
        local rx, ry, rz = getElementRotation(player)
        local interior = getElementInterior(player)
        for i = 10, 1, -1 do
            outputChatBox(" ")
        end
        outputChatBox(
            "X: " ..
                x ..
                    " Y: " ..
                        y ..
                            " Z: " ..
                                z .. "\n" .. "RX: " .. rx .. " RY: " .. ry .. " RZ: " .. rz .. "\n" .. "INT" .. interior
        )
    end
)
