# frozen_string_literal: true

require 'uri'
require_relative 'linkveil/version'
require_relative 'linkveil/query_cleaner'
require_relative 'linkveil/platform_detector'

require_relative 'linkveil/sanitizer'
require_relative 'linkveil/sanitizers/youtube'

module Linkveil
  def self.clean(url)
    uri = URI.parse(url)
    platform = PlatformDetector.detect(uri.host)

    case platform
    when :youtube
      QueryCleaner.clean(uri, remove: ['si'])
    else
      uri.to_s
    end
  end
end
