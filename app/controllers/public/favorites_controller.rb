class Public::FavoritesController < Public::ApplicationController
  def create
    movie = Movie.find(params[:movie_id])
    favorite = current_customer.favorites.new(movie_id: movie.id)
    favorite.save
    redirect_to movies_path
  end
    
  def destroy
    movie = Movie.find(params[:movie_id])
    favorite = current_customer.favorites.find_by(movie_id: movie.id)
    favorite.destroy
    redirect_to movies_path
  end
end
