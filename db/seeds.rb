puts 'Seeding...'

@role_admin = Role.create!(name: 'admin')
Role.create!(name: 'viewer')

User.create!(name: 'Administrator', email: 'adm@gmail.com', password: '123456', biography: 'user admin', role_id: @role_admin.id)

Category.create!(name: 'Article')
Category.create!(name: 'Technology')
Category.create!(name: 'Game')
Category.create!(name: 'Movie')

puts 'Seeding done!'
