Rails.application.routes.draw do
  root 'home#index'
  devise_for :employees, path: 'employees', controllers: { registrations: "employees/registrations" }
  devise_for :applicants, path: 'applicants'
  resources :companies
end
