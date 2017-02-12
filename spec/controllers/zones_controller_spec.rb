require 'rails_helper'

describe ZonesController do
  describe 'search' do
    it 'returns the zone for a zipcode' do
      get(:search, params: { zipcode: '46240' } )
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body['zone']).to eq('5')
    end

    it 'returns an error if the zipcode is not valid' do
      get(:search, params: { zipcode: 'invalid' } )
      expect(response.status).to eq(400)
      body = JSON.parse(response.body)
      expect(body['errors']['zone']).to eq(['is not valid'])
    end

    it 'returns an error if the zipcode is not provided' do
      get(:search )
      expect(response.status).to eq(400)
      body = JSON.parse(response.body)
      expect(body['errors']['zone']).to eq(['must be provided'])
    end
  end
end