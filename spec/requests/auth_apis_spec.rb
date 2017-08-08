require 'rails_helper'

RSpec.describe "Authentication Api", type: :request do
  include_context 'db_cleanup_each', :transaction
  let(:user_props) { FactoryGirl.attributes_for(:user) }

  context 'sign-up' do
    context 'valid registration' do
      it 'successfully creates account' do
        signup(user_props)

        payload = parsed_body
        expect(payload).to include('status'=> 'success')
        expect(payload).to include('data')
        expect(payload['data']).to include('id')
        expect(payload['data']).to include('provider'=> 'email')
        expect(payload['data']).to include('uid'=> user_props[:email])
        expect(payload['data']).to include('name'=> user_props[:name])
        expect(payload['data']).to include('email'=> user_props[:email])
        expect(payload['data']).to include('created_at' , 'updated_at')
      end
    end

    context 'invalid registration' do
      context 'missing information' do
        it 'reports error with messages' do
          signup(user_props.except(:email), :unprocessable_entity)

          payload = parsed_body
          expect(payload).to include('status'=> 'error')
          expect(payload).to include('data')
          expect(payload['data']).to include('email'=> nil)
          expect(payload).to include('errors')
          expect(payload['errors']).to include('email')
          expect(payload['errors']).to include('full_messages')
          expect(payload['errors']['full_messages']).to include(/Email/i)
        end
      end

      context 'non-unique information' do
        it 'reports non-unique e-mail'
      end
    end

    context 'anonymous user' do
      it 'accesses unprotected' do
        get authn_whoami_path
        expect(response).to have_http_status(:ok)
        expect(parsed_body).to eq({})
      end

      it 'fails to access protected resource' do
        get authn_checkme_path
        expect(response).to have_http_status(:unauthorized)
        expect(parsed_body['errors']).to eq(['You need to sign in or sign up before continuing.'])
      end
    end

    context 'login' do
      context 'valid user login' do
        it 'generates access token'
        it 'grants access to resource'
        it 'grants access to resource multiple times'
        it 'logout'
      end

      context 'invalid password' do
        it 'rejects credentials'
      end
    end

  end
end
