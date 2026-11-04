# frozen_string_literal: true

module Linkveil
  module QueryCleaner
    def self.clean(uri, remove:)
      params = URI.decode_www_form(uri.query.to_s)

      rejected = params.reject { |key, _| remove.include?(key) }

      new_params = URI.encode_www_form(rejected)
      uri.query = new_params.empty? ? nil : new_params

      uri.to_s
    end
  end
end
