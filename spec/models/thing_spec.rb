require 'rails_helper'

RSpec.describe Thing, type: :model do
  include_context 'db_cleanup'

  context 'build valid thing' do
    it 'default thing created with sample data' do
      thing =  FactoryGirl.build(:thing)
      expect(thing.name).to_not be_nil
      expect(thing.description).to_not be_nil
      expect(thing.notes).to_not be_nil
      expect(thing.save).to be true
    end
  end
end
