require 'rails_helper'

RSpec.describe Build, type: :model do
  it 'should be valid' do
    build = build(:build)
    expect(build).to be_valid
  end
end
