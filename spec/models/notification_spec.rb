require 'rails_helper'

RSpec.describe Notification, type: :model do
  it { is_expected.to belong_to(:creator).class_name('User') }
  it { is_expected.to belong_to(:story).optional }
  it { is_expected.to validate_presence_of(:body)}
end
