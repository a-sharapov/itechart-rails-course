require 'rails_helper'

RSpec.describe StaticsController, type: :controller do
  context "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    let(:static) { Static.create(title: "Test Title", introtext: "Test intro") }
    it "returns a success response" do
      get :show, params: { id: static.id }
      expect(response).to have_http_status(200)
    end
    it "returns a 404 response if ID not found" do
      get :show, params: { id: :impossible_id }
      expect(response).to have_http_status(404)
    end
  end

end