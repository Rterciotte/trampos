class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :password, :password_confirmation, company_attributes: [:name, :logo, :address, :cnpj, :site, :social_media, :domain] ])
    end
end
