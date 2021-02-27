class Company < ApplicationRecord
    belongs_to :employee
    has_many :employees
    has_many :job_ads    
end
