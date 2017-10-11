feature 'User registers' do
  scenario 'with valid details', js: true do
    visit '/'

    click_link 'Sign up'
    expect(current_path).to eq(new_user_registration_path)

    fill_in 'Email', with: 'tester@example.tld'
    fill_in 'Password', with: 'A1testpassword'
    fill_in 'Confirm Password', with: 'A1testpassword'
    click_button 'Sign up'

    expect(page).to have_content 'You have signed up successfully.'
    expect(page).to have_current_path('/')
  end

  context 'with invalid details' do
    before do
      visit new_user_registration_path
    end

    scenario 'blank fields' do
      expect_fields_to_be_blank

      click_button 'Sign up'

      expect(page).to have_content "Email can't be blank"
    end

    scenario 'incorrect Confirm Password' do
      fill_in 'Email', with: 'tester@example.tld'
      fill_in 'Password', with: 'test-password'
      fill_in 'Confirm Password', with: 'not-test-password'
      click_button 'Sign up'

      expect(page).to have_content "PasswordPassword confirmation doesn't match Password"
    end

    scenario 'already registered email' do
      create(:user, email: 'dave@example.tld')

      fill_in 'Email', with: 'dave@example.tld'
      fill_in 'Password', with: 'test-password'
      fill_in 'Confirm Password', with: 'test-password'
      click_button 'Sign up'

      expect(page).to have_content 'Email has already been taken'
    end

    scenario 'invalid email' do
      fill_in 'Email', with: 'invalid-email-for-testing'
      fill_in 'Password', with: 'test-password'
      fill_in 'Confirm Password', with: 'test-password'
      click_button 'Sign up'

      expect(page).to have_content 'Email is invalid'
    end
  end

  def expect_fields_to_be_blank
    expect(page).to have_field('Email', with: '', type: 'email')
    expect(find_field('Password', type: 'password').value).to be_nil
    expect(find_field('Confirm Password', type: 'password').value).to be_nil
  end
end