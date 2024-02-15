local db
local dbHost = '127.0.0.1'
local dbUser = 'root'
local dbPassword = ''
local dbName = 'o7x'
local dbPort = 3306

addEventHandler('onResourceStart' , resourceRoot , function ()
    db = dbConnect('mysql' , "dbname="..dbName.. ";host=" ..dbHost .. ';port'..dbPort , dbUser , dbPassword )
end)


function getConnect() 
    return db
end