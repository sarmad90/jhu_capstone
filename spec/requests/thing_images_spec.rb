require 'rails_helper'

RSpec.describe 'ThingImages', type: :request do
  include_context 'db_cleanup_each'
  let(:account) { signup FactoryGirl.attributes_for(:user) }
  let!(:user) { login account }

  describe 'manage thing/image relationships' do
    context 'valid thing and image' do
      let(:thing) { create_resource(things_path, :thing, :created) }
      let(:image) { create_resource(images_path, :image, :created) }
      let(:thing_image_props) {
        FactoryGirl.attributes_for(:thing_image, image_id: image['id'])
      }

      it 'can associate image with thing' do
        #associated the image to the Thing
        jpost thing_thing_images_path(thing['id']), thing_image_props
        expect(response).to have_http_status(:no_content)

        #get ThingImages for Thing and verify associated with Image
        jget thing_thing_images_path(thing['id'])
        expect(response).to have_http_status(:ok)
        #puts response.body
        payload = parsed_body
        expect(payload.size).to eq(1)
        expect(payload[0]['image_id']).to eq(image['id'])
        expect(payload[0]['image_caption']).to eq(image['caption'])
      end

      it 'must have image' do
        jpost thing_thing_images_path(thing['id']), thing_image_props.except(:image_id)
        expect(response).to have_http_status(:bad_request)
        payload = parsed_body
        expect(payload).to include('errors')
        expect(payload['errors']['full_messages']).to include(/param/, /missing/)
      end
    end
  end
end
