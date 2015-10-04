require 'rails_helper'

RSpec.describe BuildsController, type: :controller do
  let(:build1) { create(:build) }
  let(:build2) { create(:build) }
  let(:build3) { create(:build) }
  let(:build4) { create(:build) }

  it 'should return all builds by default' do
    get :index, format: :json
    expect(assigns(:builds)).to match_array([build1, build2, build3, build4])

  end
end
