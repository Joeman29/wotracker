# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new({first_name: 'Yosef', last_name:'Gitlin', username:'Admin',
                 password:'rensle', password_confirmation:'rensle', city:'Beitar Illit',
                  country:'Israel', email:'yosef29@gmail.com'} )
user.save!
workout = Workout.create({name:'Upper Body Strength A', goal_time:45,
                       descript:'Total upper body strength training for all 5 major muscle groups.', user:user})
Segment.create([
    {
        name:'Warmup', sets:1, rest_time:70, workout:workout, exercises_attributes:[
                      {
                          name:'Run in place', kind:'Cardio/Aerobic', time:5, descript:'Slowly build from 1/10 to 5/10'
                      },
                      {
                          name:'Jumping Jacks', kind: 'Cardio/Aerobic', time:0.5, descript: '7/10 Intesity'
                      },
                      {
                          name:'Run in Place', kind:'Cardio/Aerobic', time:2, descript:'4/10 Intesity'
                      }

                      ]
    },
    {
        name:'Biceps and Shoulders', sets:3, rest_time:80, workout:workout
    },
    {
        name:'Triceps and Front Shoulders', sets:3, rest_time:80, workout:workout
    },
    {
        name:'Chest and Back', sets: 3, rest_time:80, workout:workout
    }
                     ])
