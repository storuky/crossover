class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :update, :avatar, :block, :unblock]
  before_action :check_admin, except: [:index]

  def index
    respond_to do |format|
      format.html
      format.json {
        @users = User.look_for(params[:query])
        response.headers['total_count'] = @users.count

        @users = @users.page(params[:page]).per(30)

        render json: Oj.dump(@users.pluck_fields)
      }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json {
        if @user
          render json: dump(@user)
        else
          render json: {msg: "User not found", redirect_to_url: public_users_path(status: "opened")}
        end

      }
    end
  end

  def edit
    
  end

  def update
    if @user.update(user_params)
      if params[:user][:role]
        @user.roles = []
        @user.add_role(params[:user][:role])
      end
      render json: {msg: "Successfully updated", redirect_to: "admin_users_path"}
    else
      render json: {msg: @user.errors.full_messages.join("; "), errors: @user.errors}, status: 403
    end
  end

  def avatar
    @user.update(avatar: params[:attachments].first)

    render json: [@user.avatar]
  end

  def block
    @user.update(banned: true)
    render json: {msg: "User was successfully blocked"}
  end

  def unblock
    @user.update(banned: false)
    render json: {msg: "User was successfully unblocked"}
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def check_admin
      unless current_user.has_role? :admin
        if request.xhr?
          render json: {msg: "Only admin can edit users!"}, status: 403
        else
          redirect_to admin_users_path
        end
      end
    end
end
