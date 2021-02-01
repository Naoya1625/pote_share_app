require 'rails_helper'

RSpec.describe "UsersApi", type: :request do
  describe "GET /users_apis" do
    it "works! (now write some real specs)" do
      get new_user_registration_path
      expect(response).to have_http_status(200)
    end
  end
end
