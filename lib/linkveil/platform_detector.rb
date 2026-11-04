# frozen_string_literal: true

module Linkveil
  module PlatformDetector
    DOMAINS_LIST = {
      youtube: ['youtube.com', 'youtu.be'],
      tiktok: ['tiktok.com'],
      spotify: ['spotify.com']
    }.freeze

    def self.detect(host)
      return nil if host.nil?

      host = host.downcase

      DOMAINS_LIST.each do |platform, domains|
        return platform if domains.any? { |domain| matches_domain?(host, domain) }
      end

      nil
    end

    def self.matches_domain?(host, domain)
      host == domain || host.end_with?(".#{domain}")
    end
  end
end
