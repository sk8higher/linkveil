# frozen_string_literal: true

module Linkveil
  class Sanitizer
    @registry = []

    class << self
      attr_reader :registry

      def inherited(subclass)
        registry << subclass
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
    end
  end
end
