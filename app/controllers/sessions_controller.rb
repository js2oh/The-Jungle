class SessionsController < ApplicationController
  def new
  end

  def create
    # @user = User.find_by email: params[:email]

    # # If the user exists AND the password entered is correct.
    # if @user && @user.authenticate(params[:password])
    #   # Save the user id inside the browser cookie. This is how we keep the user
    #   # logged in when they navigate around our website.
    #   session[:user_id] = @user.id
    #   redirect_to '/'
    # else
    #   redirect_to '/login', notice: "Login failed!"
    # end

    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login', notice: "Login failed!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
