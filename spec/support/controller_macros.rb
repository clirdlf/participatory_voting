# frozen_string_literal: true

##
# Controller Macros
# @see https://www.matthewhoelter.com/2019/09/12/setting-up-and-testing-rails-6.0-with-rspec-factorybot-and-devise.html
module ControllerMacros
  def login_user
    # Before each test, create and login the user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      # user.confirm!
      # Or set a confirmed_at inside the factory. Only necessary if you are
      # using the "confirmable" module
      sign_in user
    end
  end
end
