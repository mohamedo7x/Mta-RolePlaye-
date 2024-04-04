local db = exports.db.getConnect()



-- to fetch Active Admin for loop throw all player and find ADM
local users = {}
function throwAllPlayerToGetAdmPrivilage () 
    for i ,player in pairs(getElementsByType('player')) do 
        local name = getPlayerName(player)
        table.insert(users , i , tostring(name) )
    end
end

addEvent('fetch:status' , true)
addEventHandler('fetch:status', resourceRoot , function (username) 
    throwAllPlayerToGetAdmPrivilage() -- load All Player 

-- Fetch Active ADM [ Done ]
-- Fetch Name OF Player [ Not Included Yet ]
-- Fetch ID Of Player [ Done ]
    local ActiveADM = 0 
    for _ , username_active in ipairs(users) do -- len == 5 o7x mohamedo7x 
        local query = dbQuery(db , 'SELECT COUNT(username) AS active FROM accounts WHERE  `privilage` = 4 AND username = ?' , username_active)
        local res = dbPoll(query , -1) 
        if #res > 0 then 
            ActiveADM = ActiveADM + 1 
        end
    end


    local query_2 = dbQuery(db,'SELECT ID FROM accounts WHERE `username` = ?' , username)
    local Player_ID = dbPoll(query_2 , -1)


triggerClientEvent(client , 'bulid:gui',resourceRoot  ,Player_ID[1].ID , ActiveADM)
-- now exe fun and pass ACTIVEADM AND PLAYER_ID

end)