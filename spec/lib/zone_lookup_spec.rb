require 'rails_helper'

describe ZoneLookup do
  describe 'by_zipcode' do
    it 'returns a zone for a zipcode' do
      expect(ZoneLookup.by_zipcode('28423')).to eq('7')
      expect(ZoneLookup.by_zipcode('54499')).to eq('5')
      expect(ZoneLookup.by_zipcode('33449')).to eq('10')
    end

    it 'returns nil if a zipcode is not valid' do
      expect(ZoneLookup.by_zipcode('invalid')).to be_nil
    end
  end
end