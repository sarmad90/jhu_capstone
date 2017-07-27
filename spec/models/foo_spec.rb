require 'rails_helper'

RSpec.describe Foo, type: :model do
  context 'created Foo' do
    let(:foo) { @foo = Foo.create(name: 'test') }

    it 'will be pesisted, have a name, and be found' do

      expect(foo).to be_persisted
      expect(foo.name).to eq('test')
      expect(Foo.find(foo.id)).to_not be_nil
    end
  end
end
