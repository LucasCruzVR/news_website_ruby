json.call(@user, :id, :name, :email, :biography)
json.role do
    json.call(@user.role, :id, :name)
end
json.token @token
json.time_duration @time