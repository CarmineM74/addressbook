class SessionsController < ApplicationController
  respond_to :json

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      respond_with(user)
    else
      respond_with({error: 'authentication failed'},:status => 401, :location => nil)
    end
  end

  def destroy
    session[:user_id] = nil
    respond_with({message: 'logged off'})
  end

end
