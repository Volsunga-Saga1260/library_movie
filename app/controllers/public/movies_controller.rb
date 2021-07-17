class Public::MoviesController < Public::ApplicationController
  before_action :authenticate_customer!,except: [:index]
  
  def index
    @movies = Movie.all
  end

  def new
    @movie = current_customer.movies.new
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
    params.require(:movie).permit(:title, :original, :text)
  end

end
