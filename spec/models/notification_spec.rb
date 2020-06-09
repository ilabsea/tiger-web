require 'rails_helper'

RSpec.describe Notification, type: :model do
  it { is_expected.to belong_to(:notification) }
  it { is_expected.to validate_presence_of(:title)}
  it { is_expected.to validate_presence_of(:body)}
end
