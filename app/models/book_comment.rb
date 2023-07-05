class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :comment, length: { maximum: 140 }, presence: true
end
