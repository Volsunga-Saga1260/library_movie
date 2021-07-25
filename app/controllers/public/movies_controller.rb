class Public::MoviesController < Public::ApplicationController
  before_action :authenticate_customer!,except: [:index]

  def index
    if params["search"].present? && params["search"]["value"].present? && params["search"]["how"].present?
      value = params["search"]["value"]
      how = params["search"]["how"]
      @movies = search_for(how, "movie", value).page(params[:page]).reverse_order
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
     redirect_to new_movie_path, flash: {warning: "投稿に失敗しました"}
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
    redirect_to movies_path
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :genre_id, :original, :evaluation, :text)
  end

  def match(model, value)
    Movie.where(title: value, original: value)
  end

  def forward(model, value)
    Movie.where("title LIKE ?", "#{value}%").where("original LIKE ?", "#{value}%")
  end

  def backward(model, value)
    Movie.where("title LIKE ?", "%#{value}").where("original LIKE ?", "#{value}%")
  end

  def partical(model, value)
    Movie.where("title LIKE ?", "%#{value}%").where("original LIKE ?", "#{value}%")
  end

  def search_for(how, model, value)
    case how
    when 'match'
      match(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      partical(model, value)
    end
  end

end
