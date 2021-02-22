class JobAd < ApplicationRecord
  has_one :employee
  has_one :company
  has_many :applicants


  enum level: { junior: 0, mid_level: 1, senior: 2 }
end
