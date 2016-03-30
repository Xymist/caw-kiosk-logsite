# Load the Rails application.
require File.expand_path('../application', __FILE__)

ActionMailer::Base.smtp_settings[:openssl_verify_mode] = false
ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false

# Initialize the Rails application.
Rails.application.initialize!
