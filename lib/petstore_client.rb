require 'petstore_client/version'
require 'petstore_client/engine'

module PetstoreClient
  extend SingleForwardable

  def_delegators 'Rails.configuration.app[:petstore_client]', :[], :[]=, :fetch
end
