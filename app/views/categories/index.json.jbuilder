json.array! @categories do |category|
    json.call(category, :id, :name)
    json.news_number(category.publications.length)
end