class AuthController < ApplicationController
  before_action :redirect_if_signed_in, except: [:logout]
  before_action :verify_recaptcha, only: [:register]

  def login
    user = User.find_for_authentication(email: sign_in_params[:email])
    return render json: {msg: "User not found"}, status: 404 unless user

    if user.valid_password?(sign_in_params[:password])
      user.remember_me = sign_in_params[:remember_me]
      sign_in(user, scope: :user)
      render json: {msg: "Successfully signed in", current_user: serialize(current_user), redirect_to_url: public_requests_path(status: 'opened'), reload: current_user.has_access_to_admin_panel?}
    else
      render json: {msg: "Invalid password"}, status: 403
    end

  end

  def register
    user = User.new(sign_up_params)
    if user.save
      sign_in(user, scope: :user)
      render json: {msg: "Welcome! You have signed up successfully.", current_user: serialize(current_user), redirect_to_url: public_requests_path(status: 'opened'), reload: current_user.has_access_to_admin_panel?}
    else
      render json: {errors: user.errors, msg: user.errors.full_messages.join('; ')}, status: 403
    end
  end

  def logout
    sign_out
    render json: {msg: "Successfully signed out", redirect_to_url: sign_path(type: "in"), reload: params[:reload]}
  end

  def sign
    render template: "auth/sign_#{params[:type]}"
  end

  def set_layout
    "public"
  end

  private
    def sign_in_params
      params.require(:user).permit(:email, :password, :remember_me)
    end

    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def verify_recaptcha
      return true if Rails.env.test?

      result = RestClient.post("https://www.google.com/recaptcha/api/siteverify", secret: Rails.application.secrets[:recaptcha]["secret_key"], response: params[:user][:recaptcha])
      
      unless JSON.parse(result)["success"]
        render json: {msg: "Captcha wrong. Retype it again."}, status: 403
      end
    end

    def redirect_if_signed_in
      if current_user
        if request.xhr?
          render json: {redirect_to: "root_path"}
        else
          redirect_to root_path
        end
      end
    end
end
