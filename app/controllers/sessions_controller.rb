class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path
    else
      # Create an error message.
        if params[:session][:email] || params[:session][:password]
          flash.now[:notice] = "Email ou senha inválidos."
        end
        render :new
    end
  end
  
  def destroy 
    log_out
    redirect_to root_path
  end
end
