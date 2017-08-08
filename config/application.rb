require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JhuCapstone
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    Mongoid.load!('./config/mongoid.yml')
    # when mongoid gem is added, it becomes the default ORM
    # for now we'd like to keep ActiveRecord as our default ORM with generators
    # and we can always supply --orm mongoid to generators in case we need mongoid to kick in
    config.generators { |g| g.orm :active_record }
    # config.generators { |g| g.orm :mongoid }

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"

        resource "*",
          headers: :any,
          expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
          methods: [:get, :post, :put, :delete, :options]
      end
    end

    config.generators do |g|
      g.test_framework :rspec,
        model_specs: true,
        routing_specs: false,
        controller_specs: false,
        helper_specs: false,
        view_specs: false,
        request_specs: true,
        policy_specs: false,
        feature_specs: true
    end

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
