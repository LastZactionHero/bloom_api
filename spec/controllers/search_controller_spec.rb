require 'rails_helper'

describe SearchController do
  describe 'random' do
    it 'selects a random plant' do
      plant_a = FactoryGirl.create(:plant)
      plant_b = FactoryGirl.create(:plant)

      get :random
      expect(response.status).to eq(200)

      plant_body = JSON.parse(response.body)
      expect(Plant.find_by(permalink: plant_body['permalink'])).to be_present
    end

    it 'filters by zone' do
      zone = FactoryGirl.create(:zone, name: '5')
      plant_in_zone = FactoryGirl.create(:plant, zones: [zone])
      plant_not_in_zone = FactoryGirl.create(:plant, zones: [])

      get :random, params: { zone: zone.name }
      expect(response.status).to eq(200)

      plant_body = JSON.parse(response.body)
      expect(plant_body['permalink']).to eq(plant_in_zone.permalink)
    end

     it 'returns an error if the zone is not valid' do
       get :random, params: { zone: 'invalid' }
       expect(response.status).to eq(400)
       body = JSON.parse(response.body)
       expect(body['errors']['zone']).to include('is not valid')
     end
  end

  describe 'similar' do
    before do
      (-2..2).step(0.1).to_a.each do |si|
        FactoryGirl.create(:plant, similarity_index: si)
      end
    end
    let(:plant) { Plant.find_by(similarity_index: 0.0) }

    it 'returns a list of similar plants, sorted by similiarity index abs value' do
      get :similar, params: { permalink: plant.permalink }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(10)

      similarity_indexes = body.map { |p| p['similarity_index'] }
      expect(similarity_indexes).to eq(similarity_indexes.sort {|a,b| a.abs <=> b.abs})
    end

    describe 'zone' do
      it 'returns a list filtered by zone' do
        zone = FactoryGirl.create(:zone, name: '5')
        plant_in_zone = FactoryGirl.create(:plant, similarity_index: 100, zones: [zone])

        get :similar, params: { permalink: plant.permalink, zone: zone.name }

        body = JSON.parse(response.body)
        expect(body.length).to eq(1)
        expect(body[0]['permalink']).to eq(plant_in_zone.permalink)
      end

      it 'returns an error if the zone is invalid' do
        get :similar, params: { permalink: plant.permalink, zone: 'invalid' }
        expect(response.status).to eq(400)
        body = JSON.parse(response.body)
        expect(body['errors']['zone']).to include('is not valid')
      end
    end

    it 'returns a list of requested result count size' do
      get :similar, params: { permalink: plant.permalink, result_count: 3 }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(3)
    end

    it 'returns an error if the source plant is not found' do
      get :similar, params: { permalink: 'not_a_real_plant' }
      expect(response.status).to eq(404)
    end
  end
end