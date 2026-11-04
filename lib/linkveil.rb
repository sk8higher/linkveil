# frozen_string_literal: true

require 'uri'
require_relative 'linkveil/version'

module Linkveil
  def self.clean(url)
    uri = URI.parse(url)
    params = URI.decode_www_form(uri.query.to_s)

    rejected = params.reject do |key, _value|
      key == 'si'
    end

    new_params = URI.encode_www_form(rejected)
    uri.query = new_params.empty? ? nil : new_params

    uri.to_s
  end
end
