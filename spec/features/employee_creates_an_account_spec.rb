require 'rails_helper'

feature 'employee creates an account' do
    
    scenario 'successfully' do
      visit root_path
      click_on 'Cadastrar-se'
      within('form') do
        fill_in 'Email', with: 'rogerio@trampos.com'
        fill_in 'Password', with: '123456'
        fill_in 'Password confirmation', with: '123456'
        select 'employee', from: 'Role'
        click_on 'Sign up'
      end
      expect(page).to have_content 'rogerio@trampos.com'   
    end
    
    scenario 'and register company' do
      user = User.create!(email: 'rogerio@trampos.com', password: '123456', role: 1)
      
     visit root_path
     click_on 'Entrar'
     within('form') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: '123456'
        click_on 'Entrar'
     end   
     expect(current_path).to eq root_path
    end
end