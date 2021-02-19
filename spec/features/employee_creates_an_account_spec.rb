require 'rails_helper'

feature 'employee creates an account' do
    scenario 'and register company' do
      visit root_path
      click_on 'Cadastrar-se'
      within('form') do
        fill_in 'E-mail', with: 'rogerio@trampos.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        select 'employee', from: 'Função'
        click_on 'Cadastrar'
      end
      expect(page).to have_content 'Não identificamos o domínio trampos, por favor registre-o'  
      expect(page).to have_content 'Cadastre sua empresa'
    end
end