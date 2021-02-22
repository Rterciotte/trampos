require 'rails_helper'

feature 'Emplooyee sign in' do
  scenario 'successfully' do
    employee = Employee.create!(email: 'rogerio@email.com', password: '123456', admin: false)

    visit root_path
    click_on 'Acesso para colaboradores'
    within('form') do
      fill_in 'E-mail', with: employee.email
      fill_in 'Senha', with: '123456'
      click_on 'Acessar'
    end

    expect(page).to have_content employee.email
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Acessar'
  end

  scenario 'and logout' do
    employee = Employee.create!(email: 'rogerio@email.com', password: '123456', admin: false)

    visit root_path
    click_on 'Acesso para colaboradores'
    within('form') do
      fill_in 'E-mail', with: employee.email
      fill_in 'Senha', with: '123456'
      click_on 'Acessar'
    end

    click_on 'Sair'

    within('nav') do
      expect(page).not_to have_link 'Sair'
      expect(page).not_to have_content employee.email
      expect(page).to have_link 'Acesso para colaboradores'
    end

  end
end