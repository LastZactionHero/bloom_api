# frozen_string_literal: true

require 'rails_helper'

# Tests for CombinationTemplatesController
describe CombinationTemplatesController do
  describe :index do
    it 'returns a list of CombinationTemplate' do
      get(:index)
    end
  end
end
