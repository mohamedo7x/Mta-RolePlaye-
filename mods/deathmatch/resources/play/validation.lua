




function validateEmail(email)
    local pattern = "^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+%.[A-Z|a-z]{2,4}$"
    return string.match(email, pattern) ~= nil
end


function validPasswordSame (password , n_password) 
    if #password >= 20 or #password < 5 then
        return false
    end
    if type(password) ~="string" then 
        return 
    end
    if password ~= n_password then 
        return false
    end 
    return true
end


function validUsername (username) 
    if #username >= 10 or #username < 3 then
        return false
    end

    if type(username) ~="string" then 
        return 
    end

    return true
end


function validPassword (password) 
    if #password >= 20 or #password < 5 then
        return false
    end
    if type(password) ~="string" then 
        return 
    end
    return true
end