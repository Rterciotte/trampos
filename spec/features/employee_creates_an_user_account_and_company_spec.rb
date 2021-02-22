require 'rails_helper'

feature 'employee creates an account' do
  scenario 'and is the first to register a domain' do
    visit root_path
    click_on 'Cadastro para colaboradores'

    within('form') do
      fill_in 'E-mail', with: 'rogerio@trampos.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Cadastrar'
    end

    expect(current_path).to eq new_company_path
    expect(page).to have_content 'Não identificamos o domínio trampos, por favor registre-o'  
    expect(page).to have_content 'Cadastre sua empresa'
    expect(page).to have_content 'Você é o Administrador desta empresa'
  end

  scenario 'and register a company' do
    visit root_path
    click_on 'Cadastro para colaboradores'

    within('form') do
      fill_in 'E-mail', with: 'rogerio@trampos.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Cadastrar'
    end
    expect(current_path).to eq new_company_path

    fill_in 'Nome', with: 'Trampos' 
    fill_in 'Logomarca', with: 'trampos.gif'
    fill_in 'Endereço', with: 'Avenida Rio Branco, 300'
    fill_in 'CNPJ', with: '8234-8273-928383'
    fill_in 'Site', with: 'www.trampos.com.br' 
    fill_in 'Mídias Sociais', with: '@trampos_twitter' 
    fill_in 'Domínio', with: 'trampos'

    click_on 'Cadastrar empresa'

    company = Company.last
    expect(current_path).to eq(company_path(company))
  end

  scenario 'and is not the first register of a domain' do
    employee = Employee.create!(email: 'rogerio@email.com', password: '123456', admin: true)
    company = Company.create!(name: 'Trampos', logo: 'trampos.gif', address: 'Avenida Rio Branco, 300', 
                              cnpj: '8234-8273-928383', site: 'www.trampos.com.br', 
                              social_media: '@trampos_twitter', domain: 'trampos', employee_id: employee.id)
    visit root_path

    click_on 'Cadastro para colaboradores'

    within('form') do
      fill_in 'E-mail', with: 'mariana@trampos.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Cadastrar'
    end
    expect(current_path).to eq root_path
  end
end