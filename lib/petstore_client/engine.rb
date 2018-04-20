require 'active_resource'
require 'rails'

module PetstoreClient
  class Engine < Rails::Engine
    isolate_namespace PetstoreClient

    initializer :petstore_client_config, after: :load_config_initializers do |app|
      app.config.app = {} unless app.config.respond_to?(:app)
      app.config.app[:petstore_client] ||= {}
      app.config.app[:petstore_client].reverse_update(
        api_key: 'token'
      )

      ActiveResource::Base.tap do |ar|
        ar.site = 'http://petstore.swagger.io/v2/'
        ar.include_format_in_path = false
        ar.timeout = 15.seconds
      end
    end
  end
end
