require 'rails_helper'

RSpec.describe RegisteredToken, type: :model do
  it { is_expected.to validate_presence_of(:token)}
end
