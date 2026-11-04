# frozen_string_literal: true

require 'uri'
require_relative 'linkveil/version'
require_relative 'linkveil/query_cleaner'
require_relative 'linkveil/platform_detector'

require_relative 'linkveil/sanitizer'
require_relative 'linkveil/sanitizers/youtube'
require_relative 'linkveil/sanitizers/spotify'

module Linkveil
  def self.clean(url)
    uri = URI.parse(url)

    sanitizer = Sanitizer.find_for(uri.host)

    return url if sanitizer.nil?

    sanitizer.clean(uri)
  rescue URI::InvalidURIError
    url
  end
end
