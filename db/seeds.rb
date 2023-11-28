require 'json'

data = JSON.parse(File.read('db/categories.json'))

def create_category(data, parent = nil)
  category = Category.create(
    title: data['title'],
    description: data['description'],
    parent_id: parent&.id
  )
  data['subcategories']&.each { |subdata| create_category(subdata, category) }
end

data.each { |category_data| create_category(category_data) }