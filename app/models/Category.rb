class Category < ApplicationRecord
  enum status: { inactive: 0, active: 1}, _prefix: :status

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Callbacks
  before_validation :strip_name

  # Associations
  has_many :publications, dependent: :destroy

  def strip_name
    self.name = name&.strip
  end
end
