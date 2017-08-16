module UiHelper
  def signup(user_props)
    visit "#{ui_path}/#/signup" unless page.has_css?('#signup-form')
    expect(page).to have_css('#signup-form')

    fill_in('signup-email', with: user_props[:email])
    fill_in('signup-name', with: user_props[:name])
    fill_in('signup-password', with: user_props[:password])
    password_confirm = user_props[:password_confirmation] ||= user_props[:password]

    fill_in('signup-password_confirmation', with: password_confirm)
    click_on('Sign Up')
    expect(page).to have_no_button('Sign Up')
  end
end
