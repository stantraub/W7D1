class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      
      login(@user)
      redirect_to cats_url
    else
      
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

def show
  @user = User.find(params[:id])
  @user
end

def index
  @users = User.all
  @users
end

# def destroy
#   @user.find(params[:id])
#   @user.destro
# end

private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
