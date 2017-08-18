require 'rails_helper'

RSpec.feature 'Authns', type: :feature, js: true do
  include_context 'db_cleanup_each'
  let(:user_props) { FactoryGirl.attributes_for(:user) }

  feature 'sign-up' do
    context 'valid registration' do
      scenario 'creates account and navigates away from signup page' do
        start_time = Time.now
        signup(user_props)

        # Check we re-directed to home page
        expect(page).to have_no_css('#signup-form')
        # Check the DB for the existance of the User account
        user = User.where(email: user_props[:email]).first
        # Make sure we were the ones that created it
        expect(user.created_at).to be > start_time
      end
    end

    context 'rejected registration' do
      before(:each) do
        signup user_props
        expect(page).to have_no_css("#signup-form")
      end
      scenario 'account not created and stays on page' do
        dup_user = FactoryGirl.attributes_for(:user, email: user_props[:email])
        signup dup_user, false # should get rejected by server

        # account not created
        expect(User.where(email: user_props[:email], name: user_props[:name])).to exist
        expect(User.where(email: dup_user[:email], name: dup_user[:name])).to_not exist

        expect(page).to have_css("#signup-form")
        expect(page).to have_button("Sign Up")
      end
      scenario 'displays error messages' do
        bad_props = FactoryGirl.attributes_for(:user, email: user_props[:email], password: "123").merge(password_confirmation: "abc")
        signup bad_props, false

        # displays error information
        expect(page).to have_css("#signup-form > span.invalid", text: "Password confirmation doesn't match Password")
        expect(page).to have_css("#signup-form > span.invalid", text: "Password is too short")
        expect(page).to have_css("#signup-form > span.invalid", text: "Email has already been taken")
        expect(page).to have_css("#signup-email > span.invalid", text: "has already been taken")
        expect(page).to have_css("#signup-password > span.invalid", text: "too short")
        within("#signup-password_confirmation") do
          expect(page).to have_css("span.invalid", text: "doesn't match")
        end
      end
    end

    context 'invalid field' do
      after(:each) do
        within("#signup-form") do
          expect(page).to have_button("Sign Up", disabled: true)
        end
      end
      scenario 'bad email' do
        filling_signup FactoryGirl.attributes_for(:user, email: "aasdkjanskdjas")
        expect(page).to have_css("input[name='signup-email'].ng-invalid-email")
      end
      scenario 'missing password' do
        filling_signup FactoryGirl.attributes_for(:user, password: nil)
        expect(page).to have_css("input[name='signup-password'].ng-invalid-required")
        expect(page).to have_css("input[name='signup-password_confirmation'].ng-invalid-required")
      end
    end

  end

  feature 'anonymous user' do
    scenario 'show login form' do
      visit root_path
      click_on("Login")
      expect(page).to have_no_css("#logout-form")
      expect(page).to have_css("#login-form")
    end
  end

  feature 'login' do
    before(:each) do
      signup user_props
      login user_props
    end

    context 'valid user login' do
      scenario 'closes form and displays current user name' do
        expect(page).to have_css("#navbar-loginlabel", text: /#{user_props[:name]}/)
        expect(page).to have_no_css("#login_form")
        expect(page).to have_no_css("#logout_form")
      end
      scenario 'menu shows logout option with identity' do
        find("#navbar-loginlabel").click
        expect(page).to have_css("#user_id", text: /.+/, visible: false)
        expect(page).to have_css("#logout-identity label", text: user_props[:name])
        within("#logout-form") do
          expect(page).to have_button("Logout")
        end
      end
      scenario 'can access authenticated resources'
    end

    context 'invalid user login' do
      scenario 'error message displayed and leaves user unauthenticated'
    end
  end

  feature 'logout' do
    backgroud(:each) do
      signup user_props
      login user_props
    end
    scenario 'closes form and removes user name' do
      login_criteria = ["#navbar-loginlabel", text: "Login"]
      user_name_criteria = ["#navbar-loginlabel", text: /#{user_props[:name]}/]
      user_id_criteria = ["#user_id", visible: false]

      expect(page).to have_no_css(*login_criteria)
      expect(page).to have_css(*user_name_criteria)
      expect(page).to have_css(*user_id_criteria)

      #logout
      find("#navbar-loginlabel").click
      find_button("Logout").click
      #dropdown goes away
      expect(page).to have_no_css("#login-form")
      expect(page).to have_no_css("#logout-form")
    end
    scenario 'can no longer access authenticated resources'
  end
end
