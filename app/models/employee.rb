class Employee < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :company                  
  accepts_nested_attributes_for :company

  after_initialize do
    build_company if new_record?
  end
end
