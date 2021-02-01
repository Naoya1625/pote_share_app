require 'rails_helper'

RSpec.describe "SessionsApi", type: :request do
  describe "GET /sessions_apis" do
    it "ログイン画面にアクセスできること" do
      get new_user_session_path
      expect(response).to have_http_status(200)
    end
  end
end
