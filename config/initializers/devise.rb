Devise.setup do |config|
  # The e-mail address that mail will appear to be sent from
  # If absent, mail is sent from "please-change-me-at-config-initializers-devise@example.com"
  config.mailer_sender = "door_monit@example.com"

  config.jwt do |jwt|
    jwt.secret = ENV['DEVISE_JWT_SECRET_KEY']

    jwt.dispatch_requests = [
      ['POST', %r{^/auth/sign_in$}],
    ]

    jwt.expiration_time = 1.day.to_i
  end

  # ==> ORM configuration
  # Load and configure the ORM. Supports :active_record (default) and
  # :mongoid (bson_ext recommended) by default. Other ORMs may be
  # available as additional gems.
  require 'devise/orm/active_record'

  # If using rails-api, you may want to tell devise to not use ActionDispatch::Flash
  # middleware b/c rails-api does not include it.
  # See: https://stackoverflow.com/q/19600905/806956
  config.navigational_formats = []
end