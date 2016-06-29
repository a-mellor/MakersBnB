feature 'Booking request'  do

  scenario 'user can click on an item in the space list and see more information' do
    sign_up
    list_a_space
    visit '/spaces'
    click_link '1 bed flat'
    expect(page).to have_content('cozy flat in central London')
  end

  scenario 'user can enter prefered date and request a space' do
    expect { sign_up 
    list_a_space
    visit '/spaces'
    click_link '1 bed flat'
    fill_in :check_in_date, with: '31/12/2016'
    click_button 'Request space'
    expect(current_path).to eq('/requests')
    expect(page).to have_content('Requests') }.to change(Request, :count).by(1)
  end
end
