class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true, length: {maximum: 50}
    validates :password, presence: true, length: {minimum: 6}
    validates :email, presence: true, length: {maximum: 260}, format: {with: URI::MailTo::EMAIL_REGEXP}, uniqueness: {case_sensitive: false}
    before_save { self.email = email.downcase }

    belongs_to :role, foreign_key: 'role_id'
end
