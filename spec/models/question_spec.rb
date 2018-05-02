require 'rails_helper'

RSpec.describe Question do
  it { is_expected.to belong_to(:story) }
  it { is_expected.to have_many(:choices).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:label)}
  it { is_expected.to accept_nested_attributes_for(:choices) }
end
