class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :new]

  def index
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

  def show
  	@article = Article.find(params[:id])
  	@user = User.find_by(id: @article.user_id)

    @daily_pageviews = Hash.new
    today = Date.today.to_s

    # その日のpv数
    @articles.each do |a|
      @daily_pageviews[a.id] = REDIS.get "articles/daily/#{today}/#{a.id}"
    end
    # PV数1位から4位までの記事を取得

    ids = REDIS.zrevrangebyscore "articles/daily/#{Date.today.to_s}", "+inf", 0, limit: [0, 4]
    @rank = Article.where(id: ids).sort_by{ |article| ids.index(article.id.to_s) }

    #redis
    REDIS.zincrby "articles/daily/#{Date.today.to_s}", 1, @article.id
    REDIS.incr "articles/daily/#{Date.today.to_s}/#{@article.id}"


    # その日のpv数
    @pv = REDIS.get "articles/daily/#{Date.today.to_s}/#{@article.id}"
    
    # PV数1位から4位までの記事を取得

  end

  def new
  	@article = Article.new
  end

  def create
  	@article = Article.new(article_params)
  	if @article.save
  		flash[:success] = "ポストを投稿しました！"
  		redirect_to root_url
	else
  		render 'new'
  	end
  end

  private

  	def article_params
  		params.require(:article).permit(:content, :title).merge(user_id: current_user.id)
    end
end
