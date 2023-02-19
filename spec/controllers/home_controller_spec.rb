# frozen_string_literal: true

require 'rails_helper'

describe HomeController do
  describe 'GET index' do
    it 'renders successfully' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
