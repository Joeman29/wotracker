  ENV["RAILS_ENV"] = 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'factory_girl_rails'
  require 'capybara/rspec'
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  Capybara.javascript_driver = :webkit

#Capybara use the same connection
#  class ActiveRecord::Base
#    mattr_accessor :shared_connection
#    @@shared_connection = nil
#
#    def self.connection
#      @@shared_connection || retrieve_connection
#    end
#  end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
  #ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods
    config.before(:suite) do

      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      if Capybara.current_driver == :webkit
        DatabaseCleaner.strategy = :deletion
      else
        DatabaseCleaner.strategy = :transaction
      end
      DatabaseCleaner.start
    end

    config.after(:each) do
      if Capybara.current_driver == :webkit
        p page.driver.error_messages
      end
      DatabaseCleaner.clean
    end
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    #config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"
    config.formatter = :documentation
  end
  def login(user)
    visit login_path
    fill_in 'Username:', with: user.username
    fill_in 'Password:', with: user.password
    click_button 'Submit'
  end
  def time_to_string(seconds)
    minutesStr = "0#{(seconds/60).to_i}"[-2..-1]
    secondsStr = "0#{(seconds % 60).to_i}"[-2..-1]
    "#{minutesStr}:#{secondsStr}"
  end





