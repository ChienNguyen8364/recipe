class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to users_path, alert: "Không thể chỉnh sửa thông tin của người khác"
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Đã chỉnh sửa'
    else
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :profile, :profile_image)
  end

end
