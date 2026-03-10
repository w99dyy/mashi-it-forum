require 'rails_helper'

RSpec.describe "Wallets", type: :request do
  describe "POST /connect" do
    it "returns http success" do
      post "/wallet/connect"

      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /disconnect" do
    it "returns http success" do
      post "/wallet/disconnect"

      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /wallet/check_availability" do
    it "returns http success" do
      post "/wallet/check_availability"

      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end
end
