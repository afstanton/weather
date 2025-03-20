require 'rails_helper'

# All functionality for this exists in the service class.
# This is just a stub to test the controller.
# If there was any real functionality in the controller, it would be tested here.
RSpec.describe "Weathers", type: :request do
  describe "GET /" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end
end
