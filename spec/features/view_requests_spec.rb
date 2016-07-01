feature 'View requests' do
  scenario 'that I have made' do
    sign_up
    list_a_space
    request_space
    expect(current_path).to eq('/requests')
    expect(page).to have_content('1 bed flat')
    expect(page).to have_content('01/09/2030')
  end

end
