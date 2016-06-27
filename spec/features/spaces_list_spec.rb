feature 'List of spaces' do
  scenario 'user can see a list of spaces' do
    Space.create(name: 'City hideaway', description: 'tidy one bed in central City', price: 100, available_from: Date.new(2016,8,1), available_until: Date.new(2016, 12, 1))
    visit '/spaces'
    expect(page.status_code).to eq 200
    within 'ul#spaces' do
      expect(page).to have_content('City hideaway')
    end
  end
end
