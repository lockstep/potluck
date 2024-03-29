#login_as may not work with Poltergeist when js is enabled, below is how to fix
#ref: https://github.com/railscasts/391-testing-javascript-with-phantomjs/blob/master/checkout-after/spec/support/share_db_connection.rb
#ref: https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara#capybara-and-poltergeist
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
