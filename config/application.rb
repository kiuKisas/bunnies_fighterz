require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BunniesFighterz
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.assets.paths << Rails.root.join("multipurpose_bookshelf_slider")
    config.assets.js_compressor = Uglifier.new(harmony: true)
    config.load_defaults 5.2
    config.browser_validations = true
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
      g.template_engine = :slim
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
