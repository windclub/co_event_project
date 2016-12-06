class SessionsController < ApplicationController
  def new
  end

  def create
    u = User.find_by_email(params[:email])
      if (u && u.authenticate(params[:password]))
        session[:user] = u.id
        redirect_to '/home'
      else
        flash[:error] = "Invalid login information"
        redirect_to :back
      end
  end

end
