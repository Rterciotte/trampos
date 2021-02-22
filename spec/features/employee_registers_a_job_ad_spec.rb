require 'rails_helper'

feature 'employee register an job ad' do
  scenario 'successfully' do
    employee = Employee.create!(email: 'rogerio@trampos.com', password: '123456')
    company = Company.create!(name: 'Trampos', logo: 'trampos.gif', address: 'Avenida Rio Branco, 300', 
                            cnpj: '8234-8273-928383', site: 'www.trampos.com.br', 
                            social_media: '@trampos_twitter', domain: 'trampos', employee_id: employee.id)

    login_as(employee)
    visit root_path
    click_on 'Empresas cadastradas'
    click_on 'Trampos'
    click_on 'Nova vaga'
    fill_in 'Título', with: 'Desenvolvedor C# Senior'
    fill_in 'Descrição', with: 'Buscamos desenvolvedores com ampla experiência em linguagem C#'
    fill_in 'Faixa salarial', with: 10000
    select 'senior', from: 'Nível' 
    fill_in 'Requisitos obrigatórios', with: 'Experiência em C#, '
    fill_in 'Total de vagas', with: 3
    
    click_on 'Cadastrar vaga'

    job_ad = JobAd.last
    expect(job_ad.employee).to eq employee
    expect(current_path).to eq(job_ad_path(JobAd.last)) 
  end
end  