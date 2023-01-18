class Role < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: false }

    has_many :users, dependent: :destroy
end