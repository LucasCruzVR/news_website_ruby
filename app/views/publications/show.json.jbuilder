json.call(@publication, :id, :title, :title_description, :content, :image, :created_at)
json.category do
    json.call(@publication.category, :id, :name)
end