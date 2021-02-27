class JobAdsController < ApplicationController
    def index
      @job_ads = JobAd.all
    end

    def show
      @job_ads = JobAd.find(params[:id])
    end

    def new
      @company = Company.find(params[:company_id])
      @job_ad = JobAd.new
    end
    
    def create
      @company = Company.find(params[:company_id])
      @job_ad = JobAd.new(job_ad_params)
      if @job_ad.save
        redirect_to @job_ad
      else
        render :new
      end             
    end

    protected

    def job_ad_params
      params.require(:job_ad)
            .permit(:title, :description, :salary_range, :level, :site, :mandatory_requirements, :total_vacancy)
            .merge(employee_id: current_employee.id)
    end        
end

