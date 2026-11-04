# frozen_string_literal: true

module Linkveil
  module QueryCleaner
    def self.clean(uri, remove:)
      return uri.to_s if uri.query.nil?

      fragments = uri.query.split('&', -1)

      filtered = fragments.reject do |fragment|
        key = fragment.partition('=').first
        decoded_key = URI.decode_www_form_component(key)

        remove.include?(decoded_key)
      end

      new_query = filtered.join('&')

      uri.query = new_query.empty? ? nil : new_query
      uri.to_s
    end
  end
end
