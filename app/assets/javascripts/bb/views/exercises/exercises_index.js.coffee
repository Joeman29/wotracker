class WOTracker.Views.ExercisesIndex extends Backbone.View
  tagName: 'tbody'
  template: JST['exercises/index']
  events: {
    'sortupdate' : 'newSort'
  }
  initialize: ->
    @collection.on 'reset', @render, this
    @collection.on 'add', @appendExercise, this
  render: ->
    $(@el).html(@template())
    for exercise in @collection.models
      $(@el).append(exercise.view.render().el)
      @$el.sortable()
    @delegateEvents()
    this
  appendExercise: (ex)->
    @$el.append(ex.view.render().el)
  newSort: (event, ui)->
    count = 1
    for row in @$el.find("tr:not(.jquery-ui-placeholder)")
      position = parseInt($($(row).find("td")[0]).text())
      exercise = @collection.at(position - 1)
      exercise.set 'position', count
      count++
    @collection.sort()
