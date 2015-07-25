require 'rails_helper'

RSpec.describe "Notes", type: :request do
  let!(:user) { create User }
  let(:valid_session) { { user_id: user.id } }

  describe "GET /notes", pending: 'あとでなおす' do
    it "works! (now write some real specs)" do
      get notes_path, {}, valid_session
      expect(response).to have_http_status(200)
    end
  end
end
