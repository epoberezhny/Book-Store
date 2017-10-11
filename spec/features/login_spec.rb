feature 'User logs in and logs out' do
  scenario 'with correct details', js: true do
    create(:user, email: 'someone@example.tld', password: 'A1somepassword')

    visit '/'

    click_link 'Log in'
    expect(page).to have_css('h3', text: 'Log in')
    expect(page).to have_current_path(new_user_session_path)

    login 'someone@example.tld', 'A1somepassword'

    expect(page).to have_current_path('/')
    expect(page).to have_content 'Signed in successfully'

    click_link 'My account'
    click_link 'Log out'

    expect(page).to have_current_path('/')
    expect(page).to have_content 'Signed out successfully'
  end

  def login(email, password)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end
end