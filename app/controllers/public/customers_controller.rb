class Public::CustomersController < Public::ApplicationController


  def index
    @customer = current_customer
    @movies = current_customer.movies.page(params[:page]).reverse_order
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
    @movies = @customer.movies.page(params[:page]).reverse_order
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
     redirect_to customers_path(@customer.id), flash: {success: "アカウント情報の編集に成功しました"}
    else
     redirect_to edit_customers_path(@customer.id), flash: {warning: "アカウント情報の編集に失敗しました"}
    end
  end

  def erase
  end

  def close
    current_customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, flash: {error: "ありがとうございました。またのご利用をお待ちしております。"}
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :profile_image, :original, :introduction, )
  end


end
