class WOTracker.Views.WorkoutView extends Backbone.View
  id: 'workout'
  template: JST['workouts/index']
  events:
      'dblclick h2 span': 'edit_value'
      'submit h2'   : 'change_value'
      'click button.new-segment' : 'new_segment'
  initialize: ->
    #@model.on 'change', @render, this
  firstLoad: ->
    @$el.html(@template(workout: @model.attributes))
    @$el.find("#workout-display").append(@model.segments.view.render().el)
    $('#workout-edit-area').html(@el)
  render: ->
    @$el.html(@template(workout: @model.attributes))
    $('#workout-edit-area').html(@el)
    @$el.find("#workout-display").append(@model.segments.view.render().el)
    @delegateEvents()
    this
  new_segment: ->
    newSeg = @model.segments.create({},{wait: true})
    @model.segments.add newSeg
  edit_value: (e)->
    targetTag = $(e.target)
    targetTag.text('')
    $("<form><input type='text' name='#{targetTag.data('workout')}'></form>").appendTo(targetTag)
  change_value: (e)->
    e.preventDefault()
    input = $(e.target).find('input')
    attr = input.attr('name')
    @model.attributes[attr] = input.val()
    #@model.save()
    @render()