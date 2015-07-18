require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before do
    Spree::Preferences::Store.instance.clear_cache
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end
