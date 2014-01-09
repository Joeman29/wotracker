FactoryGirl.define do
  factory :user do
    first_name 'Bob'
    last_name 'Riley'
    password 'secret'
    sequence(:email) {|i| "bobRiley#{i}@12345.com" }
    sequence(:username) {|i| "bobbyboy#{i}"}
    city 'yehupitz'
    state 'Alabama'
    country 'United States'
    factory :user_with_workouts do
      after(:create) do |user|
        create_list(:workout, 5, user:user)
      end
    end
    factory :user_with_history do
      after(:create) do |user|
        create_list(:completed_workout, 5, user:user)
      end
    end
  end
  factory :workout do
    sequence(:name) {|i| "Workout #{i}"}
    goal_time {rand(6..9) * 5}
    association :user
    factory :loaded_workout do
      after(:create) do |workout|
        create_list(:segment, 5, workout: workout)
      end
    end
  end
  factory :segment do
    sequence(:name) {|i| "Superset #{i}"}
    association :workout
    factory :loaded_segment do
      after(:create) do |segment|
        create_list(:exercise, 3, segment: segment)
      end
    end
  end
  factory :exercise do
    association :segment
    name 'New Exercise'
    time 3
    reps 7
    weight 12
    weight_unit 'kg'
    factory :aerobic_exercise do
      name 'Jumping Jacks'
      kind 'Cardio/Aerobic'
    end
    factory :bodyweight_exercise do
      name 'Pushups'
      kind 'Bodyweight'
    end
    factory :lifting_exercise do
      name 'BB Shoulder Presses'
      kind 'Weight Lifting'
    end
    factory :stretch do
      name 'Hamstring Stetch'
      kind 'Stretch'
    end
  end


  factory :completed_workout do
    association :user
    sequence(:name) {|i| "Workout #{i}"}
    sequence(:date) {|i| Date.today - i.days }
    rating {rand(1..5)}
    goal_time {rand(6..9) * 5}
    time {rand(6..9) * 5}
    after(:create) do |completed_workout|
      create_list(:completed_segment, 4, completed_workout: completed_workout)
    end
  end
  factory :completed_segment do
    association :completed_workout
    sequence(:name) {|i| "Superset #{i}"}
    after(:create) do |completed_segment|
      create_list(:completed_exercise, 3, completed_segment: completed_segment)
    end
  end
  factory :completed_exercise do
    association :completed_segment
    sequence(:name) {|i| "Exercise #{i}"}
    timeset ['12', '38', '22']
  end
end
