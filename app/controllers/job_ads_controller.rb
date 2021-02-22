class JobAdsController < ApplicationController
    def index
      @job_ads = JobAd.all
    end

    def show
      @job_ads = JobAd.find(params[:id])
    end

    def new
      @job_ads = JobAd.new()
    end
    
    def create
      @job_ads = JobAd.new(job_ad_params)
      if @job_ads.save
        redirect_to @job_ads
      else
        render :new
      end             
    end

    protected

    def job_ad_params
      params.require(:job_ad)
            .permit(:title, :description, :salary_range, :level, :site, :mandatory_requirements, :total_vacancy)
            .merge(employee_id: current_employee.id)
            .merge(company_id: @company.id)
    end
end