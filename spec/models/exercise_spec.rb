#require 'test/spec'
require 'spec_helper'

describe Exercise do
  describe 'Exercise properly normalizes values' do
    it 'has weight and weight unit if kind is Weight Lifting' do
      exercise = FactoryGirl.create(:lifting_exercise)
      exercise.should be_weight
      exercise.should be_reps
      exercise.should be_weight_unit
      exercise.should_not be_time
    end
    it 'has time but not weight etc. if kind is Cardio' do
      exercise = FactoryGirl.create(:aerobic_exercise)
      exercise.should be_time
      exercise.should_not be_reps
      exercise.should_not be_weight
      exercise.should_not be_weight_unit
    end
    it 'has time but not weight etc. if kind is Bodyweight' do
      exercise = FactoryGirl.create(:bodyweight_exercise)
      exercise.should be_reps
      exercise.should_not be_weight
      exercise.should_not be_weight_unit
      exercise.should_not be_time
    end
    it 'has time but not weight etc. if kind is Stretch' do
      exercise = FactoryGirl.create(:stretch)
      exercise.should be_time
      exercise.should_not be_reps
      exercise.should_not be_weight
      exercise.should_not be_weight_unit
    end

  end
  describe 'Exercise has correct position' do
    context 'has correct user' do
      it 'responds to user method' do
        exercise.user.first_name.should == FactoryGirl.build(:user).first_name
      end
    end
    let(:exercise) { FactoryGirl.create(:lifting_exercise) }
    it 'has correct positioning when is first' do
      exercise.position.should == 1
    end
    it 'increments position' do
      exercise2 = FactoryGirl.build(:aerobic_exercise)
      exercise2.segment = exercise.segment
      exercise2.save!
      exercise2.position.should == 2
    end

  end

end