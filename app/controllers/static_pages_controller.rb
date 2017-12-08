class StaticPagesController < ApplicationController
  def top
  	@articles = Article.order('created_at DESC')
  	@daily_pageviews = Hash.new
    today = Date.today.to_s

    # その日のpv数
    @articles.each do |a|
      @daily_pageviews[a.id] = REDIS.get "articles/daily/#{today}/#{a.id}"
    end
    
  end

end
