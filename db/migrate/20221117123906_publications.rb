class Publications < ActiveRecord::Migration[6.1]
  def change
    create_table :publications, comment: 'Website posts and news' do |t|
      t.string :title, :null => false, comment: 'Publication title'
      t.string :title_description, :null => false, comment: 'Simple title description text'
      t.text :content, comment: 'Publication content'
      t.string :image, comment: 'Image to reference publication'
      t.boolean :active, default: true
      t.references :category, foreign_key: { to_table: :categories }, comment: 'Category ID'
      t.timestamps
    end
  end
end
