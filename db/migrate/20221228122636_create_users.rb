class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, comment: 'Users Table' do |t|
      t.string :name, :null => false, comment: 'Name of user'
      t.string :email, :null => false, comment: 'Email of user'
      t.string :password_digest, comment: 'Password of account'
      t.text :biography, comment: 'Text about user'
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
