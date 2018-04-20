module PetstoreClient
  class Pet < ActiveResource::Base
    STATUS_VALUES = %w[available pending sold].freeze

    headers['X-API-Key'] = PetstoreClient[:api_key]
    self.collection_name = 'pet'

    class << self
      def find_by_status(statuses = [])
        statuses = Array(statuses)
        verify_statuses(statuses)

        find(:all, from: :findByStatus, params: {status: statuses.presence || STATUS_VALUES})
      end

      private

      def verify_statuses(statuses)
        return if statuses.blank?

        statuses.each do |status|
          raise ArgumentError, "Unknown status: #{status}." if STATUS_VALUES.exclude?(status.to_s)
        end
      end

      def query_string(options)
        "?#{URI.encode_www_form(options)}" unless options.nil? || options.empty?
      end
    end
  end
end
