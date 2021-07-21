class Public::LikesController < Public::ApplicationController
  before_action :set_customer

  def create
    liker = current_customer.like(@customer)
    if liker.save
      redirect_to @customer, flash: {success: "ユーザーをフォローしました"}
    else
      redirect_to @customer, flash: {warning: "ユーザーのフォローに失敗しました"}
    end
  end

  def destroy
    liker = current_customer.unlike(@customer)
    if liker.destroy
      redirect_to @customer, flash: {error: "ユーザーのフォローを解除しました"}
    else
      redirect_to @customer, flash: {warning: "ユーザーのフォロー解除に失敗しました"}
    end
  end

  private
  def
    @customer = Customer.find(params[:like][:liker_id])
  end

end
