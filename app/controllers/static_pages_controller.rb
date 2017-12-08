class StaticPagesController < ApplicationController
  def top
  	@articles = Article.order('created_at DESC')
  	@daily_pageviews = Hash.new
    today = Date.today.to_s

    # その日のpv数
    @articles.each do |a|
      @daily_pageviews[a.id] = REDIS.get "articles/daily/#{today}/#{a.id}"
    end
    # PV数1位から4位までの記事を取得

    ids = REDIS.zrevrangebyscore "articles/daily/#{Date.today.to_s}", "+inf", 0, limit: [0, 4]
    @rank = Article.where(id: ids).sort_by{ |article| ids.index(article.id.to_s) }
    
  end

end
