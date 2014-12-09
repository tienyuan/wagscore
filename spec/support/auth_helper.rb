module AuthHelpers
  def set_auth
    Warden.test_mode!
  end

  def clear_auth
    Warden.test_reset!
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :feature
  config.include Warden::Test::Helpers, type: :feature
end
