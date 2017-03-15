require 'rails_helper'

describe BedTemplatesController do
  describe 'index' do
    it 'returns a list of BedTemplates' do
      FactoryGirl.create(:bed_template)

      get :index
      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(body.length).to eq(1)
    end
  end

  describe 'suggestions' do

    it 'returns a list of suggested templates' do
      bed_templates = FactoryGirl.create_list(:bed_template, 3)

      get :suggestions, params: { width: 30, depth: 6 }
      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(body.map{|bt| bt['id']}.sort).to eq(bed_templates.map{|bt| bt.id}.sort)
    end

    it 'sorts by best fit for dimension' do
      bed_template_fit_medium = FactoryGirl.create(:bed_template, config: {'name' => 'x', 'size' => {'design' => {'width' => 360, 'height' => 36}}, 'cell' => {'type' => 'EmptyGridCell'}}.to_json)
      bed_template_fit_best   = FactoryGirl.create(:bed_template, config: {'name' => 'x', 'size' => {'design' => {'width' => 360, 'height' => 72}}, 'cell' => {'type' => 'EmptyGridCell'}}.to_json)
      bed_template_fit_good   = FactoryGirl.create(:bed_template, config: {'name' => 'x', 'size' => {'design' => {'width' => 340, 'height' => 72}}, 'cell' => {'type' => 'EmptyGridCell'}}.to_json)
      bed_template_fit_worst  = FactoryGirl.create(:bed_template, config: {'name' => 'x', 'size' => {'design' => {'width' => 4, 'height' => 4}}, 'cell' => {'type' => 'EmptyGridCell'}}.to_json)
      bed_template_fit_bad    = FactoryGirl.create(:bed_template, config: {'name' => 'x', 'size' => {'design' => {'width' => 200, 'height' => 12}}, 'cell' => {'type' => 'EmptyGridCell'}}.to_json)

      get :suggestions, params: { width: 30, depth: 6 }
      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(body[0]['id']).to eq(bed_template_fit_best.id)
      expect(body[1]['id']).to eq(bed_template_fit_good.id)
      expect(body[2]['id']).to eq(bed_template_fit_medium.id)
      expect(body[3]['id']).to eq(bed_template_fit_bad.id)
      expect(body[4]['id']).to eq(bed_template_fit_worst.id)
    end

    it 'limits to the top 5 templates' do
      bed_templates = FactoryGirl.create_list(:bed_template, 10)

      get :suggestions, params: { width: 30, depth: 6 }
      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(body.length).to eq(5)
    end

    it 'returns an error if the dimensions are too small' do
      get :suggestions, params: { width: 2, depth: 2 }
      expect(response.status).to eq(400)

      body = JSON.parse(response.body)
      expect(body['errors']['width']).to eq(['is too small'])
      expect(body['errors']['depth']).to eq(['is too small'])
    end

    it 'returns an error if the dimensions are too large' do
      get :suggestions, params: { width: 101, depth: 101 }
      expect(response.status).to eq(400)

      body = JSON.parse(response.body)
      expect(body['errors']['width']).to eq(['is too large'])
      expect(body['errors']['depth']).to eq(['is too large'])
    end
  end

  describe 'create' do
    let(:config) { File.read("#{Rails.root}/spec/fixtures/bed_template_a.json") }

    it 'creates a BedTemplate' do
      expect(BedTemplate.count).to eq(0) # Assumption

      post :create, params: { config: config }
      expect(response.status).to eq(201)

      expect(BedTemplate.count).to eq(1)
      bed_template = BedTemplate.first

      body = JSON.parse(response.body)
      expect(body['id']).to eq(bed_template.id)
      expect(body['name']).to eq(JSON.parse(config)['name'])
      expect(body['config']).to eq(config)
    end

    it 'returns an error if the name is not provided in the config' do
      mod_config = JSON.parse(config)
      mod_config.delete('name')

      post :create, params: { config: mod_config.to_json }
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body)['errors']
      expect(errors['name']).to include('can\'t be blank')
    end

    it 'returns an error if the config is not valid JSON' do
      post :create, params: { config: 'not some json' }
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body)['errors']
      expect(errors['config']).to include('is not valid JSON')
    end

    it 'returns an error it the config is not a valid template' do
      post :create, params: { config: {name: 'Not a valid template', cell: 'whatever'}.to_json }
      expect(response.status).to eq(400)
      errors = JSON.parse(response.body)['errors']
      expect(errors['config']).to include('is not a valid template')
    end
  end

  describe 'update' do
    let(:bed_template){ FactoryGirl.create(:bed_template) }

    it 'updates the BedTemplate' do
      updated_name = 'Something else!'
      mod_config = JSON.parse(bed_template.config)
      mod_config['name'] = updated_name

      patch :update, params: { id: bed_template.id, config: mod_config.to_json }
      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(body['name']).to eq(updated_name)
    end
  end

  describe 'destroy' do
    let(:bed_template){ FactoryGirl.create(:bed_template) }

    it 'deletes the BedTemplate' do
      bed_template
      expect(BedTemplate.count).to eq(1) # Assumption

      delete :destroy, params: { id: bed_template.id }
      expect(response.status).to eq(200)

      expect(BedTemplate.count).to eq(0)
    end
  end

  describe 'placements' do
    let(:bed_template){ FactoryGirl.create(:bed_template) }
    let(:width) { 360 }
    let(:height) { 72 }

    it 'returns a coordinate rendering of the BedTemplate' do
      get :placements, params: { id: bed_template.id, width: width, height: height }
      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(body['width']).to eq(width)
      expect(body['height']).to eq(height)
      expect(body['placements']).to be_present
    end

    it 'returns a rendering with replacements from mapping' do
      plant = FactoryGirl.create(:plant, permalink: 'shrubby')

      expect_any_instance_of(BedTemplate).to receive(:render)
        .with(width, height, {'C' => plant})
        .and_return({})

      get :placements, params: { id: bed_template.id,
                                 width: width,
                                 height: height,
                                 template_plant_mapping: {
                                   'C' => plant.permalink
                                 }}
      expect(response.status).to eq(200)
    end
  end
end
