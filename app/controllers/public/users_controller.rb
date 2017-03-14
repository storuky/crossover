class Public::UsersController < Public::ApplicationController
  before_action :check_current_pasword, only: [:update]

  def show
    respond_to do |format|
      format.html
      format.json {
        render json: CurrentUserSerializer.new(current_user)
      }
    end
  end

  def edit

  end

  def update
    if current_user.update(user_params)
      if user_params[:password]
        sign_in(current_user, :bypass => true)
      end
      render json: {msg: "Profile was successfully updated"}
    else
      render json: {msg: current_user.errors.full_messages.join(', ')}, status: 403
    end
  end

  def cancel

  end

  def avatar
    current_user.update(avatar: params[:attachments].first)

    render json: [current_user.avatar]
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def check_current_pasword
      if user_params[:password] && !current_user.valid_password?(params[:user][:current_password])
        render json: {msg: "Current password is incorrect"}
      end
    end

end
