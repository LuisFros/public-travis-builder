require 'rails_helper'

RSpec.describe "Rooms", type: :request do
    let(:user) {User.create!}

    it "creates a Room" do
        headers = { "ACCEPT" => "application/json" }
        post "/rooms", :params => { :name => 'TestRoom', :user_id=>user.id }, :headers => headers
    
        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:ok)
      end

    it "shows Rooms" do
        headers = { "ACCEPT" => "application/json" }
        get "/rooms", :headers => headers

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:ok)
    end
end
