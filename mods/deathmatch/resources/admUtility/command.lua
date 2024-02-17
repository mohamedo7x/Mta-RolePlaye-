-- create veh
addCommandHandler(
    "veh",
    function(player, command, id)
        if tonumber(id) == nil or tonumber(id) > 1000 then
            return outputChatBox("Not Valid id", player)
        end
        local x, y, z = getElementPosition(player)
        createVehicle(id, x, y + 1, z)
    end
)

-- remove veh
addCommandHandler(
    "die",
    function(player)
        local veh = getPedOccupiedVehicle(player)

        if veh == nil or tostring(getElementType(veh)) ~= "vehicle" then
            return outputChatBox("there is no vehcile", source)
        end
        destroyElement(veh)
        outputChatBox("done ;)", source)
        return
    end
)
addCommandHandler('money', function (player , command , value) 
    setPlayerMoney(player , value)
end)