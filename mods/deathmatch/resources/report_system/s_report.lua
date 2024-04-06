local db = exports.db.getConnect()



addEvent('fetch:status' , true)
addEventHandler('fetch:status', resourceRoot , function (username) 

    local ActiveADM =  dbPoll(dbQuery(db , 'SELECT COUNT(username) AS result FROM accounts WHERE privilage >=2') , -1)
    local USERID =  dbPoll(dbQuery(db , 'SELECT ID FROM accounts WHERE `username` = ?' , username) , -1)
    local player = client

    triggerClientEvent(player , 'bulid:gui',resourceRoot ,ActiveADM[1].result , USERID[1].ID  )


end)



addEvent('send:report' , true)
addEventHandler('send:report' , resourceRoot , function (reportMsg , type , reporterID) 
outputServerLog(reportMsg  )
outputServerLog(type  )
outputServerLog(reporterID  )

end)