json.array! @publications do |publication|
    json.call(publication, :id, :title, :title_description, :image, :created_at)
    json.category do
        json.call(publication.category, :id, :name)
    end
end