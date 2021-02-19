class Company < ApplicationRecord
    belongs_to :employee, :class_name => "User"
end
