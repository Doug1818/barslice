Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stripe_connect, ENV['STRIPE_CONNECT_CLIENT_ID'], ENV['STRIPE_SECRET'], :scope => 'read_write' # or :scope => 'read_only'
end

OmniAuth.config.logger = Rails.logger