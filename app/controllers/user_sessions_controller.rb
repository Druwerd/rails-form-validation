class UserSessionsController < ApplicationController
  def new
    @user = User.new(email: saved_email)
  end

  def create
    @user = User.find_by(email: user_params[:email])

    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Login successful"
      redirect_to root_path
    else
      flash[:alert] = "Login failed"
      redirect_to new_user_session_path(email: user_params[:email])
    end
  end

  def destroy
    if current_user.blank? || current_user.id != params[:id].to_i
      render plain: '401 Unauthorized', status: :unauthorized
    else
      session[:user_id] = nil
      redirect_to root_path
    end
  end

  private
  def saved_email
    params.fetch(:email, "")
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
