module Accessible
    extend ActiveSupport::Concern
    included do
      before_action :check_user
    end
  
    protected
    def check_user
      if current_applicant
        flash.clear
        redirect_to(root_path) and return
      elsif current_employee
        flash.clear
        # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
        redirect_to(root_path) and return
      end
    end
  end