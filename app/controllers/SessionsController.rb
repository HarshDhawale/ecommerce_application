class SessionsController<ApplicationController
  def new
  end

  def create
    customer=Customer.find_by(email:params[:session][:email].downcase)
    if customer && customer.authenticate(params[:session][:password])
      session[:user_id]=customer.id
      flash[:notice] = "Logged in succesfully"
      respond_to do |format|
        format.html {redirect_to customer_path(customer),notice:"HELLO #{customer.name}"}
      end
    else
      respond_to do |format|
        format.html {redirect_to login_path,notice:"Username and password are incorrect"}
      end
    end
  end

  def destroy
    session[:user_id]=nil
    flash[:notice]="Logged out!"
    redirect_to root_path
  end
end
