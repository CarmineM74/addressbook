class UsersController < ApplicationController
  respond_to :json

  def index
    @users = User.all
    respond_with(@users)
  end

  def create
    @user = User.new()
    @user.email = params[:email]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      respond_with(@user)
    else
      respond_with({error: 'cannot create user'})
    end
  end

  def update
    @user = User.find(params[:id])
    @user.email = params[:email]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      respond_with(@user)
    else
      respond_with({error: 'cannot find user'})
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      respond_with({})
    else
      respond_with({error: 'cannot destroy user'})
    end
  end

end
