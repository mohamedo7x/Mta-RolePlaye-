local db = exports.db.getConnect()

function getSpawnPosition()
    local x = -79.5322265625
    local y = -1169.447265625
    local z = 2.1657977104187
    return x, y, z
end

function getSpawnPositionRotation()
    local rx = 0
    local ry = 0
    local rz = 74.721893310547
    return rx, ry, rz
end

addEventHandler(
    "onPlayerJoin",
    root,
    function()
        triggerClientEvent(source, "login:open", source)
    end
)

addEventHandler(
    "onPlayerQuit",
    root,
    function()
        local username = getElementData(source, "username") or false

        if not username then
            outputServerLog("Failed to update account data on quit: Missing username.")
            return
        end

        local x, y, z = getElementPosition(source)

        if x == 0 and y == 0 and z == 0 then
            outputServerLog("Failed to update account data on quit: Invalid position.")
            return
        end

        local rx, ry, rz = getElementRotation(source)
        local skin = getElementModel(source)
        local money = getPlayerMoney(source)
        skin = tostring(skin)
        money = tostring(money)
        -- local query = dbQuery()
        dbExec(
            db,
            "UPDATE accounts SET skin = ?, x = ?, y = ?, z = ?, rx = ?, ry = ?, rz = ?, money = ? ,online = false WHERE username = ? ",
            skin,
            x,
            y,
            z,
            rx,
            ry,
            rz,
            money,
            username
            
        )
    end
)
