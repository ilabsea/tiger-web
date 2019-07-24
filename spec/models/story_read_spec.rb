# == Schema Information
#
# Table name: story_reads
#
#  id            :integer          not null, primary key
#  story_id      :integer
#  finished_at   :datetime
#  quiz_finished :boolean
#  user_uuid     :string(255)
#  user_type     :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe StoryRead do
  it { is_expected.to belong_to(:story) }
end
