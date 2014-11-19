RSpec.configure do |config|  
  
  # You probably already have this `config.before(:suite) do` block
  config.before(:suite) do
    DatabaseCleaner[:active_record].strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
 
  # ADD THIS!
  # Add this `config.before(:each, js: true) do` block to your spec_helper.rb
  config.before(:each, js: true) do
    # For JavaScript tests ensure we're not using transactions as they're
    # not shared into the phantomjs thread.
    # http://www.railsonmaui.com/tips/rails/capybara-phantomjs-poltergeist-rspec-rails-tips.html
    # http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
    DatabaseCleaner[:active_record].strategy = :truncation
  end
 
  # You probably already have this `config.before(:each) do` block
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.around(:each) do |example|
     DatabaseCleaner.cleaning do
       example.run
     end
  end
end