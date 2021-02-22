class Employee < ApplicationRecord
    extend ActiveModel::Callbacks

  before_create :action_before_create(employee)
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  define_model_callbacks :create

  def action_before_create(employee)
    if !Company.exists?(['domain LIKE ?', "%#{employee.email.gsub(/.+@([^.]+).+/, '\1')}%"])
      @company = Company.create!(name: 'Exemplo', logo: 'Exemplo.gif', address: 'Exemplo', 
                            cnpj: '0000000000000', site: 'www.exemplo.com.br', 
                            social_media: '@exemplo_twitter', domain: employee.email.gsub(/.+@([^.]+).+/, '\1'), employee_id: employee.id )
    end                        
  end

         
end
