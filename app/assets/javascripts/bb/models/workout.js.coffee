class WOTracker.Models.Workout extends Backbone.Model
  initialize: ->
    @url = $("#workout-edit-area").data('loadurl')
    @segments =  new WOTracker.Collections.Segments(parent: this)
    @segments.url = "#{@url}/segments/"
    @view = new WOTracker.Views.WorkoutView({model: this})
    @on 'change', ->
      if @.isValid()
        @save()
      else
        @attributes = @previousAttributes()
    @fetch(success: @initialLoad, error: @firstLoadError)
  initialLoad: (model, response, options)->
    model.segments.reset(model.get('segments'))
    model.view.firstLoad()
  validate: (attrs, options)->
    if(attrs.name.length < 1 || attrs.goal_time < 1)
      return 'Cannot be blank'
    unless $.isNumeric(attrs.goal_time)
      return 'Time must be a number'
  firstLoadError: (obj, resp)->
    console.log resp
