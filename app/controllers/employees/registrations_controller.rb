# frozen_string_literal: true

class Employees::RegistrationsController < Devise::RegistrationsController
      
  def after_sign_up_path_for(resource)
    domain = resource.gsub(/.+@([^.]+).+/, '\1')
    if current_employee && domain_is_free?(domain)
      @employee.admin = true
      @employee.save
      redirect_to new_company_path
      flash[:notice] = "Não identificamos o domínio #{domain}, por favor registre-o"
    else
      redirect_to root_path
    end
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      sign_in(@employee)
      after_sign_up_path_for(@employee.email)
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

  def domain_is_free?(employee_mail)
    !Company.exists?(['domain LIKE ?', "%#{employee_mail.gsub(/.+@([^.]+).+/, '\1')}%"])
  end 

  def employee_params
    params.require(:employee)
        .permit(:email, :password, :password_confirmation )
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
