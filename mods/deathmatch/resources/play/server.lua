local config =  {
    times = 5, -- 10 times and if got falid band
    timeBand = 3600000 -- band 1 h
}


local db = exports.db.getConnect()


local collection = {}
addEvent('find:player' , true)
addEventHandler('find:player' ,resourceRoot, function (username , password , serial) 
    local query = dbQuery(db , 'SELECT * FROM accounts WHERE `username` = ?' , username)
    local result = dbPoll(query , -1)

    if collection[serial] == nil then
        collection[serial] = 0
    end

    if collection[serial] == -2 then 
        return 
    end

    if (#result) == 0 then
        -- TODO : print it in login username is not exisit
        triggerClientEvent(client, 'panal:error', resourceRoot , 'username dosent exisit')

        if collection[serial] == -1 then
            triggerClientEvent(client, 'clinet:band', resourceRoot)
            
            local main = client
            setTimer(function()
                triggerClientEvent(main, 'client:free', resourceRoot)  -- Corrected event name
                collection[serial] = 0
            end, config.timeBand, 1)
            collection[serial] = -2
            return
        end

        collection[serial] = collection[serial]  + 1
        
        if collection[serial] >= config.times then  
             collection[serial] = -1
             return
        end

        outputChatBox(collection[serial] , clinet)
        return
    end



    collection[serial] = 0
    local user = result[1].username 
    local pass = result[1].password
    --TODO : cechk if pass is correct if is correct login 
    outputChatBox(user .. ' ' .. pass)
    
    
    triggerClientEvent(client , 'login:close' , resourceRoot)
    
    spawnPlayer(client , result[1].x,result[1].y ,result[1].z ,0 , result[1].skin )
    setElementRotation(client  ,result[1].rx ,result[1].ry ,result[1].rz )
    setElementInterior(client ,result[1].interior )
    setPlayerMoney(client ,result[1].money )
    fadeCamera(client , true)
    setCameraTarget(client , client) 

end)


--server