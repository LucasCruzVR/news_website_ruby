class Categories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories, comment: 'Categories of news' do |t|
      t.string :name, null: false, unique: true, comment: 'Category name'
      t.timestamps
    end
  end
end
