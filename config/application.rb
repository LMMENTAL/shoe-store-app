require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShoeStoreTracker
  class Application < Rails::Application
    config.autoload_paths << "#{config.root}/lib"

    # config.cache_store = :redis_store, 'redis://1.0.0.127:6379/0/cache', { expires_in: 90.minutes }

    config.active_record.observers = :inventory_observer
  end
end