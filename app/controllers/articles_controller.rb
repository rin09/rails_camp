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
  end

  def show
    @articles = Article.all
  	@article = Article.find(params[:id])
  	@user = User.find_by(id: @article.user_id)

    @daily_pageviews = Hash.new
    today = Date.today.to_s

    # その日のpv数
    @articles.each do |a|
      @daily_pageviews[a.id] = REDIS.get "articles/daily/#{today}/#{a.id}"
    end

    #redis
    REDIS.zincrby "articles/daily/#{Date.today.to_s}", 1, @article.id
    REDIS.incr "articles/daily/#{Date.today.to_s}/#{@article.id}"

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

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update_attributes(article_params)
      flash[:success] = "ポストが更新されました"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.present?
    @article.destroy
    flash[:success] = "Article deleted"
    redirect_to '/'
  end
  end

  private

  	def article_params
  		params.require(:article).permit(:content, :title).merge(user_id: current_user.id)
    end

end
