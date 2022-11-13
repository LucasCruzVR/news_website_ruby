class Category < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  before_validation :strip_name

  # Associations
  # has_many :publications_categories, dependent: :destroy
  # has_many :publications, through: :publications_categories

  def strip_name
    self.name = name&.strip
  end
end
