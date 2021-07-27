class Public::RelationshipsController < Public::ApplicationController

  def create
    current_customer.follow(params[:customer_id])
    redirect_to request.referer
  end
  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end
  # followings, followersは省略

  def followings
     @customer = Customer.find(params[:customer_id])
     @customers = @customer.followings.page(params[:page]).reverse_order
  end

  def followers
     @customer = Customer.find(params[:customer_id])
     @customers = @customer.followers.page(params[:page]).reverse_order
  end

end
