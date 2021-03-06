require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blazon
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Include the authenicity token in remote forms
    config.action_view.embed_authenticity_token_in_remote_forms = true
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.i18n.default_locale = :en
    config.i18n.fallbacks = [:en]
    config.i18n.available_locales = [:en] # your list of available locales here
  end
end
