class Post < ApplicationRecord

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  scope :ordered, -> { order(created_at: :desc) }

end
