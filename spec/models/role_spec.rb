require 'rails_helper'

RSpec.describe Role, type: :model do
  context 'validations' do
    subject { FactoryBot.create(:role) }

    it { should validate_presence_of(:name) }
    it 'should be unique' do
      role1 = FactoryBot.create(:role)
      role2 = FactoryBot.build(:role, name: role1.name)
      expect(role2.save).to be_falsey
    end
  end
  context 'callbacks' do
    it 'remove white spaces of name and change to downcase' do
      role = FactoryBot.build(:role, name: '     aDmIn   ')
      role.save
      expect(role.name).to eq('admin')
    end
  end
end
