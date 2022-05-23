require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Dotenv::Railtie.load

module Agate
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local

    config.eager_load_paths += %W(#{config.root}/lib)


    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.locale = "zh-CN"
    config.i18n.default_locale = "zh-CN"
    I18n.enforce_available_locales = false

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '/wx_advises/*', :headers => :any, :methods => [:post]
        resource '/wx_essays/*', :headers => :any, :methods => [:get]
        resource '/wx_learnctgs/*', :headers => :any, :methods => [:get]
        resource '/wx_lawctgs/*', :headers => :any, :methods => [:get]
        resource '/wx_notices/*', :headers => :any, :methods => [:get]
        resource '/wx_qesbanks/*', :headers => :any, :methods => [:get]
        resource '/wx_users/*', :headers => :any, :methods => [:get, :post, :put]
      end
    end

    config.generators do |g|
      g.test_framework  :test_unit, fixture: false
      g.javascripts     false
    end
  end
end
