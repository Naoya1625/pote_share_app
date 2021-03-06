class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :configure_permitted_parameters
  before_action :current_user?, only: [:account, :profile]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def account
    redirect_to root_url unless @user = current_user
  end
  
  def profile
    @user = current_user
  end


  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end




  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

    # ユーザ情報更新にはパスワードを必要としない
    def update_resource(resource, params)
      if params[:password].blank? && params[:password_confirmation].blank?
        resource.update_without_password(params)
      else
        super
      end
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :introduction])
    end

    #ユーザ情報更新後のリダイレクト先変更
    def after_update_path_for(resource)
      users_profile_path
    end

    #ストロングパラメータにカラム追加
    def configure_permitted_parameters
      added_attrs = [ :email, :name, :password, :password_confirmation, :image, :introduction]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end

    private 
      def current_user?
        unless current_user
          redirect_to new_user_session_url 
        end
      end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
