# == Schema Information
#
# Table name: user_answers
#
#  id          :integer          not null, primary key
#  user_uuid   :string(255)
#  question_id :integer
#  choice_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe UserAnswer do
  it { is_expected.to belong_to(:question) }
  it { is_expected.to belong_to(:choice) }
  it { is_expected.to validate_presence_of(:user_uuid)}
end
