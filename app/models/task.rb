class Task < ApplicationRecord
  belongs_to :user # This sets up the association that each task belongs to a user

  # Validations
  validates :content, length: { maximum: 200 }, presence: true
  validates :user_id, presence: true # Ensures that each task is associated with a user

  # You can add additional methods or associations here if needed
end

