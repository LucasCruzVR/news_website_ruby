require 'rails_helper'

RSpec.describe Publication, type: :model do
  context 'validations' do
    subject { FactoryBot.create(:publication) }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:title_description) }
    it 'should be unique' do
      publication1 = FactoryBot.create(:publication)
      publication2 = FactoryBot.build(:publication, title: publication1.title)
      expect(publication2.save).to be_falsey

      publication1 = FactoryBot.create(:publication)
      publication2 = FactoryBot.build(:publication, title_description: publication1.title_description)
      expect(publication2.save).to be_falsey
    end
  end
  context 'callbacks' do
    it 'remove white spaces of name' do
      category = FactoryBot.build(:publication, title: '     publication title   ')
      category.save
      expect(category.title).to eq('publication title')
    end
  end
end
