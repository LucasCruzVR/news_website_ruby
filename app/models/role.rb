class Role < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: false }

    before_validation :format_name
    has_many :users, dependent: :destroy

    private
    def format_name
        self.name = name&.strip&.downcase
    end
end