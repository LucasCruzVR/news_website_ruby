class Category < ApplicationRecord
  enum status: { inactive: 0, active: 1}, _prefix: :status

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Callbacks
  before_validation :format_string

  # Associations
  has_many :publications, dependent: :destroy

  def format_string
    self.name = name&.strip&.downcase&.capitalize()
  end
end
