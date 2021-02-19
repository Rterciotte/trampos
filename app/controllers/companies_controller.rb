class CompaniesController < ApplicationController
    def index
        @companies = Company.all
    end

    def new
        @company = Company.new()
    end
    
    def create
      @company = Company.new(company_params)
      @company.user = current_user       
      if @company.save
        redirect_to @company
      else
        render :new
      end             
    end
end