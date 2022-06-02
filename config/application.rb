require_relative "boot"

require "rails/all"


Bundler.require(*Rails.groups)

module Opentodo
  class Application < Rails::Application
    config.load_defaults 7.0
    config.time_zone = 'Europe/Moscow'
    config.i18n.available_locales = %i[en ru]
    config.i18n.default_locale = :ru
  end
end
