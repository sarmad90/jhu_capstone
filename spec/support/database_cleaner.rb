require 'database_cleaner'

shared_context 'db_cleanup' do |active_record_strategy=:truncation|
  before(:all) do
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner[:active_record].strategy = active_record_strategy
    DatabaseCleaner.clean_with[:truncation]
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

shared_context 'db_scope' do
  before(:each) do
    DatabaseCleaner.start
  end

  after(:each) do
    DatabaseCleaner.clean
  end
end
