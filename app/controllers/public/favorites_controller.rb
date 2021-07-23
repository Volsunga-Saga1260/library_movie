class Public::FavoritesController < Public::ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    favorite = @movie.favorites.new(movie_id: current_customer.id)
    favorite.save
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    favorite = @movie.favorites.find_by(movie_id: current_customer.id)
    favorite.destroy
  end
  
  def followings
     customer = Customer.find(params[:customer_id])
     @customers = customer.followings
  end

  def followers
     customer = Customer.find(params[:customer_id])
     @customers = customer.followers
  end
end
