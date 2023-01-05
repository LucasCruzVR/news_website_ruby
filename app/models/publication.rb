class Publication < ApplicationRecord
  #attr_accessor :image_file
  has_one_attached :image_file

  enum status: { inactive: 0, active: 1}

  # Validations
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :title_description, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  belongs_to :category, foreign_key: 'category_id'

  # Callbacks
  before_validation :strip_title

  def strip_title
    self.title = title&.strip
    self.title_description = title_description&.strip
  end
end
