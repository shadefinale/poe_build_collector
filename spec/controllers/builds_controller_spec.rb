require 'rails_helper'

RSpec.describe BuildsController, type: :controller do
  let!(:build1) { create(:build) }
  let!(:build2) { create(:build) }
  let!(:build3) { create(:build) }
  let!(:build4) { create(:build) }
  let!(:build5) { create(:build) }
  let!(:build6) { create(:build) }
  let!(:build7) { create(:build) }

  after :each do
    Build.destroy_all
  end

  it 'should get all builds by default' do
    get :index, format: :json
    expect(assigns(:builds)).to match_array([build1, build2, build3,
                                             build4, build5, build6, build7])
  end
end
