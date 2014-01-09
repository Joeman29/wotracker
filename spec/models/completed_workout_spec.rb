require 'spec_helper'

describe 'completed workouts' do
  let(:user) {create(:user_with_history)}
  it 'should exist' do
    user.completed_workouts.length.should > 0
    user.completed_workouts.first.name.should match /Workout */
  end
  its 'exercises should have timeset arrays' do
    user.completed_workouts.first.completed_segments.first.completed_exercises.first.timeset.should be_a_kind_of(Array)
  end
end