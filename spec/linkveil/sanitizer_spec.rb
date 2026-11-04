# frozen_string_literal: true

RSpec.describe Linkveil::Sanitizer do
  describe '.inherited' do
    it 'automatically registers subclasses' do
      sanitizer = Class.new(described_class)

      expect(described_class.registry).to include(sanitizer)
    end
  end

  describe '.find_for' do
    it 'finds YouTube sanitizer' do
      expect(described_class.find_for('youtu.be'))
        .to eq(Linkveil::Sanitizers::YouTube)
    end

    it 'matches subdomains' do
      expect(described_class.find_for('www.youtube.com'))
        .to eq(Linkveil::Sanitizers::YouTube)
    end

    it 'returns nil for unknown domains' do
      expect(described_class.find_for('example.com')).to be_nil
    end
  end
end
