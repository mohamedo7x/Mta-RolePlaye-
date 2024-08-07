local config = {
    times = 5, -- 10 times and if got falid band
    timeBand = 3600000, -- band 1 h
    C_hash = 'MIo33@3#?.o7x' -- generate hashToProtect Data
}
local GolbalTeam = createTeam('Unemployed' , 0 , 0 , 0 )

local db = exports.db.getConnect()
local collection = {}
local x, y, z = getSpawnPosition()
local rx, ry, rz = getSpawnPositionRotation()

addEvent("find:player", true)
addEventHandler(
    "find:player",
    resourceRoot,
    function(username, password, serial)
        local query = dbQuery(db, "SELECT * FROM accounts WHERE `username` = ?", username)
        local result = dbPoll(query, -1)

        if collection[serial] == nil then
            collection[serial] = 0
        end

        if collection[serial] == -2 then
            return
        end

        if (#result) == 0 then
            -- TODO : print it in login username is not exisit
            triggerClientEvent(client, "panal:error", resourceRoot, "username dosent exisit")

            if collection[serial] == -1 then
                triggerClientEvent(client, "clinet:band", resourceRoot)

                local main = client
                setTimer(
                    function()
                        triggerClientEvent(main, "client:free", resourceRoot) -- Corrected event name
                        collection[serial] = 0
                    end,
                    config.timeBand,
                    1
                )
                collection[serial] = -2
                return
            end

            collection[serial] = collection[serial] + 1

            if collection[serial] >= config.times then
                collection[serial] = -1
                return
            end
            return
        end

        local user = username
        local pass = password
        --TODO : cechk if pass is correct if is correct login
        local password = passwordVerify(pass, result[1].password)
        if password == true then
            dbExec(db , 'UPDATE accounts SET online = true WHERE username = ?' , username)
            collection[serial] = 0
            triggerClientEvent(client, "login:close", resourceRoot)
            spawnPlayer(client, result[1].x, result[1].y, result[1].z, 0, result[1].skin)
            setElementRotation(client, result[1].rx, result[1].ry, result[1].rz)
            setElementInterior(client, result[1].interior)
            setPlayerMoney(client, result[1].money)
            fadeCamera(client, true)
            setCameraTarget(client)


            
            local Account_toLogin = getAccount(username)
            
            local account_password = getAccountData(Account_toLogin , 'hashed_password')

            setPlayerTeam(client , GolbalTeam)
            
            setElementData(client , 'username' ,tostring(config.C_hash) .. '|' .. tostring(result[1].username) , false)
            setElementData(client , 'id' , result[1].ID, false)
            setElementData(client , 'privilage' , result[1].privilage  ,false)
            local pl = client
         
            logIn(pl , Account_toLogin ,account_password )
        else
            -- TODO : print it in login username is not exisit
            triggerClientEvent(client, "panal:error", resourceRoot, "USERNAME/PASSWORD")

            if collection[serial] == -1 then
                triggerClientEvent(client, "clinet:band", resourceRoot)

                local main = client
                setTimer(
                    function()
                        triggerClientEvent(main, "client:free", resourceRoot) -- Corrected event name
                        collection[serial] = 0
                    end,
                    config.timeBand,
                    1
                )
                collection[serial] = -2
                return
            end

            collection[serial] = collection[serial] + 1

            if collection[serial] >= config.times then
                collection[serial] = -1
                return
            end

            return
        end

        --SPWAN
    end
)

addEvent("is:playerExsist", true)
addEventHandler(
    "is:playerExsist",
    resourceRoot,
    function(username, email, password, serial)
        local query =
            dbQuery(db, "SELECT 1 FROM accounts WHERE username = ? OR email = ? OR Serial = ?", username, email, serial)
        local result = dbPoll(query, -1)

        if result and #result > 0 then
            return triggerClientEvent(client, "throw:error", resourceRoot, "Username OR email is exisit")
        else
            -- create Account
            createAccount(username, password, email, serial, client)
        end
    end
)

function createAccount(username, psdw, email, serial)
    local password = passwordHash(psdw, "bcrypt", {})
    local createdAccount = addAccount(username ,password ) 
    setAccountData(createdAccount , 'hashed_password' ,password )
    local skin = math.random(1, 70)
    dbExec(
        db,
        "INSERT INTO accounts (username, password, email, serial, skin , x , y , z,rx , ry , rz ,online) VALUES (?,?,?,?, ?, ?, ?, ? , ? , ? ,? , ?)",
        username,
        password,
        email,
        serial,
        skin,
        x,
        y,
        z,
        rx,
        ry,
        rz,
        true
    )
    triggerClientEvent(client, "throw:okey", resourceRoot, "Sign Up Sucessfuly")
    local play = client
    local Q_id = dbQuery(db , 'SELECT ID FROM accounts WHERE `username` = ?' , username)
    local id = dbPoll(Q_id , -1 )
    local old_name = getPlayerName(play)
    setTimer(
        function()
            
            triggerClientEvent(play, "register:close", resourceRoot)
            spawnPlayer(play, x, y, z + 1, 0, skin)
            setElementRotation(play, rx or 0, ry or 0, rz or 0)
            setElementInterior(play or 0, 0)
            setPlayerMoney(play, 500)
            fadeCamera(play, true)
            setCameraTarget(play)

            setPlayerName(play , 'O7X - '.. old_name)
            setPlayerTeam(play , GolbalTeam)
            
            setElementData(play , 'username' , tostring(config.C_hash)..'|'..tostring(username) , false)
            -- setElementData(play , 'id' , tostring(config.C_hash..'|'..id[1].id), false)
            setElementData(play , 'id' ,id[1].id , false )
            -- logIn() ERROR
        end,
        2000,
        1
    )
    
end

addEvent("serailExisit", true)
addEventHandler(
    "serailExisit",
    resourceRoot,
    function(serial)
        local query = dbQuery(db, "SELECT 1 FROM accounts WHERE Serial = ?", serial)
        local result = dbPoll(query, -1)

        if result and #result > 0 then
            triggerClientEvent(client, "panal:regiser-close", resourceRoot)
        else
            return
        end
    end
)

