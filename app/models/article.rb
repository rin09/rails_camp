class Article < ApplicationRecord
  attr_accessor :post 
  belongs_to :user, optional: true
  has_one :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true, length: {maximum: 500 }

  def self.most_popular
  	ids = REDIS.zrevrangebyscore "articles/daily/#{Date.today.to_s}", "+inf", 0, limit: [0, 4]
    where(id: ids).sort_by{ |article| ids.index(article.id.to_s) }
  end


end
