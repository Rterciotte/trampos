# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  
  before_action :configure_sign_up_params
  
  def after_sign_up_path_for(resource)
    domain = resource.gsub(/.+@([^.]+).+/, '\1')
    if @user.role == 'employee' && domain_is_free?(domain)
      redirect_to new_company_path
      flash[:notice] = "Não identificamos o domínio #{domain}, por favor registre-o"
    else
      redirect_to new_user_session_path
    end
  end
   
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @user = User.new(user_params)
    if @user.save
      after_sign_up_path_for(@user.email)
    else
      render :new
    end    
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
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

  # def get_domain
  #   self.gsub(/.+@([^.]+).+/, '\1')
  # end

  def domain_is_free?(user_mail)
    !Company.exists?(['domain LIKE ?', "%#{user_mail.gsub(/.+@([^.]+).+/, '\1')}%"])
  end 

  def user_params
    params.require(:user)
        .permit(:email, :password, :password_confirmation, :role )
  end
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :password_confirmation])
  end

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
