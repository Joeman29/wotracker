require 'spec_helper'

describe 'Play Page' do
  let(:user) {create(:user_with_workouts)}
  it 'should record completed workout successfully', js:true do
    login(user)
    workout = user.workouts.first
    visit play_user_workout_path(user_id: user.id, id:workout.id)
    json = '{"id":3,"name":"Test Workout","descript":"","goal_time":1,"user_id":1,"created_at":"2014-01-01T08:33:53.536Z","updated_at":"2014-01-01T08:33:53.536Z","time":53,"completed_segments_attributes":[{"id":6,"name":"New Superset","rest_time":5,"workout_id":3,"position":1,"sets":3,"created_at":"2014-01-01T08:33:58.740Z","updated_at":"2014-01-01T08:34:24.374Z","time":8,"completed_exercises_attributes":[{"id":24,"name":"DB Insanity","descript":null,"kind":"Weight Lifting","reps":5,"time":null,"position":1,"weight":5,"weight_unit":"kg","segment_id":6,"created_at":"2014-01-01T08:34:03.796Z","updated_at":"2014-01-01T08:34:14.097Z","timeset":[3,3,3]}]},{"id":7,"name":"New Superset","rest_time":5,"workout_id":3,"position":2,"sets":2,"created_at":"2014-01-01T08:34:00.370Z","updated_at":"2014-01-01T08:34:49.834Z","time":17,"completed_exercises_attributes":[{"id":25,"name":"Flex fingers","descript":null,"kind":"Cardio/Aerobic","reps":null,"time":0.1,"position":1,"weight":null,"weight_unit":null,"segment_id":7,"created_at":"2014-01-01T08:34:04.649Z","updated_at":"2014-01-01T08:34:44.079Z","timeset":[6,6]},{"id":26,"name":"Strech your mind","descript":null,"kind":"Stretch","reps":null,"time":0.1,"position":2,"weight":null,"weight_unit":null,"segment_id":7,"created_at":"2014-01-01T08:34:48.620Z","updated_at":"2014-01-01T08:35:00.865Z","timeset":[6,6]}]}]} '
    page.execute_script " $.post($('#workout-play-area').data('return-url'),
    {workout: #{json}}
    , function(data, response) {
      return console.log(response);
    });"
    visit log_user_path(id:user.id)
    page.find('#from_date').set(Date.today - 1.month)
    page.execute_script %Q{$('.from-date input').change()}  #manually fire change event
    user.should have(1).completed_workouts
  end
end