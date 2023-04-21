class RegistrationController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    validate_password()
   
    if @user.errors.empty? && @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Successfully created account"
    else
      flash[:alert]= "Invalid email or password"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :confirm_password)
  end

  def validate_password
    if params[:user][:password] != params[:user][:confirm_password]
      @user.errors.add(:confirm_password, "Passwords do not match")
    end
  end
end
