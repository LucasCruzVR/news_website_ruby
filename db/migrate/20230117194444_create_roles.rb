class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles, comment: 'User roles' do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
