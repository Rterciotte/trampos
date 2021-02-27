# frozen_string_literal: true

class Employees::RegistrationsController < Devise::RegistrationsController
 
  # before_filter :configure_permitted_parameters

  def new
    @employee = Employee.new(employee_params)
     @company = Company.new(employee_params)
    build_resource({})
    resource.build_company
    respond_with self.resource
  end
  
  def create
    @employee = Employee.new(employee_params)
    @company = Company.new(employee_params)
    if @employee.save
      sign_in(@employee)
      if domain_is_free?(@employee.email)
        @company.save
        redirect_to @company
      end
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

  def domain_is_free?(email)
    !Company.exists?(['domain LIKE ?', "%#{email.split('@').last}%"])
  end

  def employee_params
    params.require(:employee)
          .permit(:email, :password, :password_confirmation, company_attributes: [:name, :logo, :address, :cnpj, :site, :social_media, :domain])
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) { |u|
  #     u.permit(:email, :password, :password_confirmation, :company_attributes=> :name, :logo, :address, :cnpj, :site, :social_media, :domain)
  #   }
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
