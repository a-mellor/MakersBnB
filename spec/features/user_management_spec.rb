feature 'User sign up' do
  scenario 'I can sign up as a new user' do
  visit '/users/new'
  expect(page.status_code).to eq 200
  fill_in :email, with: 'test@test.com'
  fill_in :password, with: 'password'
  click_button 'Sign up'
  end
end
