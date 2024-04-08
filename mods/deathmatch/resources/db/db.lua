local db
local dbHost = '127.0.0.1'
local dbUser = 'root'
local dbPassword = ''
local dbName = 'o7x'
local dbPort = 3306

addEventHandler('onResourceStart' , resourceRoot , function ()
    db = dbConnect('mysql' ,
     "dbname="..dbName..
     ";host=" ..dbHost .. 
     ';port'..dbPort , dbUser , 
     dbPassword )
     if db == false then return outputServerLog('Faild ocnnection to DB (MYSQL)') end
     outputServerLog('\n Server Connected Sucessfuly to MYSQL \n' .. 'Host: ' .. dbHost .. '\nUser: ' .. dbUser .. '\nName: ' .. dbName .. '\nPROT: ' .. dbPort)
end)


function getConnect() 
    return db
end

