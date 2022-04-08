# frozen_string_literal: true

# @see https://github.com/teamcapybara/capybara#using-capybara-with-rspec

describe 'the voting process', type: :feature do
  before do
    @proposal = create(:proposal)
  end

  it 'displays a sign in button' do
    visit '/proposals'
    expect(page).to have_content('Sign In to Vote')
  end

  it 'signs in' do
    user = create(:user)

    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'has a Cast Vote button after login' do
    login_as(build(:user))
    visit '/proposals'
    expect(page).to have_content('Cast Vote')
  end

  describe 'The AJAX voting system', js: true do
    # see https://github.com/heartcombo/devise/wiki/How-To:-Test-with-Capybara#capybara-webkit
    before do
      user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')
      login_as(user, scope: :user, run_callbacks: false)
    end

    it 'can cast a vote', js: true do
      visit '/'

      click_on('Cast Vote')
      expect(page).to have_content('Undo Vote')
    end

    it 'increments the vote count' do
      visit '/'
      click_link('Cast Vote')
      expect(page).to have_content('1 Like')
    end

    it 'decriments the vote count' do
      visit '/'
      click_link('Cast Vote')
      click_link('Undo Vote')
      expect(page).to have_content('0 Likes')
    end

    it 'can undo a vote' do
      visit '/'
      click_link('Cast Vote') # cast a vote
      click_link('Undo Vote')
      expect(page).to have_content('Cast Vote')
    end
  end
end
