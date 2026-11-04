# frozen_string_literal: true

module Linkveil
  class Sanitizer
    @registry = []

    class << self
      attr_reader :registry

      def inherited(subclass)
        Linkveil::Sanitizer.registry << subclass
        super
      end

      def domains(*names)
        if names.any?
          @domains = names
        else
          @domains
        end
      end

      def remove_params(*names)
        if names.any?
          @remove_params = names
        else
          @remove_params
        end
      end

      def find_for(host)
        return nil if host.nil?

        host = host.downcase

        @registry.find do |sanitizer|
          Array(sanitizer.domains).any? do |domain|
            PlatformDetector.matches_domain?(host, domain)
          end
        end
      end

      def clean(uri)
        QueryCleaner.clean(uri, remove: remove_params)
      end
    end
  end
end
