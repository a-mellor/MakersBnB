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

def list_a_space
  visit '/spaces/new'
  expect(page.status_code).to eq 200
  fill_in 'description', with: 'cozy flat in central London'
  fill_in 'name', with: '1 bed flat'
  fill_in 'price', with: '100'
  click_button 'List this space'
end

def log_in
  visit('sessions/new')
  fill_in(:email, with: 'sdawes@gmail.com')
  fill_in(:password, with: 'password')
  click_button('Log in')
end
