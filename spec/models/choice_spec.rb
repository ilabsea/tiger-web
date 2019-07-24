# == Schema Information
#
# Table name: choices
#
#  id          :integer          not null, primary key
#  label       :string(255)
#  answered    :boolean          default(FALSE)
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Choice do
  it { is_expected.to belong_to(:question) }
  it { is_expected.to validate_presence_of(:label)}
end
