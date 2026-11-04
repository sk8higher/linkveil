# frozen_string_literal: true

module UrlGenerator
  PARAMS = %w[si t v list feature foo bar].freeze

  def self.generate(rng: Random.new)
    result = []

    rng.rand(0..6).times do
      result << [PARAMS.sample(random: rng), rng.rand(1000).to_s]
    end

    base = 'https://youtu.be/abc'
    query = URI.encode_www_form(result)

    query.empty? ? base : "#{base}?#{query}"
  end
end
