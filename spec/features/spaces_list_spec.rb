feature 'List of spaces' do
  scenario 'user can see a list of spaces' do
    sign_up
    list_a_space
    visit '/spaces'
    expect(page.status_code).to eq 200
    within 'ul#spaces' do
      expect(page).to have_content('1 bed flat')
    end
  end

  scenario 'user add one space' do
    sign_up
    expect{ list_a_space }.to change(Space, :count).by(1)
  end
end
