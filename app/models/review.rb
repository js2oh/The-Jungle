class Review < ApplicationRecord

  belongs_to :product
  belongs_to :user

  validates :user_id, uniqueness: {
    scope: :product_id,
    message: "Should not be reviewed by a same user more than once"
  }
  validates :description, presence: true
  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: 0..5
end
