feature 'Booking request'  do

  scenario 'user can click on an item in the space list and see more information' do
    sign_up
    list_a_space
    visit '/spaces'
    click_link '1 bed flat'
    expect(current_path).to eq('/spaces/details/1')
    expect(page).to have_content('cozy flat in central London')
  end

  scenario 'user can enter prefered date and request a space' do
    expect { request_space }.to change(Request, :count).by(1)
    expect(current_path).to eq('/requests')
    expect(page).to have_content('Requests')
  end

  scenario 'raises error if booking date is blank' do
    expect { request_space(check_in_date: '') }.not_to change(Request, :count)
    expect(page).to have_content('Check in date must not be blank')
  end

  scenario 'raises error if date selected is not within range of available dates' do
    expect { request_space(check_in_date: '01/01/2990') }.not_to change(Request, :count)
    expect(page).to have_content('Check in date must be within available dates')
  end
end
