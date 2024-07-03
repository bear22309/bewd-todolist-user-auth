class User < ApplicationRecord
  # Associations
  has_many :sessions, dependent: :destroy
  has_many :tasks, dependent: :destroy

  # Validations
  validates :username, presence: true, length: { minimum: 3, maximum: 64 }
  validates :password, length: { minimum: 8, maximum: 64 }, allow_nil: true
  validates :username, presence: true, uniqueness: true
  # Optional: additional methods, callbacks, or concerns can be added here
end
