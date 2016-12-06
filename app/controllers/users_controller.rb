class UsersController < ApplicationController

  def index
    @current_user = User.find(session[:user])
  end

  def new

  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save
      session[:user] = user.id
      redirect_to '/login'
    else
      flash[:errors] = user.errors.full_messages
      redirect_to '/'
    end
    # u = User.new(user_params)
    # if u.save
    #   redirect_to :root
    # end
  end

  def logout
    session.delete(:user)
    redirect_to '/login'
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password)
    end
end
