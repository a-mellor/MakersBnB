def sign_up(email: 'test@test.com',
            password: 'password',
            password_confirmation: 'password')
  visit '/users/new'
  expect(page.status_code).to eq 200
  fill_in :email, with: email
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
end

def list_a_space(description: 'cozy flat in central London', name: '1 bed flat', price: '100', available_from: '01/01/2030', available_until: '01/12/2034')
  visit '/spaces/new'
  expect(page.status_code).to eq 200
  fill_in 'description', with: description
  fill_in 'name', with: name
  fill_in 'price', with: price
  fill_in 'available_from', with: available_from
  fill_in 'available_until', with: available_until
  click_button 'List this space'
end
