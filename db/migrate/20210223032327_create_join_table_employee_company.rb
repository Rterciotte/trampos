class CreateJoinTableEmployeeCompany < ActiveRecord::Migration[6.1]
  def change
    create_join_table :employees, :companies do |t|
      t.index [:employee_id, :company_id]
      t.index [:company_id, :employee_id]
    end
  end
end
