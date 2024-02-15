local db = exports.db:getConnect()

function insertFakeData () 
    local username = tostring("moka")
    local old_password = tostring("123")
    local email = tostring("msohamed.ofic@gmail.com")
    
    local password = passwordHash(old_password , 'bcrypt' , {} )
    dbExec(db , 'INSERT INTO accounts ( username , password , email) VALUES (?,?,?)'  , username , password , email)
    outputChatBox('done' , source)
end

-- insertFakeData()