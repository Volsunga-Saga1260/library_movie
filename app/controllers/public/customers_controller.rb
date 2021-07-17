class Public::CustomersController < Public::ApplicationController
  

  def index
    @customer = current_customer
    @movies = current_customer.movies
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
     redirect_to customers_path(@customer.id), flash: {success: "You have updated customer successfully."}
    else
     render "edit"
    end
  end

  def erase
  end

  def close
    current_customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用をお待ちしております。"
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :profile_image, :introduction, )
  end

end
