class Article < ApplicationRecord
  attr_accessor :post 
  belongs_to :user, optional: true
  has_one :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true, length: {maximum: 500 }


end
