json.array! @roles do |role|
    json.call(role, :id, :name)
end