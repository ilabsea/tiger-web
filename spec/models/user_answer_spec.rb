require 'rails_helper'

RSpec.describe UserAnswer do
  it { is_expected.to belong_to(:question) }
  it { is_expected.to belong_to(:choice) }
  it { is_expected.to validate_presence_of(:user_uuid)}
end
