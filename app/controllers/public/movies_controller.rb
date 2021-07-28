class Public::MoviesController < Public::ApplicationController
  before_action :authenticate_customer!,except: [:index]

  def index
    if params["search"].present?
      @movies = search_for.page(params[:page]).reverse_order
    elsif params["sort"].present? && params["sort"]["how"] == "ASC"
      @movies = Movie.all.page(params[:page])
    else
      @movies = Movie.all.page(params[:page]).reverse_order
      @genre = Genre.all
    end
  end

  def new
    @movie = current_customer.movies.new
    @genres = Genre.all
  end

  def create
    @movie = current_customer.movies.new(movie_params)
    if @movie.save
     redirect_to movies_path, flash: {success: "新規投稿が成功しました"}
    else
     @genres = Genre.all
     redirect_to new_movie_path, flash: {warning: "新規投稿に失敗しました"}
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @movie = Movie.find(params[:id])
    @genres = Genre.all
  end

  def update
    movie = Movie.find(params[:id])
    if movie.update(movie_params)
      redirect_to movies_path(movie),flash: {success: "編集が成功しました"}
    else
      @genres = Genre.all
      redirect_to edit_movie_path(movie.id), flash: {warning: "編集に失敗しました"}
    end
  end

  def destroy
    movie = Movie.find(params[:id])
    movie.destroy
    redirect_to request.referer, flash: {error: "投稿を削除しました"}
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :genre_id, :original, :evaluation, :text)
  end

  def match(value)
    Movie.where(title: value, original: value)
  end

  def forward(value)
    Movie.where("title LIKE ?", "#{value}%").where("original LIKE ?", "#{value}%")
  end

  def backward(value)
    Movie.where("title LIKE ?", "%#{value}").where("original LIKE ?", "#{value}%")
  end

  def partical(value)
    Movie.where("title LIKE ?", "%#{value}%").where("original LIKE ?", "#{value}%")
  end

  def search_for
    value = params["search"]["value"]
    case params["search"]["how"]
    when 'match'
      match(value)
    when 'forward'
      forward(value)
    when 'backward'
      backward(value)
    when 'partical'
      partical(value)
    end
  end

end
