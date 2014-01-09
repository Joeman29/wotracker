class WOTracker.Collections.Exercises extends Backbone.Collection
  model: WOTracker.Models.Exercise
  comparator: 'position'
  initialize: ->
    @view = new WOTracker.Views.ExercisesIndex(collection: this)
    @on 'exercise_removed', @fix_positions
  fix_positions: ->
    count = 1
    for exercise in @models
      exercise.set position:count
      count++