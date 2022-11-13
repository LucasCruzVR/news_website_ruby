require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validations' do
    subject { FactoryBot.create(:category) }

    it { should validate_presence_of(:name) }
    it 'should be unique' do
      category1 = FactoryBot.create(:category)
      category2 = FactoryBot.build(:category, name: category1.name)
      expect(category2.save).to be_falsey
    end
  end
  context 'callbacks' do
    it 'remove white spaces of name' do
      category = FactoryBot.build(:category, name: '     article   ')
      category.save
      expect(category.name).to eq('article')
    end
  end
end
