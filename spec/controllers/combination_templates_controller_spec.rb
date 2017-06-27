# frozen_string_literal: true

require 'rails_helper'

describe CombinationTemplatesController do
  describe 'index' do
    it 'returns a list of CombinationTemplates' do
      FactoryGirl.create_list(:combination_template, 3)

      get :index
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(CombinationTemplate.count)
    end
  end
end
