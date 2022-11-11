class Category < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  # has_many :publications_categories, dependent: :destroy
  # has_many :publications, through: :publications_categories
end
