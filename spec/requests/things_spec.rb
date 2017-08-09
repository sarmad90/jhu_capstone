require 'rails_helper'

RSpec.describe "Things", type: :request do
  include_context 'db_cleanup_each'
  let(:account) { signup FactoryGirl.attributes_for(:user) }

  context 'quick API check' do
    let!(:user) { login account }

    it_should_behave_like 'resource index', :thing
    it_should_behave_like 'show resource', :thing
    it_should_behave_like 'create resource', :thing
    it_should_behave_like 'modifiable resource', :thing
  end

  shared_examples 'cannot create' do
    it 'create fails' do
      jpost things_path, thing_props
      expect(response.status).to be >= 400
      expect(response.status).to be < 500
      expect(parsed_body).to include('errors')
    end
  end

  shared_examples 'can create' do
    it 'can create' do
      jpost things_path, thing_props
      expect(response).to have_http_status(:created)
      payload = parsed_body
      expect(payload).to include('id')
      expect(payload['name']).to eq(thing_props[:name])
    end
  end

  shared_examples 'all fields present' do
    it 'last has all fields' do
      jget things_path
      expect(response).to have_http_status(:ok)
      payload = parsed_body
      expect(payload.size).to_not eq(0)
      payload.each do |r|
        expect(r).to include('id')
        expect(r).to include('name')
      end
    end

    it 'get has all fields' do
      jget thing_path(thing.id)
      expect(response).to have_http_status(:ok)
      payload = parsed_body
      expect(payload['id']).to eq(thing.id)
      expect(payload['name']).to eq(thing.name)
    end
  end

  describe 'access' do
    let(:things_props) { (1..3).map { FactoryGirl.attributes_for(:thing) } }
    let(:thing_props) { things_props[0] }
    let!(:things) { Thing.create(things_props) }
    let(:thing) { things[0] }

    context 'unauthenticated caller' do
      before(:each) { logout nil }
      it_should_behave_like 'cannot create'
    end

    context 'authenticated caller' do
      let!(:user) { login account }
      it_should_behave_like 'can create'
      it_should_behave_like 'all fields present'
    end
  end
end
