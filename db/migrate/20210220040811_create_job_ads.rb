class CreateJobAds < ActiveRecord::Migration[6.1]
  def change
    create_table :job_ads do |t|
      t.string :title
      t.text :description
      t.integer :salary_range
      t.integer :level
      t.date :mandatory_requirements
      t.integer :total_vacancy
      t.references :company, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
