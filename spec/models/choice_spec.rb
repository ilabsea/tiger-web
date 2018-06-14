require 'rails_helper'

RSpec.describe Choice do
  it { is_expected.to belong_to(:question) }
  it { is_expected.to validate_presence_of(:label)}
end
