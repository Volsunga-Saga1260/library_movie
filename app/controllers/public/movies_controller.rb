class Public::MoviesController < Public::ApplicationController
  before_action :authenticate_customer!,except: [:index]

  def index
    if params["search"].present? && params["search"]["value"].present? && params["search"]["how"].present?
      value = params["search"]["value"]
      how = params["search"]["how"]
      @movies = search_for(how, "movie", value)
    else
      @movies = Movie.all
      @genre = Genre.all
    end
  end

  def new
    @movie = current_customer.movies.new
    @genres = Genre.all
  end

  def create
    @movie = current_customer.movies.new(movie_params)
    @movie.save
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    movie = Movie.find(params[:id])
    movie.update(movie_params)
    redirect_to movies_path(movie)
  end

  def destroy
    movie = Movie.find(params[:id])
    movie.destroy
    redirect_to movies_path
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :genre_id, :original, :text)
  end

  def match(model, value)
    Movie.where(title: value)
  end

  def forward(model, value)
    Movie.where("title LIKE ?", "#{value}%")
  end

  def backward(model, value)
    Movie.where("title LIKE ?", "%#{value}")
  end

  def partical(model, value)
    Movie.where("title LIKE ?", "%#{value}%")
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
